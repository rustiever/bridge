import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/Users.dart';
import 'package:Bridge/router.dart';
import 'package:Bridge/screens/screens.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavScreen extends GetWidget<HomeController> {
  final User user;
  final List<IconData> _icons = const [
    MdiIcons.home,
    // Icons.ondemand_video,
    // MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    MdiIcons.accountCircleOutline,
    Icons.menu,
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    // Scaffold(),
    // Scaffold(),
    Scaffold(),
    Profile(),
    Settings()
  ];

  // final UserController u = Get.find();

  NavScreen({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: Size(screenSize.width, 100.0),
                child: CustomAppBar(
                  currentUser: controller.user.value,
                  icons: _icons,
                  selectedIndex: controller.selectedIndex.value,
                  onTap: (index) {
                    controller.selectedIndex.value = index;
                    print(controller.selectedIndex.value);
                  },
                ),
              )
            : null,
        body: Obx(
          () => IndexedStack(
            index: controller.selectedIndex.value,
            children: _screens,
          ),
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _icons,
                  selectedIndex: controller.selectedIndex.value,
                  onTap: (index) => controller.selectedIndex.value = index,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class Settings extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: controller.user != null
                ? () async {
                    try {
                      var status = await controller.logout();
                      print(status);
                      Get.offAllNamed(Authroute);
                    } catch (e) {
                      print(e);
                    }
                  }
                : null,
            child: Text('logout'),
          )
        ],
      ),
    );
  }
}
