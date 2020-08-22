import 'package:Bridge/controllers/anonFeedController.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class AnonFeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnonFeedController>(() {
      Get.put(Client());
      Get.put(ApiService(httpClient: Get.find()));
      Get.put(Repository(service: Get.find()));
      return AnonFeedController(repository: Get.find());
    });
  }
}
