import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class CommentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CommentController>(
      () {
        Get.put(Client());
        Get.put(ApiService(httpClient: Get.find()));
        Get.put(Repository(service: Get.find()));
        return CommentController(repository: Get.find());
      },
    );
  }
}
