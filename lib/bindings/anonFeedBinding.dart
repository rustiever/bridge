import 'package:Bridge/controllers/anonFeedController.dart';
import 'package:get/get.dart';

class AnonFeedBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AnonFeedController>(() {
      return AnonFeedController();
    });
  }
}
