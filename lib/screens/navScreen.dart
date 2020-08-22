import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/Users.dart';
import 'package:Bridge/router.dart';
import 'package:Bridge/screens/screens.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class NavController extends GetxController {
  var selectedIndex = 0.obs;
  TrackingScrollController trackingScrollController;
  @override
  onClose() {
    print('nav onclose func');
    trackingScrollController?.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    trackingScrollController = TrackingScrollController();
    super.onInit();
  }
}

class NavScreen extends StatelessWidget {
  final User user;
  final List<IconData> _icons = const [
    Icons.home,
    // Icons.ondemand_video,
    // MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    MdiIcons.accountCircleOutline,
    Icons.menu,
  ];
  final FeedController aController = Get.find();
  final NavController nav = Get.put(NavController());
  final UserController controller = Get.find();

  final List<Widget> _screens = [
    Homee(),
    // Scaffold(),
    // Scaffold(),
    Scaffold(),
    Profile(),
    Settings()
  ];

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
                  // currentUser: controller.user.value,
                  currentUser: null,
                  icons: _icons,
                  selectedIndex: nav.selectedIndex.value,
                  onTap: (index) {
                    nav.selectedIndex.value = index;
                    print(nav.selectedIndex.value);
                  },
                ),
              )
            : null,
        body: Obx(
          () => IndexedStack(
            index: nav.selectedIndex.value,
            children: _screens,
          ),
        ),
        bottomNavigationBar: !Responsive.isDesktop(context)
            ? Container(
                padding: const EdgeInsets.only(bottom: 12.0),
                color: Colors.white,
                child: CustomTabBar(
                  icons: _icons,
                  selectedIndex: nav.selectedIndex.value,
                  onTap: (index) => nav.selectedIndex.value = index,
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            onPressed: Get.find<UserController>().user != null
                ? () async {
                    try {
                      var status = await authController.logout();
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
