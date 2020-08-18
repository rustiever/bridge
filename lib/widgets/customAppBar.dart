import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/router.dart';
import 'package:Bridge/services/FirebaseAuth.dart';
import 'package:Bridge/services/Service.dart';
import 'package:Bridge/stateProviders/Providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'widgets.dart';

class CustomAppBar extends HookWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({
    Key key,
    @required this.currentUser,
    @required this.icons,
    @required this.selectedIndex,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'bridge',
              style: const TextStyle(
                color: Palette.facebookBlue,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              selectedIndex: selectedIndex,
              onTap: onTap,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                user != null
                    ? UserCard(user: currentUser)
                    : InkWell(
                        onTap: () async {
                          List<dynamic> res =
                              await FirebaseAuthService().signInWithGoogle();
                          try {
                            var user = await ApiService.instance.login(
                                newUser: res[0],
                                user: res[1],
                                tokenResult: res[2]);
                            print(user.userData.email);
                            print(user.authorizeToken);
                            // setState(() {});
                            Navigator.of(context)
                                .pushReplacementNamed(Homeroute);
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ProfileAvatar(imageUrl: null),
                            const SizedBox(width: 6.0),
                            Flexible(
                              child: Text(
                                'login',
                                style: const TextStyle(fontSize: 16.0),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(width: 12.0),
                CircleButton(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () => print('Search'),
                ),
                CircleButton(
                  icon: MdiIcons.facebookMessenger,
                  iconSize: 30.0,
                  onPressed: () => print('Messenger'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
