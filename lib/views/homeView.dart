import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends StatelessWidget {
  final List<IconData> _icons = const [
    MdiIcons.home,
    // Icons.ondemand_video,
    // MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    MdiIcons.accountCircleOutline,
    // Icons.menu,
  ];
  @override
  Widget build(BuildContext context) {
    return ValueBuilder(
      initialValue: 0,
      builder: (value, void Function(dynamic) updater) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: IndexedStack(
            index: value,
            children: [FeedView(), ProfileView(), SettingsView()],
          ),
          bottomNavigationBar: CustomTabBar(
            icons: _icons,
            ontap: updater,
            index: value,
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key key,
    @required List<IconData> icons,
    @required this.ontap,
    @required this.index,
  })  : _icons = icons,
        super(key: key);

  final List<IconData> _icons;
  final ontap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12.0),
      color: Colors.white,
      child: TabBar(
        indicatorPadding: EdgeInsets.zero,
        indicator: BoxDecoration(
          border: Border(
            top: BorderSide(color: Palette.facebookBlue, width: 3.0),
          ),
        ),
        onTap: (value) => ontap(value),
        tabs: _icons
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == index ? Palette.facebookBlue : Colors.black45,
                    size: 30.0,
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
