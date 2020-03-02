import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/fa_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabPages extends StatefulWidget {
  @override
  _TabPagesState createState() => _TabPagesState();
}

class _TabPagesState extends State<TabPages> {
  static var feed = Icon(Icons.new_releases);
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        Row(
          children: <Widget>[Icon(Icons.directions_car), feed],
        ),
        Icon(Icons.directions_bike),
        FeedPage(),
        Icon(Icons.directions_bike),
        Icon(Icons.directions_bike),
      ],
    );
  }
}

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  static const YELLOW = Color(0xfffbed96);
  static const GREEN = Color(0xffc7e5b4);

  static const TEXT_BLACK_LIGHT = Color(0xFF34323D);
  static const TEXT_SMALL_2_SIZE = 22.0;

  var curmax = 10;

  var list = List.generate(15, (i) => 'i');

  var _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        controller: _controller,
        // itemExtent: 2,
        itemCount: list.length + 1,
        itemBuilder: (context, i) {
          if (i == list.length) return CupertinoActivityIndicator();
          return FeedChild();
        },
      ),
    );
  }

  void _loadMore() {
    for (int i = curmax; i < curmax + 2; i++) {
      list.add('value');
    }

    curmax = curmax + 2;
  }
}

class FeedChild extends StatefulWidget {
  FeedChild({Key key, this.ss}) : super(key: key);
  final ss;

  @override
  _FeedChildState createState() => _FeedChildState();
}

class _FeedChildState extends State<FeedChild> {

  bool heart = true;
  bool comment = true;
  bool bookmark = true;

  static const YELLOW = Color(0xfffbed96);
  static const GREEN = Color(0xffc7e5b4);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.0),
      elevation: 5,
      child: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [YELLOW, GREEN],
        //   ),
        // ),
        // height: 600,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RichText(
                    text: TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 25),
                      children: [
                        TextSpan(
                          text: 'Rustiever1',
                        ),
                        TextSpan(
                          text: ' 25mins ago',
                          style: TextStyle(
                              color: Colors.black45,
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
              'https://images.unsplash.com/photo-1504610926078-a1611febcad3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=80',
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
                buildIconButton(icon: FontAwesomeIcons.solidEye,),
                Text('521m'),
                buildIconButton(
                    icon: heart ? FontAwesomeIcons.heart : FontAwesomeIcons.solidHeart, ontap: () {
                      setState(() {
                        heart = !heart;
                      });
                    }),
                Text('123k'),
                buildIconButton(
                    icon: comment ? FontAwesomeIcons.commentDots : FontAwesomeIcons.solidCommentDots, ontap: () {
                      setState(() {
                        comment = !comment;
                      });
                    }),
                Text('123m'),
                buildIconButton(
                    icon: FontAwesomeIcons.locationArrow, ontap: () {}),
                buildIconButton(
                    icon: bookmark ?  FontAwesomeIcons.bookmark : FontAwesomeIcons.solidBookmark, ontap: () {
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

  IconButton buildIconButton({@required icon, ontap}) {
    return IconButton(
      onPressed: ontap,
      icon: FaIcon(
        icon,
        color: Colors.white70,
      ),
    );
  }
}
