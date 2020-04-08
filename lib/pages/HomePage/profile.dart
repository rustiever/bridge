// // //import 'package:bridge/main.dart';
// import 'package:flutter/material.dart';
// // import 'package:cached_network_image/cached_network_image.dart';
// // import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
// // import 'package:flutter_ui_challenges/src/widgets/network_image.dart';
// // class ProfilePage extends StatefulWidget {
// //   ProfilePage({Key key}) : super(key: key);

// //   @override
// //   _ProfilePageState createState() => _ProfilePageState();
// // }

// // class _ProfilePageState extends State<ProfilePage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body : Container(
// //         color: Colors.white,
// //         child: Stack(
// //         children: <Widget>[
// //           Container(
// //             /*decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 /*colors: [
// //                   Colors.purple,
// //                   Colors.deepPurpleAccent,
// //                   Colors.deepPurpleAccent,
// //                 ],*/
// //               ),
// //             ),*/
// //           ),
// //           Padding(
// //             padding: EdgeInsets.only(top :25.0),
// //             child : Column(
// //             children:<Widget>[
// //               Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children : <Widget>[
// //                 Container(
// //                   width: 150,
// //                   height: 150,
// //                   decoration : BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     border: Border.all(
// //                       color: Colors.black,
// //                       width: 2,
// //                     ),
                    
// //                   ),
// //                   padding: EdgeInsets.all(10.0),
// //                   child: CircleAvatar(
// //                     backgroundImage: AssetImage('assets/icons/man.png'),
// //                   ),
// //                 ),
// //               ],
// //               ),
// //               SizedBox(
// //                 height: 8.0,
// //               ),
// //               Text(
// //                 " Bridge ",
// //                 textAlign: TextAlign.center,
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.bold,
// //                   fontSize: 18.0,
// //                   color: Colors.black87,
// //                 ),
// //               ),
// //             ],
// //             ),
// //           ),
// //           /*Align(
// //             child: Container(
// //               width: 150,
// //               height: 150,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.rectangle,
// //                 border: Border.all(
// //                   color: Colors.red,
// //                   width: 5,
// //                 ),
// //               ),
// //             ),
// //           ),*/
// //           /*Container(
// //             width: 150,
// //             height: 150,
// //             decoration : BoxDecoration(
// //               shape: BoxShape.circle,
// //               border: Border.all(
// //                 color: Colors.red,
// //                 width: 5,
// //               ),
// //             ),
// //             padding: EdgeInsets.all(10.0),
// //                   /*child: CircleAvatar(
// //                     backgroundImage: AssetImage('assets/icons/man.png'),
// //                   ),*/
                  
// //           ),*/
// //         ],
// //         ),
// //       )
// //     );
// //   }
// // }

// class ProfilePage extends StatefulWidget {
//   ProfilePage({Key key}) : super(key: key);

