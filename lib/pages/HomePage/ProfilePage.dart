//import 'package:bridge/main.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        color: Colors.black,
        child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.deepPurpleAccent,
                  Colors.deepPurpleAccent,
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top :80.0),
            child : Column(
            children:<Widget>[
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children : <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  decoration : BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red,
                      width: 5,
                    ),
                    
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/man.png'),
                  ),
                ),
              ],
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                " Bridge User ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
            ],
            ),
          ),
          /*Align(
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                  color: Colors.red,
                  width: 5,
                ),
              ),
            ),
          ),*/
          /*Container(
            width: 150,
            height: 150,
            decoration : BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.red,
                width: 5,
              ),
            ),
            padding: EdgeInsets.all(10.0),
                  /*child: CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/man.png'),
                  ),*/
                  
          ),*/
        ],
        ),
      )
    );
  }
}