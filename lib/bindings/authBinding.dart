import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../controllers/authController.dart';
import '../models/repository/repository.dart';
import '../services/Service.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() {
      Get.put(http.Client());
      Get.put(ApiService(httpClient: Get.find()));
      Get.put(Repository(service: Get.find()));
      return Get.put(AuthController(repository: Get.find()));
    });
  }
}
