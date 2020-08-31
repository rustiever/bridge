import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  HomeController({@required this.repository}) : assert(repository != null);

  var selectedIndex = 0.obs; // tab index used to navigate the tabs
  final Rx<User> user = User().obs;
  final Rx<FeedModel> feeds = Rx<FeedModel>();
  List feedList = [];
  TrackingScrollController trackingScrollController;
  var time;
  final isLoading = false.obs;
  FeedModel v = FeedModel();

  @override
  void onInit() {
    time = null;
    trackingScrollController = TrackingScrollController();
    trackingScrollController.addListener(() {
      if (trackingScrollController.position.pixels >=
          trackingScrollController.position.maxScrollExtent) {
        // fetchFeeds();
        // print(feeds.value.length);
        getMe();
      }
    });
    getUser();
    fetchFeeds();
    // ever(, (d) {});
    debugPrint('on init of HomeController');
    super.onInit();
  }

  var ff = 2;
  getMe() async {
    // feedList.add(ff++);
    if (!isLoading.value && isMoreAvailable.value)
      fetchFeeds();
    else
      print('done');
    print(ff);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  onClose() {
    // print('on close ');
    trackingScrollController?.dispose();
    super.onClose();
  }

  Future<bool> login(UserType userType) async =>
      await repository.login(userType);

  Future<bool> logout() async => await repository.logout();

  void getUser() {
    user.value = repository.getUser();
    // print(user?.value?.userData?.usn);
  }

  var isMoreAvailable = true.obs;
  void fetchFeeds({inot}) async {
    if (isMoreAvailable.value) {
      isLoading.value = true;
      // feeds.value = FeedModel.fromRawJson(
      //     '{"lastTime":null,"feedData":[{"postId":"MDVmVt1YPOzrvxrRfg8v","caption":"THIS IS A POST WITH NUMBER-20","likes":0,"photoUrl":"https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80","ownerName":"Sharan","ownerPhotoUrl":"https://firebasestorage.googleapis.com/v0/b/bridge-fd58f.appspot.com/o/DummyPost%2FWIN_20191024_15_45_00_Pro.jpg?alt=media&token=9d061db8-c7db-4dbd-85ea-48faaddb93d4","ownerUid":"H3KOr0tq8Wcg5cK8HIY6AeRRZj73","timeStamp":{"seconds":1598800417,"nanoseconds":438000000},"scope":false,"comments":0},{"postId":"vrZq7qU8LyecdjKeDy0F","caption":"THIS IS A POST WITH NUMBER-11","likes":0,"photoUrl":"https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80","ownerName":"Sharan","ownerPhotoUrl":"https://firebasestorage.googleapis.com/v0/b/bridge-fd58f.appspot.com/o/DummyPost%2FWIN_20191024_15_45_00_Pro.jpg?alt=media&token=9d061db8-c7db-4dbd-85ea-48faaddb93d4","ownerUid":"H3KOr0tq8Wcg5cK8HIY6AeRRZj73","timeStamp":{"seconds":1598800188,"nanoseconds":941000000},"scope":false,"comments":0}]}');
      feeds.value = await repository.getFeeds(time);
      time = feeds.value.lastTime;
      if (time == null) {
        isMoreAvailable.value = false;
      }
      feedList.addAll(feeds.value.feedData);
      if (feeds.value == null) {
        Get.snackbar("Error", "Can't connect to server");
      }
      isLoading.value = false;
    }
    update();
  }
}
