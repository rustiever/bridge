import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';

class AddPolls extends StatefulWidget {
  @override
  _AddPollsState createState() => _AddPollsState();
}

class _AddPollsState extends State<AddPolls> {
  List<Widget> _children = [];
  int _count = 0;
  List<TextEditingController> controllers = [];
  var _question = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextFormField(
                  controller: _question,
                  maxLines: 4,
                  minLines: 1,
                  decoration: new InputDecoration(
                    labelText: "Type Your Question",
                    fillColor: Colors.grey,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.add), onPressed: _add),
                Container(
                  height: 200,
                  color: Colors.deepPurpleAccent,
                  child: ListView(children: _children),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () =>
                  Navigator.of(context).popAndPushNamed(HomeViewRoute),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  void _add() {
    TextEditingController controller = TextEditingController();
    controllers.add(controller);
    _children = List.from(_children)
      ..add(
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "This is TextField $_count",
            icon: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  _children = List.from(_children)..removeLast();
                });
              },
            ),
          ),
        ),
      );
    setState(() => ++_count);
  }
}
