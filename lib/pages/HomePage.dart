import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var items = [
    TabItem(icon: Icons.device_hub, title: 'Share'),
    TabItem(icon: Icons.dashboard, title: 'Discovery'),
    TabItem(icon: Icons.sort, title: 'Request'),
  ];
  @override
  Widget build(BuildContext context) {
    MediaQueryData sd = MediaQuery.of(context);
    print('${sd.size}');
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar.badge(
          {
            // 0: '99+',
            // 1: b1,
          },
          curveSize: 120,
          backgroundColor: Colors.grey,
          activeColor: Colors.indigoAccent,
          color: Colors.indigo,
          curve: Curves.fastLinearToSlowEaseIn,
          elevation: 0.0,
          items: items,
          initialActiveIndex: 1, //optional, default as 0
          // onTap: (int i) => print('click index=$i'),
        ),
        backgroundColor: Color.fromRGBO(21, 32, 43, 1.0),
        extendBodyBehindAppBar: true,
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
        ),
        body: TabPages(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginViewRoute);
          },
          tooltip: 'Lock Page',
          child: Icon(Icons.lock),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}

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
        feed,
        Icon(Icons.directions_bike),
      ],
    );
  }
}

class AppDrawer extends StatelessWidget {
  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _createHeader() {
    return GFDrawerHeader(
      margin: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
              'https://images.unsplash.com/photo-1515387784663-e2e29a23f69e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 25),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              minRadius: 45,
              maxRadius: 63,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
              ),
            ),
            Text(
              "Rustiever",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.remove_from_queue,
            text: 'Requests',
          ),
          _createDrawerItem(
            icon: Icons.event,
            text: 'Pools',
          ),
          _createDrawerItem(
            icon: Icons.share,
            text: 'Share',
          ),
          Divider(),
          _createDrawerItem(icon: Icons.collections_bookmark, text: 'Steps'),
          _createDrawerItem(icon: Icons.face, text: 'anything'),
          _createDrawerItem(icon: Icons.account_box, text: 'etc...'),
          _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          ListTile(
            title: Text('Version 0.0.1'),
            onTap: null,
          ),
        ],
      ),
    );
  }
}
