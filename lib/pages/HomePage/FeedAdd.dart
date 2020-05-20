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
      barrierDismissible: false,
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

  // @override
  // Widget build(BuildContext context) {
  //   MediaQueryData sd = MediaQuery.of(context);
  //   return SafeArea(
  //     child: Scaffold(
  //       resizeToAvoidBottomPadding: false,
  //       // appBar: AppBar(
  //       //   // backgroundColor: Colors.white,
  //       //   title: Text('what you wanna post???'),
  //       // ),
  //       body: GFTabs(
  //         indicator: BoxDecoration(
  //           gradient: LinearGradient(
  //             colors: [Color(0xff374ABE), Color(0xff64B6FF)],
  //             begin: Alignment.centerLeft,
  //             end: Alignment.centerRight,
  //           ),
  //           borderRadius: BorderRadius.circular(30.0),
  //         ),
  //         labelColor: Colors.yellowAccent,
  //         height: double.infinity,
  //         initialIndex: 0,
  //         length: 2,
  //         tabBarHeight: 50,
  //         tabs: <Widget>[
  //           Tab(
  //             child: Text(
  //               "Post",
  //             ),
  //           ),
  //           Tab(
  //             child: Text(
  //               "Poll",
  //             ),
  //           ),
  //         ],
  //         tabBarView: GFTabBarView(
  //           children: <Widget>[
  //             Container(
  //               child: Column(
  //                 children: <Widget>[
  //                   GFCard(
  //                     boxFit: BoxFit.cover,
  //                     // imageOverlay: NetworkImage(
  //                     //     'https://images.unsplash.com/photo-1511933801659-156d99ebea3e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
  //                     title: GFListTile(
  //                       // avatar: GFAvatar(),
  //                       title: Text(
  //                         "What's in your mind???",
  //                         style: TextStyle(fontSize: 25),
  //                       ),
  //                       // subTitle: Text('subtitle'),
  //                     ),
  //                     content: TextField(
  //                       textAlign: TextAlign.center,
  //                       decoration: InputDecoration(
  //                         hintText: 'caption....',
  //                       ),
  //                     ),
  //                     buttonBar: GFButtonBar(
  //                       //  alignment: MainAxisAlignment.center,
  //                       children: <Widget>[
  //                         Row(
  //                           children: <Widget>[
  //                             Expanded(
  //                               child: GFButton(
  //                                 onPressed: () async {
  //                                   FirebaseUser user =
  //                                       await _repository.getCurrentUser();
  //                                   String url;
  //                                   if (user != null) {
  //                                     if (imageFile != null) {
  //                                       compressImage();
  //                                       url = await _repository
  //                                           .uploadImageToStorage(imageFile);
  //                                     }
  //                                     User uuser = (await _repository
  //                                         .retrieveUserDetails(user));
  //                                     await _repository.addPostToDb(
  //                                         uuser,
  //                                         url ?? 'no image',
  //                                         _captionController.text);
  //                                     Navigator.pushReplacementNamed(
  //                                         context, FeedRoute);
  //                                   } else {
  //                                     print('user null');
  //                                   }
  //                                 },
  //                                 text: 'Post',
  //                               ),
  //                             ),
  //                             IconButton(
  //                                 icon: Icon(Icons.add_a_photo),
  //                                 onPressed: _showImageDialog),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   Container(
  //                     // height:
  //                     child: Stack(
  //                       children: [
  //                         imageFile == null
  //                             ? Center(child: Text('No image selected.'))
  //                             : Container(
  //                                 color: Colors.orangeAccent,
  //                                 // height: sd.size.height / 4,
  //                                 // width: double.infinity,
  //                                 child: Image.file(imageFile),
  //                               ),
  //                         IconButton(
  //                           icon: Icon(Icons.remove_circle),
  //                           onPressed: () {
  //                             setState(
  //                               () {
  //                                 imageFile = null;
  //                               },
  //                             );
  //                           },
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //             Container(
  //               child: Icon(Icons.directions_bike),
  //               color: Colors.red,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
          body: Form(
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
                            'https://images.unsplash.com/photo-1511933801659-156d99ebea3e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80'),
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
                            hintText: 'caption....',
                          ),
                        ),
                        buttonBar: GFButtonBar(
                          //  alignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GFButton(
                              onPressed: post,
                              text: 'Share',
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: _showImageDialog,
                        child: Container(
                          height: dHiegt(context) / 2,
                          child: Stack(
                            children: [
                              imageFile == null
                                  ? Text('No image selected.')
                                  : Container(
                                      color: Colors.orangeAccent,
                                      // height: sd.size.height / 4,
                                      // width: double.infinity,
                                      child: Image.file(imageFile),
                                    ),
                              IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () {
                                  setState(
                                    () {
                                      imageFile = null;
                                    },
                                  );
                                },
                              )
                            ],
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
        ),
      ),
    );
  }

  post() async {
    if (_formKey.currentState.validate() || imageFile != null) {
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
