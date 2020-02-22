import 'package:bridge/Routes/RouteConstants.dart';
import 'package:flutter/material.dart';

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
