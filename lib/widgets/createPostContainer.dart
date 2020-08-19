import 'package:Bridge/models/Users.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'widgets.dart';

class CreatePostContainer extends StatelessWidget {
  final User currentUser;

  const CreatePostContainer({
    Key key,
    @required this.currentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
      margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
          : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 5.0),

                ProfileAvatar(
                    imageUrl: currentUser?.userData?.photoURL ?? null),
                const SizedBox(width: 8.0),
                // Expanded(
                //   child: TextField(
                //     decoration: InputDecoration.collapsed(

                //       hintText: 'What\'s on your mind?',
                //     ),
                //   ),
                // )
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[400]),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Center(
                      child: Text(
                        'What\'s on your mind?',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    height: 40,
                    width: double.infinity,
                  ),
                ),
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton.icon(
                    onPressed: () => print('Photo'),
                    icon: const Icon(
                      MdiIcons.imagePlus,
                      color: Colors.green,
                    ),
                    label: Text('Photo'),
                  ),
                  const VerticalDivider(width: 10.0),
                  FlatButton.icon(
                    onPressed: () => print('Room'),
                    icon: const Icon(
                      MdiIcons.poll,
                      color: Colors.purpleAccent,
                    ),
                    label: Text('Poll'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
