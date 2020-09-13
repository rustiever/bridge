import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () {
        Get.put(Client());
        Get.put(ApiService(httpClient: Get.find()));
        Get.put(Repository(service: Get.find()));
        return HomeController(repository: Get.find());
      },
    );
  }
}
