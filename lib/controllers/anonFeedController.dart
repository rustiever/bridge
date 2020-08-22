import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class AnonFeedController extends GetxController {
  final Repository repository;

  AnonFeedController({this.repository});

  Rx<FeedModel> feeds = Rx<FeedModel>();

  @override
  void onInit() => fetchFeeds();

  void fetchFeeds() async {
    feeds.value = await repository.anonFeeds();
    if (feeds.value == null) {
      Get.snackbar("Error", "Can't connect to server");
    }
  }
}
