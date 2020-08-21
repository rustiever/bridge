import 'package:Bridge/controllers/userController.dart';

import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() {
      return UserController();
    });
  }
}
