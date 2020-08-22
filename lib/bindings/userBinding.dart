import 'package:Bridge/controllers/userController.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart';

class UserBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserController>(() {
      Get.put(Client());
      Get.put(ApiService(httpClient: Get.find()));
      Get.put(Repository(service: Get.find()));
      return UserController(repository: Get.find());
    });
  }
}
