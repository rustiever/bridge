import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

import 'antry.dart';
import 'auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _auth = AuthService();

  get user async => _auth.uid;

  File _img;
  String _uploadedFileURL;

  var _con1 = TextEditingController();
  var _con2 = TextEditingController();
  final CollectionReference deb = Firestore.instance.collection('try');

  // Future chooseFile() async {
  //   await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
  //     setState(() {
  //       _img = image;
  //     });
  //   });
  // }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('ttry/${Path.basename(_img.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_img);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(fileURL);
      });
    });
  }

  Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.brown,
          appBar: AppBar(
            title: Text('title'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () async {
                    await _auth.signOut();
                  },
                  child: Icon(Icons.person))
            ],
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _con1,
                ),
                TextFormField(
                  controller: _con2,
                ),
                FlatButton(
                  onPressed: () async {
                    Firestore.instance.collection('ppost').document().setData({
                      'title': _con1.text,
                      'desc': _con2.text,
                      'imgUrl': _uploadedFileURL
                    });
                    print(_con1.text);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('send'),
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.camera_front),
                //   onPressed: () async => await pick(),
                // ),
                Container(
                    height: 250,
                    child: this._img == null
                        ? Placeholder()
                        : Image.file(this._img)),
                SizedBox(
                  height: 50,
                ),
                // Container(
                //     height: 200,
                //     child: _uploadedFileURL != null
                //         ? Image(image: NetworkImage(_uploadedFileURL))
                //         : Placeholder()),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AllinOne()));
            },
          )),
    );
  }

  // Future<Null> pick() async {
  //   final File imgg = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() => this._img = imgg);
  //   uploadFile();
  // }
}
