import 'package:bridge/Routes/Router.dart';
import 'package:bridge/Services/Auth.dart';
import 'package:bridge/Services/Repository.dart';
import 'package:bridge/models/Users.dart';
import 'package:bridge/pages/HomePage/Drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  Repository _repository = Repository();
  final Firestore _firestore = Firestore.instance;
  User currentUser, user;
  // Stream<QuerySnapshot> _stream;

  ScrollController _controller = ScrollController();

  void fetchFeed() async {
    FirebaseUser currentUser = await _repository.getCurrentUser();

    User user = await _repository.fetchUserDetailsById(currentUser.uid);
    setState(
      () {
        this.currentUser = user;
      },
    );

    // _stream = _repository.fetchFeed();
  }

  @override
  void initState() {
    _controller.addListener(
      () {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          getMore();
        }
      },
    );
    super.initState();
    fetchFeed();
    getFeeds();
  }

  List<DocumentSnapshot> feeds = [];
  bool loadingFeeds = true, gettinmorefeeds = false, moreAvailable = true;
  DocumentSnapshot last;

  getFeeds() async {
    if (!mounted) return;
    setState(
      () {
        loadingFeeds = true;
      },
    );
    Query postq = _firestore
        .collection('posts')
        .orderBy('time', descending: true)
        .limit(2);

    QuerySnapshot querySnapshot = await postq.getDocuments();
    if (querySnapshot.documents.length > 0) {
      feeds = querySnapshot.documents;
      print(feeds.length);
      last = querySnapshot.documents[querySnapshot.documents.length - 1];
    }
    if (!mounted) return;
    setState(
      () {
        loadingFeeds = false;
      },
    );
  }

  Future<void> getMore() async {
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
    Query postq = _firestore
        .collection('posts')
        .orderBy('time', descending: true)
        .startAfter([last.data['time']]).limit(2);

    QuerySnapshot querySnapshot = await postq.getDocuments();
    //---------------------------------------------------

    //---------------------------------------------------
    feeds.addAll(querySnapshot.documents);
    print(feeds.length);

    if (querySnapshot.documents.length < 2) {
      moreAvailable = false;
    } else if (querySnapshot.documents.length >= 2) {
      last = querySnapshot.documents[querySnapshot.documents.length - 1];
      // print(last.data);
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
            // floatingActionButton: FloatingActionButton(onPressed: null),
            body: loadingFeeds == true
                ? GFLoader(
                    type: GFLoaderType.custom,
                    loaderIconOne: Text('Please'),
                    loaderIconTwo: Text('Wait'),
                    loaderIconThree: Text('a moment'),
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
                Navigator.pushNamed(context, LoginViewRoute);
                AuthService().signOutGoogle();
              },
              icon: FaIcon(
                FontAwesomeIcons.userMinus,
                // color: Colors.white70,
              ),
            ),
          ],
        ),
        feeds.length == 0
            ? SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Center(
                      child: Text("no feeds"),
                    )
                  ],
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    // print('$index,${feeds.length}');
                    return feedChild(
                      index: index,
                      list: feeds,
                    );
                  },
                  childCount: feeds.length,
                ),
              ),
      ],
    );
  }

  bool heart = true;
  bool comment = true;
  bool bookmark = true;
  Widget feedChild({int index, List<DocumentSnapshot> list}) {
    // print(list[index].documentID);
    if (list[index].data['mode'] == 'poll') {
      String docId = list[index].documentID;
      return StreamBuilder(
        stream: _firestore.collection('posts').document(docId).snapshots(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return GFLoader();
          }
          Map<String, dynamic> fl = snapshot.data['options'];
          List<Map<String, int>> ll = [];
          fl.forEach((key, value) {
            ll.add({key: value});
          });
          print('calling');
          return Card(
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            elevation: 0.0,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    snapshot.data['question'],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ListView.builder(
                  itemCount: ll.length,
                  shrinkWrap: true,
                  itemBuilder: (_, int i) {
                    var val = ll[i]
                        .values
                        .toString()
                        .substring(1, ll[i].values.toString().length - 1);
                    return ListTile(
                      onTap: () async {
                        int count = 0;
                        count = int.tryParse(val);
                        fl.update(
                            ll[i]
                                .keys
                                .toString()
                                .substring(1, ll[i].keys.toString().length - 1),
                            (value) => ++count);

                        print(ll[i].values);
                        print(count);
                        await _firestore
                            .collection('posts')
                            .document(docId)
                            .updateData({'options': fl});
                      },
                      title: Text(
                        ll[i].keys.toString(),
                      ),
                      trailing: Text(val),
                    );
                  },
                )
              ],
            ),
          );
        },
      );
    }

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
                      list[index].data['postOwnerPhotoUrl'], //TODO url!= null
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
                          text: list[index].data['postOwnerName'],
                        ),
                        TextSpan(
                          // text: ' 25mins ago',
                          style: TextStyle(
                              // color: Colors.black45,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  // SizedBox(
                  //   width: 112,
                  // ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                    iconSize: 25,
                  )
                ],
              ),
            ),
            CachedNetworkImage(
              imageUrl: list[index].data['imgUrl'],
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                buildIconButton(
                  icon: heart
                      ? FontAwesomeIcons.heart
                      : FontAwesomeIcons.solidHeart,
                  ontap: () {
                    setState(
                      () {
                        heart = !heart;
                      },
                    );
                  },
                ),
                Text('123k'),
                Spacer(),
                buildIconButton(
                  icon: comment
                      ? FontAwesomeIcons.commentDots
                      : FontAwesomeIcons.solidCommentDots,
                  ontap: () {
                    setState(
                      () {
                        comment = !comment;
                      },
                    );
                  },
                ),
                Text('123m'),
                Spacer(),
                // buildIconButton(
                //     icon: FontAwesomeIcons.locationArrow, ontap: () {}),
                // Spacer(),
                buildIconButton(
                  icon: bookmark
                      ? FontAwesomeIcons.bookmark
                      : FontAwesomeIcons.solidBookmark,
                  ontap: () {
                    setState(
                      () {
                        bookmark = !bookmark;
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

IconButton buildIconButton({@required icon, @required ontap}) {
  return IconButton(
    onPressed: ontap,
    icon: FaIcon(
      icon,
      color: Colors.white70,
    ),
  );
}
