import 'package:Bridge/controllers/authController.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() {
      // Get.put(http.Client());
      // Get.put(ApiService(http: Get.find()));
      // Get.put<Repository>(Repository(service: Get.find()));
      return Get.put(AuthController(repository: Get.find()));
    });
  }
}
