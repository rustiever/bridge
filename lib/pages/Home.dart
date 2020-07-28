import 'package:Bridge/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final dynamic ll;

  const Home({Key key, this.ll}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> gett(Home sd) {
    List<Widget> l = List();
    for (var i in sd.ll) {
      l.add(SelectableText(i ?? 'none'));
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(children: gett(widget)),
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
