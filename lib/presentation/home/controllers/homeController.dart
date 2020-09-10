import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  final tabIndex = 0.obs;
  final status = Status.loading.obs;
  TrackingScrollController trackingScrollController;

  @override
  Future<void> onClose() {
    trackingScrollController.dispose();
    return super.onClose();
  }

  @override
  void onInit() {
    trackingScrollController = TrackingScrollController()
      ..addListener(() {
        if (trackingScrollController.position.pixels >=
            trackingScrollController.position.maxScrollExtent) {}
      });
    super.onInit();
  }
}
