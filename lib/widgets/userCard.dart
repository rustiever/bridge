import 'package:Bridge/models/Users.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({
    Key key,
    @required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProfileAvatar(imageUrl: user?.userData?.photoUrl ?? null),
          const SizedBox(width: 6.0),
          Flexible(
            child: Text(
              user?.userData?.name ?? '',
              style: const TextStyle(fontSize: 16.0),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
