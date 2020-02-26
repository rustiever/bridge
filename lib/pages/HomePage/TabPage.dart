import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class SizeUtil {
  static const _DESIGN_WIDTH = 750;
  static const _DESIGN_HEIGHT = 1334;

  //logic size in device
  static Size _logicSize;

  //device pixel radio.

  static get width {
    return _logicSize.width;
  }

  static get height {
    return _logicSize.height;
  }

  static set size(size) {
    _logicSize = size;
  }

  //@param w is the design w;
  static double getAxisX(double w) {
    return (w * width) / _DESIGN_WIDTH;
  }

// the y direction
  static double getAxisY(double h) {
    return (h * height) / _DESIGN_HEIGHT;
  }

  // diagonal direction value with design size s.
  static double getAxisBoth(double s) {
    return s *
        sqrt((width * width + height * height) /
            (_DESIGN_WIDTH * _DESIGN_WIDTH + _DESIGN_HEIGHT * _DESIGN_HEIGHT));
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
  Widget _textBack(content,
          {color = TEXT_BLACK_LIGHT,
          size = TEXT_SMALL_2_SIZE,
          isBold = false}) =>
      Text(
        content,
        style: TextStyle(
            color: color,
            fontSize: SizeUtil.getAxisBoth(size),
            fontWeight: isBold ? FontWeight.w700 : null),
      );

  static const TEXT_SMALL_3_SIZE = 24.0;
  static const TEXT_NORMAL_SIZE = 26.0;
  Widget _listItemName() => Container(
        alignment: AlignmentDirectional.bottomStart,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _textBack("Hristo Hristov", size: TEXT_SMALL_3_SIZE, isBold: true),
            SizedBox(height: SizeUtil.getAxisY(13.0)),
            _textBack("4 hours ago", size: TEXT_NORMAL_SIZE),
          ],
        ),
      );

  Widget _action(icon, value) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: SizeUtil.getAxisBoth(30.0),
            color: TEXT_BLACK_LIGHT,
          ),
          SizedBox(height: SizeUtil.getAxisY(26.0)),
          _textBack(value)
        ],
      );

  Widget _listItemAction() => Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _action(Icons.favorite_border, "233"),
              SizedBox(height: SizeUtil.getAxisY(56.0)),
              _action(Icons.chat, "35"),
              SizedBox(height: SizeUtil.getAxisY(56.0)),
              _action(Icons.share, "12"),
              SizedBox(height: SizeUtil.getAxisY(56.0)),
              _action(Icons.more_vert, ""),
            ]),
      );

  static const CIRCLE_BUTTON_HEIGHT = 87.0;
  Widget _listItem(index) => Container(
        height: SizeUtil.getAxisY(740.0),
        decoration: BoxDecoration(
            gradient: index % 2 == 1
                ? LinearGradient(
                    colors: [Color(0x55FFFFFF), Colors.transparent])
                : null),
        padding: EdgeInsets.only(
            top: SizeUtil.getAxisY(40.0), bottom: SizeUtil.getAxisY(20.0)),
        child: Container(
            child: Stack(
          children: <Widget>[
            Container(
              height: SizeUtil.getAxisY(550.0),
              width: SizeUtil.getAxisX(613.0),
              child: Image.asset(
                index % 2 == 0
                    ? 'assets/DummyIcons/man.png'
                    : 'assets/appIcon/Bridge_Icon.png',
                fit: BoxFit.scaleDown,
                height: SizeUtil.getAxisY(550.0),
                width: SizeUtil.getAxisX(613.0),
              ),
            ),
            Positioned(
              width: SizeUtil.getAxisBoth(CIRCLE_BUTTON_HEIGHT),
              height: SizeUtil.getAxisBoth(CIRCLE_BUTTON_HEIGHT),
              left: SizeUtil.getAxisX(24.0),
              bottom: SizeUtil.getAxisY(89.0),
              child: Image.asset(
                'assets/appIcon/Bridge_Icon.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: SizeUtil.getAxisX(160.0),
              bottom: SizeUtil.getAxisY(10.0),
              child: _listItemName(),
            ),
            Positioned(
              right: SizeUtil.getAxisX(40.0),
              top: SizeUtil.getAxisY(40.0),
              child: _listItemAction(),
            )
          ],
        )),
      );

  Widget _body() => ListView.builder(
        itemBuilder: (context, index) {
          return _listItem(index);
        },
        itemCount: 4,
        padding: EdgeInsets.only(top: 0.1),
      );

  var list = List.generate(100, (i) => 'i');

  var _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(() {
      if(_controller.position.pixels == _controller.position.maxScrollExtent) {
         _loadMore();
               }
             }); 
             super.initState();
           }
         
           @override
           Widget build(BuildContext context) {
             SizeUtil.size = MediaQuery.of(context).size;
             return Scaffold(
               // body: Container(
               //   decoration: BoxDecoration(
               //       gradient: LinearGradient(
               //           colors: [YELLOW, GREEN],
               //           begin: Alignment.topLeft,
               //           end: Alignment.centerLeft)),
               //   child: Column(
               //     mainAxisAlignment: MainAxisAlignment.start,
               //     crossAxisAlignment: CrossAxisAlignment.start,
               //     children: <Widget>[
               //       // TopTitleBar(),
               //       Expanded(
               //         child: Stack(
               //           children: <Widget>[
               //             _body(),
               //             Positioned(
               //               width: SizeUtil.width,
               //               bottom: SizeUtil.getAxisY(41.0),
               //               child: Row(
               //                 mainAxisAlignment: MainAxisAlignment.center,
               //                 crossAxisAlignment: CrossAxisAlignment.center,
               //                 children: <Widget>[],
               //               ),
               //             )
               //           ],
               //         ),
               //       ),
               //     ],
               //   ),
               // ),
               body: ListView.builder(
                 padding: EdgeInsets.only(top: 0.1),
                 // itemExtent: 2,
                 itemCount: list.length,
                 itemBuilder: (context, i) {
                   if (i == list.length - 1) return CupertinoActivityIndicator();
                   return FeedChild();
                 },
               ),
             );
           }
         
           void _loadMore() {
             for(int i = curmax; i< curmax + 10; i++) {
               list.add('value');
             }

             curmax = curmax + 10; 
           }
}

class FeedChild extends StatelessWidget {
   FeedChild({Key key, this.ss}) : super(key: key);
final ss;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      // set the default style for the children TextSpans
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .copyWith(fontSize: 25),
                      children: [
                        TextSpan(
                          text: 'Rustiever',
                        ),
                        TextSpan(
                          text: ' -25mins ago',
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: 15,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Container(
              height: 500,
              width: double.infinity,
              child: Image.network(
                'https://images.unsplash.com/photo-1582403062760-50d17f6805db?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
                loadingBuilder: (context, child, progress) {
                  return progress == null ? child : CircularProgressIndicator();
                },
              ),
            ),
            Container(
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    size: 35,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.chat,
                    size: 35,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Icon(
                    Icons.share,
                    size: 35,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 35,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
