import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Repository.dart';
import 'package:bridge/Utils/device.dart';
import 'package:bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image_picker/image_picker.dart';

class FeedAdd extends StatefulWidget {
  @override
  _FeedAddState createState() => _FeedAddState();
}

class _FeedAddState extends State<FeedAdd> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  File imageFile;
  var _captionController;
  final _repository = Repository();
  TabController tabController;
  ScrollController controller;

  int _stackIndex = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _captionController = TextEditingController();
    controller = ScrollController();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<File> _pickImage(String action) async {
    File selectedImage;

    action == 'Gallery'
        ? selectedImage =
            await ImagePicker.pickImage(source: ImageSource.gallery)
        : selectedImage =
            await ImagePicker.pickImage(source: ImageSource.camera);

    return selectedImage;
  }

  _showImageDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: ((context) {
        return SimpleDialog(
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Choose from Gallery'),
              onPressed: () {
                _pickImage('Gallery').then(
                  (selectedImage) {
                    setState(() {
                      imageFile = selectedImage;
                    });
                  },
                );
              },
            ),
            SimpleDialogOption(
              child: Text('Take Photo'),
              onPressed: () {
                _pickImage('Camera').then(
                  (selectedImage) {
                    setState(
                      () {
                        imageFile = selectedImage;
                      },
                    );
                  },
                );
              },
            ),
            SimpleDialogOption(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }),
    );
  }

  void compressImage() async {
    print('starting compression');
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = Random().nextInt(10000);

    Im.Image image = Im.decodeImage(imageFile.readAsBytesSync());
    Im.copyResize(image, height: 500, width: 500);

    var newim2 = new File('$path/img_$rand.jpg')
      ..writeAsBytesSync(Im.encodeJpg(image, quality: 85));

    setState(() {
      imageFile = newim2;
    });
    print('done');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: NestedScrollView(
          controller: controller,
          headerSliverBuilder: (BuildContext context, bool scrolled) {
            return [
              SliverAppBar(
                bottom: TabBar(
                  controller: tabController,
                  tabs: <Widget>[
                    Tab(
                      child: Text(
                        "Post",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Poll",
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: IndexedStack(
            index: _stackIndex,
            children: [
              Form(
                key: _formKey,
                child: GFTabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      // height: dHiegt(context),
                      child: Column(
                        children: <Widget>[
                          GFCard(
                            boxFit: BoxFit.cover,
                            imageOverlay: NetworkImage(
                                'https://images.unsplash.com/photo-1515462277126-2dd0c162007a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'),
                            title: GFListTile(
                              // avatar: GFAvatar(),
                              title: Text(
                                "What's in your mind???",
                                style: TextStyle(fontSize: 25),
                              ),
                              // subTitle: Text('subtitle'),
                            ),
                            content: TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: 'share somthing....',
                              ),
                            ),
                            buttonBar: GFButtonBar(
                              //  alignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GFButton(
                                      onPressed: post,
                                      text: 'Share',
                                    ),
                                    IconButton(
                                        color: Colors.blueAccent,
                                        icon: Icon(Icons.add_a_photo),
                                        onPressed: _showImageDialog)
                                  ],
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            // onTap: _showImageDialog,
                            child: Container(
                              height: dHiegt(context) / 2,
                              child: imageFile == null
                                  ? Center(child: Text('No image selected.'))
                                  : Container(
                                      color: Colors.orangeAccent,
                                      // height: sd.size.height / 4,
                                      // width: double.infinity,
                                      child: InkWell(
                                          onDoubleTap: () {
                                            setState(() => imageFile = null);
                                          },
                                          child: Image.file(imageFile)),
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Icon(Icons.directions_bike),
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ),
    );
  }

  post() async {
    if (_formKey.currentState.validate() || imageFile != null) {
      setState(() => _stackIndex = 1);
      FirebaseUser user = await _repository.getCurrentUser();
      String url;
      if (user != null) {
        if (imageFile != null) {
          compressImage();
          url = await _repository.uploadImageToStorage(imageFile);
        }
        User uuser = (await _repository.retrieveUserDetails(user));
        await _repository.addPostToDb(
            uuser, url ?? 'no image', _captionController.text);
        Navigator.pushReplacementNamed(context, FeedRoute);
      } else {
        print('user null');
      }
    }
  }
}
