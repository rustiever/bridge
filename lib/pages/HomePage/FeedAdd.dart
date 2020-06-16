import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Repository.dart';
import 'package:bridge/Utils/device.dart';
import 'package:bridge/models/Users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:image/image.dart' as Im;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FeedAdd extends StatefulWidget {
  @override
  _FeedAddState createState() => _FeedAddState();
}

class _FeedAddState extends State<FeedAdd> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  List<Option> op = [];
  File imageFile;
  TextEditingController _captionController;
  final _repository = Repository();
  TabController tabController;
  ScrollController controller;
  TextEditingController _question;
  TextEditingController _option;

  int _stackIndex = 0;
  var char = 65;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _captionController = TextEditingController();
    controller = ScrollController();
    _question = TextEditingController();
    // _option = TextEditingController();
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

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camara'),
                onTap: () => {
                  _pickImage('Camera').then(
                    (selectedImage) {
                      setState(
                        () {
                          imageFile = selectedImage;
                        },
                      );
                    },
                  )
                },
              ),
              new ListTile(
                leading: new Icon(Icons.grid_on),
                title: new Text('Gallery'),
                onTap: () => {
                  _pickImage('Gallery').then(
                    (selectedImage) {
                      setState(
                        () {
                          imageFile = selectedImage;
                        },
                      );
                    },
                  )
                },
              ),
            ],
          ),
        );
      },
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
                    postContainer(context),
                    pollContainer(),
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

  Widget pollContainer() {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (val) {
            if (val.isEmpty) {
              return "can't send blank line";
            }
            return null;
          },
          controller: _question,
          decoration: InputDecoration(
            hintText: 'question/topic',
          ),
        ),
        TextFormField(
          controller: _option,
          decoration: InputDecoration(
            hintText: 'options',
          ),
          onFieldSubmitted: (text) {
            if (text.isNotEmpty) {
              op.add(
                Option(text),
              );
              // _option.clear();
              setState(() {});
            }
          },
        ),
        Container(
          height: 200,
          child: ReorderableListView(
            header: Text('options will appear here'),
            children: List.generate(op.length, (index) {
              return InkWell(
                onDoubleTap: () => setState(() => op.removeAt(index)),
                key: ValueKey("value$index"),
                child: ListTile(
                  leading: Icon(Icons.sort),
                  title: Text(op[index].option),
                ),
              );
            }),
            onReorder: (oldi, newi) => setState(
              () => _reorder(oldi, newi),
            ),
          ),
        ),
        RaisedButton(onPressed: pollPost)
      ],
    );
  }

  void _reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final Option old = op.removeAt(oldIndex);

    op.insert(newIndex, old);
  }

  Widget postContainer(BuildContext context) {
    return Column(
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
              hintText: 'Announcements/ Share somthing....',
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
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            _settingModalBottomSheet(context);
          },
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

  pollPost() async {
    if (_formKey.currentState.validate() && op.length >= 2) {
      FirebaseUser user = await _repository.getCurrentUser();
      if (user != null) {
        User uuser = (await _repository.retrieveUserDetails(user));
        var map = {for (var v in op) v.option: 0};
        print(map);
        await _repository.addPollToDb(uuser, map, _question.text);
      } else {
        print('user null');
      }
    }
  }
}

class Option {
  final String option;
  Option(this.option);
}
