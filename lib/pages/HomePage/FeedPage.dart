import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Auth.dart';
import 'package:bridge/Services/Repository.dart';
import 'package:bridge/models/Users.dart';
import 'package:bridge/pages/HomePage/Drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getflutter/getflutter.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  var _repository = Repository();
  final Firestore _firestore = Firestore.instance;
  User currentUser, user;
  IconData icon;
  Color color;
  Stream<QuerySnapshot> _stream;
  var curmax = 2;

  var _controller = ScrollController();

  void fetchFeed() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();

    User user = await _repository.fetchUserDetailsById(currentUser.uid);
    setState(() {
      this.currentUser = user;
    });

    _stream = _repository.fetchFeed();
  }

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        getMore();
      }
    });
    super.initState();
    fetchFeed();
    getFeeds();
  }

  List<DocumentSnapshot> feeds = [];
  bool loadingFeeds = true, gettinmorefeeds = false, moreAvailable = true;
  DocumentSnapshot last;
  getFeeds() async {
    setState(() {
      loadingFeeds = true;
    });
    Query q = _firestore
        .collection('posts')
        .orderBy('time', descending: true)
        .limit(2);
    QuerySnapshot querySnapshot = await q.getDocuments();
    feeds = querySnapshot.documents;
    last = querySnapshot.documents[querySnapshot.documents.length - 1];
    setState(() {
      loadingFeeds = false;
    });
  }

  getMore() async {
    print('inside getmore');
    if (moreAvailable == false) {
      print('no feeds');
      return;
    }
    if (gettinmorefeeds == true) {
      print('no getting feeds');
      return;
    }
    gettinmorefeeds = true;
    Query q = _firestore
        .collection('posts')
        .orderBy('time', descending: true)
        .startAfter([last.data['time']]).limit(2);
    QuerySnapshot querySnapshot = await q.getDocuments();
    feeds.addAll(querySnapshot.documents);
    if (querySnapshot.documents.length < 2) {
      moreAvailable = false;
    } else {
      last = querySnapshot.documents[querySnapshot.documents.length - 1];
    }
    setState(() {});
    gettinmorefeeds = false;
  }

  @override
  Widget build(BuildContext context) {
    return currentUser != null
        ? Scaffold(
            drawer: AppDrawer(
              user: currentUser,
            ),
            floatingActionButton: FloatingActionButton(onPressed: null),
            body: loadingFeeds == true
                ? GFLoader(
                    type: GFLoaderType.custom,
                    loaderIconOne: Text('Please'),
                    loaderIconTwo: Text('Wait'),
                    loaderIconThree: Text('a moment'),
                  )
                : feeds.length == 0
                    ? Center(
                        child: Text("no feeds"),
                      )
                    : sliverPage(),
          )
        : Center(
            child: GFLoader(
              type: GFLoaderType.custom,
              loaderIconOne: Icon(Icons.insert_emoticon),
              loaderIconTwo: Icon(Icons.insert_emoticon),
              loaderIconThree: Icon(Icons.insert_emoticon),
            ),
          );
  }

  Widget sliverPage() {
    return CustomScrollView(
      controller: _controller,
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          title: Text('Bridge'),
          centerTitle: true,
          floating: true,
          leading: IconButton(
            icon: FaIcon(FontAwesomeIcons.plus),
            onPressed: () {
              Navigator.pushNamed(context, FeedaddRoute);
            },
            iconSize: 35,
            splashColor: Colors.lightBlueAccent,
          ),
          actions: <Widget>[
            IconButton(
              onPressed: null,
              icon: FaIcon(
                FontAwesomeIcons.filter,
                // color: Colors.white70,
              ),
              splashColor: Colors.lightBlueAccent,
            ),
            IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, LoginViewRoute);
                AuthService().signOutGoogle();
              },
              icon: FaIcon(
                FontAwesomeIcons.userMinus,
                // color: Colors.white70,
              ),
            ),
          ],
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              print('$index,${feeds.length}');
              return feedChild(index: index, list: feeds);
            },
            // childCount: snapshot.data.documents.length,
            childCount: feeds.length,
          ),
        ),
      ],
    );
  }

  Widget feedChild({int index, List<DocumentSnapshot> list}) {
    bool heart = true;
    bool comment = true;
    bool bookmark = true;
    print(list.length);

    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 5,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      list[index].data['postOwnerPhotoUrl'],
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 20),
                      children: [
                        TextSpan(
                          text: 'Rustiever1',
                        ),
                        TextSpan(
                          text: ' 25mins ago',
                          style: TextStyle(
                              // color: Colors.black45,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  IconButton(
                    icon: Icon(Icons.more_horiz),
                    onPressed: () {},
                    iconSize: 25,
                  )
                ],
              ),
            ),
            Image.network(
              list[index].data['imgUrl'],
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildIconButton(
                  icon: FontAwesomeIcons.solidEye,
                ),
                Text('521m'),
                buildIconButton(
                    icon: heart
                        ? FontAwesomeIcons.heart
                        : FontAwesomeIcons.solidHeart,
                    ontap: () {
                      setState(() {
                        heart = !heart;
                      });
                    }),
                Text('123k'),
                buildIconButton(
                    icon: comment
                        ? FontAwesomeIcons.commentDots
                        : FontAwesomeIcons.solidCommentDots,
                    ontap: () {
                      setState(() {
                        comment = !comment;
                      });
                    }),
                Text('123m'),
                buildIconButton(
                    icon: FontAwesomeIcons.locationArrow, ontap: () {}),
                buildIconButton(
                    icon: bookmark
                        ? FontAwesomeIcons.bookmark
                        : FontAwesomeIcons.solidBookmark,
                    ontap: () {
                      setState(() {
                        bookmark = !bookmark;
                      });
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}

IconButton buildIconButton({@required icon, ontap}) {
  return IconButton(
    onPressed: ontap,
    icon: FaIcon(
      icon,
      color: Colors.white70,
    ),
  );
}
