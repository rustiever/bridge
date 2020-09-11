import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeView extends GetView<HomeController> {
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
    return GetBuilder<PagesController>(
      builder: (_) => DefaultTabController(
        length: 3,
        child: Scaffold(
          body: _.currentPage,
          bottomNavigationBar: CustomTabBar(icons: _icons),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    Key key,
    @required List<IconData> icons,
  })  : _icons = icons,
        super(key: key);

  final List<IconData> _icons;

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
        onTap: (value) => PagesController.to.changeIndex(value),
        tabs: _icons
            .asMap()
            .map(
              (i, e) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    e,
                    color: i == PagesController.to.tabIndex
                        ? Palette.facebookBlue
                        : Colors.black45,
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
