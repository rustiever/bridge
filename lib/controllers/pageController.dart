import 'package:Bridge/views/views.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class PagesController extends GetxController {
  static PagesController get to => Get.find();

  int tabIndex;
  Widget currentPage;

  @override
  void onInit() {
    this.tabIndex = 0;
    this.currentPage = _changeView(this.tabIndex);
  }

  Widget _changeView(int index) {
    switch (index) {
      case 0:
        return FeedView();
        break;
      case 1:
        return ProfileView();
        break;
      case 2:
        return SettingsView();
        break;
      default:
        return FeedView();
    }
  }

  void changeView(Widget view) {
    this.currentPage = view;
    update();
  }

  void changeIndex(int index) {
    this.tabIndex = index;
    this.currentPage = _changeView(index);
    update();
  }
}
