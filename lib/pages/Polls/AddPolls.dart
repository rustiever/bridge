import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';

class AddPolls extends StatefulWidget {
  @override
  _AddPollsState createState() => _AddPollsState();
}

class _AddPollsState extends State<AddPolls> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Widget> _children = [];
  int _count = 0;
  List<TextEditingController> controllers = [];
  var _question = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _media = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: _media.width / 1.14,
                    child: TextFormField(
                      controller: _question,
                      validator: validator,
                      maxLines: 2,
                      minLines: 1,
                      decoration: InputDecoration(
                        labelText: "Type Your Question",
                        fillColor: Colors.grey,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.add), onPressed: _add),
                ],
              ),
              Container(
                // color: Colors.green,
                height: _media.height / 3.23,
                child: ListView(children: _children),
              ),
              RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    Navigator.of(context).popAndPushNamed(HomeViewRoute);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controllers.clear();
    super.dispose();
  }

  String validator(String value) {
    if (value.isEmpty)
      return "can't send blank line";
    else
      return null;
  }

  void _add() {
    TextEditingController controller = TextEditingController();
    controllers.add(controller);
    _children = List.from(_children)
      ..add(
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: "This is TextField $_count",
            icon: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  _children = List.from(_children)..removeLast();
                  _count--;
                });
              },
            ),
          ),
        ),
      );
    setState(() => ++_count);
  }
}