//   @override
//   _ProfilePageState createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: null,
//            );
//   }
// }
//        /*
//   static final String path = "lib/src/pages/profile/profile3.dart";
//   final image = avatars[1];
//   @override
//   Widget build(BuildContext context){
//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       body: SingleChildScrollView(
//         child: Stack(
//           children: <Widget>[
//             SizedBox(
//               height: 250,
//               width: double.infinity,
//               child: PNetworkImage(image, fit: BoxFit.cover,),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
//               child: Column(
//                 children: <Widget>[
//                   Stack(
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.all(16.0),
//                         margin: EdgeInsets.only(top: 16.0),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(5.0)
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                               margin: EdgeInsets.only(left: 96.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text("Little Butterfly", style: Theme.of(context).textTheme.title,),
//                                   ListTile(
//                                     contentPadding: EdgeInsets.all(0),
//                                     title: Text("Product Designer"),
//                                     subtitle: Text("Kathmandu"),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 10.0),
//                             Row(
//                               children: <Widget>[
//                                 Expanded(child: Column(
//                                   children: <Widget>[
//                                     Text("285"),
//                                     Text("Likes")
//                                   ],
//                                 ),),
//                                 Expanded(child: Column(
//                                   children: <Widget>[
//                                     Text("3025"),
//                                     Text("Comments")
//                                   ],
//                                 ),),
//                                 Expanded(child: Column(
//                                   children: <Widget>[
//                                     Text("650"),
//                                     Text("Favourites")
//                                   ],
//                                 ),),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         height: 80,
//                         width: 80,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10.0),
//                           image: DecorationImage(
//                             image: CachedNetworkImageProvider(image),
//                             fit: BoxFit.cover
//                           )
//                         ),
//                         margin: EdgeInsets.only(left: 16.0),
//                         ),
//                     ],
//                   ),

//                   SizedBox(height: 20.0),
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(5.0),
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         ListTile(title: Text("User information"),),
//                         Divider(),
//                         ListTile(
//                           title: Text("Email"),
//                           subtitle: Text("butterfly.little@gmail.com"),
//                           leading: Icon(Icons.email),
//                         ),
//                         ListTile(
//                           title: Text("Phone"),
//                           subtitle: Text("+977-9815225566"),
//                           leading: Icon(Icons.phone),
//                         ),
//                         ListTile(
//                           title: Text("Website"),
//                           subtitle: Text("https://www.littlebutterfly.com"),
//                           leading: Icon(Icons.web),
//                         ),
//                         ListTile(
//                           title: Text("About"),
//                           subtitle: Text("Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
//                           leading: Icon(Icons.person),
//                         ),
//                         ListTile(
//                           title: Text("Joined Date"),
//                           subtitle: Text("15 February 2019"),
//                           leading: Icon(Icons.calendar_view_day),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             AppBar(
//               backgroundColor: Colors.transparent,
//               elevation: 0,
//             )
//           ],
//         ),
//       ),
//     );
//   }

//        */
//starting new thing

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ui_challenges/core/presentation/res/assets.dart';
// import 'package:flutter_ui_challenges/src/widgets/network_image.dart';
class ProfileThreePage extends StatelessWidget {
  static final String path = "lib/src/pages/profile/profile3.dart";
  //final image = avatars[1];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 250,
              width: double.infinity,
              //child: PNetworkImage(image, fit: BoxFit.cover,),
              child: Image(image: NetworkImage("https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-photo%2Fmountains-during-sunset-beautiful-natural-260nw-407021107.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fcategory%2Fnature&tbnid=wW5BhncqphFQ0M&vet=12ahUKEwi4pd6lyNjoAhUsHLcAHX1NDkAQMygBegUIARCWAg..i&docid=LlgDpz1LoiuznM&w=435&h=280&q=images&safe=active&ved=2ahUKEwi4pd6lyNjoAhUsHLcAHX1NDkAQMygBegUIARCWAg")),

            ),
            Container(
              margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(left: 96.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Little Butterfly", style: Theme.of(context).textTheme.title,),
                                  ListTile(
                                    contentPadding: EdgeInsets.all(0),
                                    title: Text("Product Designer"),
                                    subtitle: Text("Kathmandu"),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("285"),
                                    Text("Likes")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("3025"),
                                    Text("Comments")
                                  ],
                                ),),
                                Expanded(child: Column(
                                  children: <Widget>[
                                    Text("650"),
                                    Text("Favourites")
                                  ],
                                ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: NetworkImage("https://www.google.com/imgres?imgurl=https%3A%2F%2Fimage.shutterstock.com%2Fimage-photo%2Fmountains-during-sunset-beautiful-natural-260nw-407021107.jpg&imgrefurl=https%3A%2F%2Fwww.shutterstock.com%2Fcategory%2Fnature&tbnid=wW5BhncqphFQ0M&vet=12ahUKEwi4pd6lyNjoAhUsHLcAHX1NDkAQMygBegUIARCWAg..i&docid=LlgDpz1LoiuznM&w=435&h=280&q=images&safe=active&ved=2ahUKEwi4pd6lyNjoAhUsHLcAHX1NDkAQMygBegUIARCWAg"),
                            fit: BoxFit.cover
                          )
                        ),
                        margin: EdgeInsets.only(left: 16.0),
                        ),
                    ],
                  ),

                  SizedBox(height: 20.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        ListTile(title: Text("User information"),),
                        Divider(),
                        ListTile(
                          title: Text("Email"),
                          subtitle: Text("butterfly.little@gmail.com"),
                          leading: Icon(Icons.email),
                        ),
                        ListTile(
                          title: Text("Phone"),
                          subtitle: Text("+977-9815225566"),
                          leading: Icon(Icons.phone),
                        ),
                        ListTile(
                          title: Text("Website"),
                          subtitle: Text("https://www.littlebutterfly.com"),
                          leading: Icon(Icons.web),
                        ),
                        ListTile(
                          title: Text("About"),
                          subtitle: Text("Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
                          leading: Icon(Icons.person),
                        ),
                        ListTile(
                          title: Text("Joined Date"),
                          subtitle: Text("15 February 2019"),
                          leading: Icon(Icons.calendar_view_day),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            )
          ],
        ),
      ),
    );
  }
}