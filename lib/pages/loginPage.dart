import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              color: Colors.yellow[600],
              child: Padding(
                padding: EdgeInsets.only(top: 70.0, right: 50.0, left: 50.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 60.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          "Let's get you set up",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          "It should only take a couple of minutes to pair with your watch",
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          child: Text(
                            ">",
                            style: TextStyle(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: 40.0, right: 70.0, left: 70.0, bottom: 40.0),
              child: Column(
                children: <Widget>[
                  //InputField Widget from the widgets folder
                  // InputField(
                  //   label: "Name",
                  //   content: "Name"
                  // ),

                  SizedBox(height: 20.0),

                  //Gender Widget from the widgets folder
                  // Gender(),

                  SizedBox(height: 20.0),

                  //InputField Widget from the widgets folder
                  // InputField(
                  //   label: "Date of birth",
                  //   content: "01/02/1986"
                  // ),

                  SizedBox(height: 20.0),

                  //InputField Widget from the widgets folder
                  // InputField(
                  //   label: "Email",
                  //   content: "yo@seethat.com"
                  // ),

                  SizedBox(height: 20.0),

                  // InputField(
                  //   label: "Mobile",
                  //   content: "+22994684468"
                  // ),

                  SizedBox(height: 20.0),

                  //InputField Widget from the widgets folder
                  // InputField(
                  //   label: "Customer ID",
                  //   content: "22223311111"
                  // ),

                  SizedBox(
                    height: 40.0,
                  ),

                  //Membership Widget from the widgets folder
                  // Membership(),

                  SizedBox(
                    height: 40.0,
                  ),

                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 170.0,
                      ),
                      FlatButton(
                        color: Colors.grey[200],
                        onPressed: () {},
                        child: Text("Cancel"),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      FlatButton(
                        color: Colors.greenAccent,
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
