import 'package:bridge/models/Users.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;

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
          .document(widget.user.id)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data.data);
          return profileScaffold(snapshot, context);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  SafeArea profileScaffold(
      AsyncSnapshot<DocumentSnapshot> snapshot, BuildContext context) {
    User user = User.fromDocumentSnapshot(snapshot.data);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            // color: Colors.black,
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
                            margin: EdgeInsets.only(left: 110.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  user.username,
                                  style: TextStyle(fontSize: 20),
                                  // style: Theme.of(context).textTheme.title,
                                ),
                                ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text(
                                    user.branch ?? '',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  subtitle: Text("${user.batch ?? ''} Batch"),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(user.photoUrl),
                            fit: BoxFit.cover),
                      ),
                      margin: EdgeInsets.only(left: 16.0, top: 30.0),
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
                      ListTile(
                        title: Text("User information"),
                      ),
                      Divider(),
                      ListTile(
                        subtitle: Text("User Name"),
                        title: Text(user.username),
                        leading: Icon(Icons.person_outline),
                      ),
                      ListTile(
                        subtitle: Text("USN"),
                        title: Text(user.usn ?? ''),
                        leading: Icon(Icons.accessibility_new),
                      ),
                      ListTile(
                        subtitle: Text("Email"),
                        title: Text(user.email),
                        leading: Icon(Icons.email),
                      ),
                      // ListTile(
                      //   title: Text("Phone"),
                      //   subtitle: Text("+977-9815225566"),
                      //   leading: Icon(Icons.phone),
                      // ),
                      // ListTile(
                      //   subtitle: Text("About"),
                      //   title: Text(
                      //       "Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
                      //   leading: Icon(Icons.person),
                      // ),
                      ListTile(
                        subtitle: Text("Joined Date"),
                        title: Text(user.joined),
                        leading: Icon(Icons.calendar_view_day),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
