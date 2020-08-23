import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  var selectedIndex = 0.obs; // tab index used to navigate the tabs
  final Rx<User> user = User().obs;
  TrackingScrollController trackingScrollController;

  @override
  void onInit() {
    trackingScrollController = TrackingScrollController();
    getUser();
    // ever(listener, callback)
    debugPrint('on init of HomeController');
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  onClose() {
    print('on close ');
    trackingScrollController?.dispose();
    super.onClose();
  }

  Future<bool> login(UserType userType) async =>
      await repository.login(userType);

  Future<bool> logout() async => await repository.logout();

  void getUser() => user.value = repository.getUser();
}
