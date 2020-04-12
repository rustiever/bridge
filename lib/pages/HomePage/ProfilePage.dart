import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  final FirebaseUser user;

  const ProfilePage({Key key, this.user}) : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(widget.user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data.data);
          return profileScaffold(snapshot, context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Scaffold profileScaffold(AsyncSnapshot snapshot, BuildContext context) {
    var creds = snapshot.data.data;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.black,
          margin: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 96.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                creds['userName'],
                                style: Theme.of(context).textTheme.title,
                              ),
                              ListTile(
                                contentPadding: EdgeInsets.all(0),
                                title: Text("Computer Science"),
                                subtitle: Text("2017 Batch"),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.0),
                        // Row(
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: Column(
                        //         children: <Widget>[
                        //           Text("285"),
                        //           Text("Likes")
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         children: <Widget>[
                        //           Text("3025"),
                        //           Text("Comments")
                        //         ],
                        //       ),
                        //     ),
                        //     Expanded(
                        //       child: Column(
                        //         children: <Widget>[
                        //           Text("650"),
                        //           Text("Favourites")
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                          image: CachedNetworkImageProvider(creds['photoUrl']),
                          fit: BoxFit.cover),
                    ),
                    margin: EdgeInsets.only(left: 16.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    // ListTile(
                    //   title: Text("User information"),
                    // ),
                    Divider(),
                    // Container(
                    //   child: Image(
                    //     image: NetworkImage(img),
                    //   ),
                    // ),
                    ListTile(
                      title: Text("User Name"),
                      subtitle: Text("Rustiever"),
                      leading: Icon(Icons.person_outline),
                    ),
                    ListTile(
                      title: Text("USN"),
                      subtitle: Text("4MT17CS095"),
                      leading: Icon(Icons.accessibility_new),
                    ),
                    ListTile(
                      title: Text("Email"),
                      subtitle: Text(creds['email']),
                      leading: Icon(Icons.email),
                    ),
                    // ListTile(
                    //   title: Text("Phone"),
                    //   subtitle: Text("+977-9815225566"),
                    //   leading: Icon(Icons.phone),
                    // ),
                    ListTile(
                      title: Text("About"),
                      subtitle: Text(
                          "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
                      leading: Icon(Icons.person),
                    ),
                    ListTile(
                      title: Text("Joined Date"),
                      subtitle: Text("{snapshot.data['createdAt']}"),
                      leading: Icon(Icons.calendar_view_day),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
