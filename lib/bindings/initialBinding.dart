import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

// this is for future implementation

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() {
      Get.put(Client());
      Get.put(ApiService(httpClient: Get.find()));
      Get.put(Repository(service: Get.find()));
    });
  }
}
