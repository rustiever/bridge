// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// import '../../constants/Assets.dart';
// import '../../models/AnonFeed.dart';
// import '../../pages/FeedPage.dart';
// import '../../services/Service.dart';
// import '../../stateProviders/Providers.dart';

// class AnonFeedBody extends HookWidget {
//   const AnonFeedBody({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final refresh = useState(true);
//     var anonFuture =
//         useMemoized(() => ApiService.instance.getAnonFeeds(), [refresh.value]);
//     AsyncSnapshot<AnonFeed> snapshot = useFuture(anonFuture);
//     print(snapshot.data);
//     switch (snapshot.connectionState) {
//       case ConnectionState.active:
//       case ConnectionState.waiting:
//       case ConnectionState.none:
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       case ConnectionState.done:
//         if (snapshot.hasError) {
//           return Center(
//             child: Text(snapshot.error),
//           );
//         }
//         return RefreshIndicator(
//           onRefresh: () async {
//             refresh.value = !refresh.value;
//             print(refresh.value);
//           },
//           child: ListView.builder(
//             keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//             itemCount: 2,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
//                 child: Container(
//                   width: double.infinity,
//                   height: 560.0,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: 10.0),
//                         child: Column(
//                           children: <Widget>[
//                             ListTile(
//                               leading: Container(
//                                 width: 50.0,
//                                 height: 50.0,
//                                 decoration: BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black45,
//                                       offset: Offset(0, 2),
//                                       blurRadius: 6.0,
//                                     ),
//                                   ],
//                                 ),
//                                 child: CircleAvatar(
//                                   child: ClipOval(
//                                     child: Image(
//                                       height: 50.0,
//                                       width: 50.0,
//                                       image: NetworkImage(
//                                           snapshot.data.data[index].imgUrl),
//                                       // image: AssetImage(posts[index].authorImageUrl),
//                                       fit: BoxFit.cover,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               title: Text(
//                                 snapshot.data.data[index].postOwnerName,
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               subtitle: Text(snapshot.data.data[index].time),
//                               trailing: IconButton(
//                                 icon: Icon(Icons.more_horiz),
//                                 color: Colors.black,
//                                 onPressed: () => print('More'),
//                               ),
//                             ),
//                             InkWell(
//                               onDoubleTap: () => print('Like post'),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (_) => ViewPostScreen(
//                                       post: posts[index],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.all(10.0),
//                                 width: double.infinity,
//                                 height: 400.0,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(25.0),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black45,
//                                       offset: Offset(0, 5),
//                                       blurRadius: 8.0,
//                                     ),
//                                   ],
//                                   image: DecorationImage(
//                                     image: NetworkImage(
//                                         snapshot.data.data[index].imgUrl),
//                                     fit: BoxFit.fitWidth,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 20.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Row(
//                                         children: <Widget>[
//                                           IconButton(
//                                             icon: Icon(Icons.favorite_border),
//                                             iconSize: 30.0,
//                                             onPressed: () => print('Like post'),
//                                           ),
//                                           Text(
//                                             '2,515',
//                                             style: TextStyle(
//                                               fontSize: 14.0,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(width: 20.0),
//                                       Row(
//                                         children: <Widget>[
//                                           IconButton(
//                                             icon: Icon(Icons.chat),
//                                             iconSize: 30.0,
//                                             onPressed: () {
//                                               Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                   builder: (_) =>
//                                                       ViewPostScreen(
//                                                     post: posts[index],
//                                                   ),
//                                                 ),
//                                               );
//                                             },
//                                           ),
//                                           Text(
//                                             '350',
//                                             style: TextStyle(
//                                               fontSize: 14.0,
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   IconButton(
//                                     icon: Icon(Icons.bookmark_border),
//                                     iconSize: 30.0,
//                                     onPressed: () => print('Save post'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       default:
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//     }
//   }
// }

// class Home extends HookWidget {
//   final GlobalKey _scaffoldKey = new GlobalKey();
//   @override
//   Widget build(BuildContext context) {
//     // var user = useProvider(userData);
//     var loggedIn = useState(false);
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Colors.white,
//         actions: [],
//         title: Text(
//           'Bridge',
//           style: TextStyle(
//               fontFamily: 'Billabong', fontSize: 32.0, color: Colors.black),
//         ),
//       ),
//       endDrawer: HomeDrawer(),
//       bottomNavigationBar: HomeBottomNavBar(),
//       body: loggedIn.value ? UserFeedBody() : AnonFeedBody(),
//     );
//   }
// }

// class HomeBottomNavBar extends HookWidget {
//   const HomeBottomNavBar({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         const BottomNavigationBarItem(
//           icon: Icon(
//             Icons.dashboard,
//             size: 30.0,
//             color: Colors.black,
//           ),
//           title: Text('Dashboard'),
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(
//             Icons.search,
//             size: 30.0,
//             color: Colors.grey,
//           ),
//           title: Text(''),
//         ),
//       ],
//     );
//   }
// }

// class HomeDrawer extends HookWidget {
//   const HomeDrawer({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print(useProvider(platform));
//     return Drawer(
//       child: Column(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               width: MediaQuery.of(context).size.width * 0.85,
//               child: DrawerHeader(
//                 duration: Duration(milliseconds: 1000),
//                 curve: Curves.bounceInOut,
//                 decoration: BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(appIcon), fit: BoxFit.cover)),
//                 child: Text("Header"),
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: ListView(children: [
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 title: Text("Home"),
//                 onTap: () {
//                   Navigator.of(context).pop();
//                 },
//               )
//             ]),
//           )
//         ],
//       ),
//     );
//   }
// }

// class UserFeedBody extends StatelessWidget {
//   const UserFeedBody({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: null);
//   }
// }
