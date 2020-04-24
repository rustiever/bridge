import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class PollingPage extends StatefulWidget {
  PollingPage({Key key}) : super(key: key);

  @override
  _PollingPageState createState() => _PollingPageState();
}

class _PollingPageState extends State<PollingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            // height: 220,
            // width: double.maxFinite,
            child: GFCard(
              elevation: 5,
              content: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'when should be exam timetable?',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.of(context).popAndPushNamed(AddPollRoute),
          // onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  addPoll() {
    showBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
      ),
    );
  }
}
