import 'package:bridge/Routes/Router.dart';
import 'package:flutter/material.dart';
import 'package:getflutter/getflutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData sd = MediaQuery.of(context);
    print('${sd.size}');
    return Scaffold(
      backgroundColor: Color.fromRGBO(21, 32, 43, 1.0),
      extendBodyBehindAppBar: true,

      drawer: AppDrawer(),

      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlutterLogo(
              size: 60,
            ),
            SizedBox(
              height: 90,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Coming Soon',
                  style: TextStyle(color: Colors.white, fontSize: 45),
                ),
                // Text(
                //   '_counter',
                //   style: Theme.of(context).textTheme.headline4,
                // ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, LoginViewRoute);
        },
        tooltip: 'Lock Page',
        child: Icon(Icons.lock),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            'https://images.unsplash.com/photo-1515387784663-e2e29a23f69e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80',
          ),
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
              child: Text(
          "Rustiever",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          _createDrawerItem(
              icon: Icons.account_box, text: 'etc...'),
          _createDrawerItem(icon: Icons.stars, text: 'Useful Links'),
          Divider(),
          _createDrawerItem(icon: Icons.bug_report, text: 'Report an issue'),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
