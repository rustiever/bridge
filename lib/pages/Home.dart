import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/auth.dart';
import 'package:Bridge/services/backendAuth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'FeedPage.dart';

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  upload(String url) async {
    String filename = await FilePicker.getFilePath(allowedExtensions: ['csv']);
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
        http.MultipartFile.fromString('csv', filename, filename: 'hello.csv'));
    http.StreamedResponse res = await request.send();
    print(res.statusCode);
  }

  Future<void> login() async {
    List<dynamic> res = await FirebaseAuthService().signInWithGoogle();
    try {
      user = await ApiService.instance
          .login(newUser: res[0], user: res[1], tokenResult: res[2]);
      print(user.userData.email);
      print(user.authorizeToken);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Home Build');

    Widget buildPost(int index) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Container(
          width: double.infinity,
          height: 560.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 2),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          child: ClipOval(
                            child: Image(
                              height: 50.0,
                              width: 50.0,
                              image:
                                  AssetImage('assets/appIcon/Bridge_Icon.png'),
                              // image: AssetImage(posts[index].authorImageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        posts[index].authorName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(posts[index].timeAgo),
                      trailing: IconButton(
                        icon: Icon(Icons.more_horiz),
                        color: Colors.black,
                        onPressed: () => print('More'),
                      ),
                    ),
                    InkWell(
                      onDoubleTap: () => print('Like post'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ViewPostScreen(
                              post: posts[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: double.infinity,
                        height: 400.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 5),
                              blurRadius: 8.0,
                            ),
                          ],
                          image: DecorationImage(
                            image: AssetImage('assets/appIcon/Bridge_Icon.png'),
                            // image: AssetImage(posts[index].imageUrl),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.favorite_border),
                                    iconSize: 30.0,
                                    onPressed: () => print('Like post'),
                                  ),
                                  Text(
                                    '2,515',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 20.0),
                              Row(
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.chat),
                                    iconSize: 30.0,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => ViewPostScreen(
                                            post: posts[index],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Text(
                                    '350',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.bookmark_border),
                            iconSize: 30.0,
                            onPressed: () => print('Save post'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    var subMenu = PopupMenuButton(
      child: Row(
        children: <Widget>[
          Icon(
            Icons.arrow_left,
            size: 20,
          ),
          // Spacer(),
          Text('Login'),
        ],
      ),
      onCanceled: () {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
      },
      onSelected: (result) async {
        print(result);
        switch (result) {
          case 0:
            await login();
            break;
          default:
        }
        setState(() {});
      },
      // how much the submenu should offset from parent. This seems to have an upper limit.
      offset: Offset.fromDirection(400, 0),
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        const PopupMenuItem(
          value: 0,
          child: Text('Student Login'),
        ),
        const PopupMenuItem(
          value: 1,
          child: Text('Faculty Login'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Alumni Login'),
        ),
        // const PopupMenuItem(
        //   value: 3,
        //   child: Text('Placed in charge of trading charter'),
        // ),
      ],
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFEDF0F6),
        body: ListView(
          physics: AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Bridge',
                    style: TextStyle(
                      fontFamily: 'Billabong',
                      fontSize: 32.0,
                    ),
                  ),
                  Spacer(),
                  PopupMenuButton(
                    onSelected: (value) {
                      switch (value) {
                        case 3:
                          logout();
                          break;
                        default:
                      }
                    },
                    onCanceled: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: subMenu,
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text("Settings"),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: stories.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return SizedBox(width: 10.0);
                  }
                  return Container(
                    margin: EdgeInsets.all(10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      child: ClipOval(
                        child: Image(
                          height: 60.0,
                          width: 60.0,
                          image: AssetImage(stories[index - 1]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            buildPost(0),
            buildPost(1),
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  size: 30.0,
                  color: Colors.black,
                ),
                title: Text('Dashboard'),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 30.0,
                  color: Colors.grey,
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    color: Color(0xFF23B66F),
                    onPressed: () => print('Upload photo'),
                    child: Icon(
                      Icons.add,
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_border,
                  size: 30.0,
                  color: Colors.grey,
                ),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: user == null
                    ? Icon(
                        Icons.person_outline,
                        size: 30.0,
                        color: Colors.grey,
                      )
                    : Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(user.userData.photoURL),
                              fit: BoxFit.fill),
                        ),
                      ),
                title: Text(user?.userData?.name ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void logout() async {
    try {
      var rr = (await _prefs).getString('token');
      var res = await ApiService.instance.logout(token: rr);
      print(res);
      await FirebaseAuthService().signOut();
      user = null;
      setState(() {});
    } catch (e) {
      print(e);
    }
    // Navigator.pop(context);
  }
}
