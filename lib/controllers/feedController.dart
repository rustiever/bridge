import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class FeedController extends GetxController {
  final Repository repository;

  FeedController({this.repository});

  Rx<FeedModel> feeds = Rx<FeedModel>();

  @override
  void onInit() => fetchFeeds(inot: 34);

  void fetchFeeds({inot}) async {
    feeds.value = await repository.getFeeds(null);
    if (feeds.value == null) {
      Get.snackbar("Error", "Can't connect to server");
    }
  }
}
