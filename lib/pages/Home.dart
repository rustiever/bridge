import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class Home extends StatefulWidget {
  final User ll;

  const Home({Key key, this.ll}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  upload(String url) async {
    String filename = await FilePicker.getFilePath(allowedExtensions: ['csv']);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile.fromString('csv', filename, filename: 'hello.csv'));
    http.StreamedResponse res = await request.send();
    print(res.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(children: [
              Text(widget?.ll?.email ?? 'none'),
              Text(widget?.ll?.token ?? 'none'),
              RaisedButton(
                onPressed: () {},
                child: Text('upload'),
              )
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await FirebaseAuthService().signOut();
            Navigator.pop(context);
          },
          child: Text('out'),
        ),
      ),
    );
  }
}
