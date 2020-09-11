import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/controllers/authController.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeControllers extends GetxController {
  static HomeControllers get to => Get.find();
  final Repository repository;
  HomeControllers({@required this.repository}) : assert(repository != null);

  var selectedIndex = 0.obs; // tab index used to navigate the tabs
  final Rx<User> user = User().obs;
  final Rx<FeedModel> feeds = Rx<FeedModel>();
  final feedList = [].obs;
  final RxInt likes = 0.obs;
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

  Future getLikes(int index) async {
    // enhance the like method
    // var like = await repository.getLike(feedList[index].postId);
    // feedList[index].likes = like['likes'];
    feedList[index].likes++;
// feedList
    // likes.value = feedList[index].likes;
    // print(like);
    print(feedList[index].likes.toString());
    likes.value++;
    update();
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
  //// ignore: missing_return
  onClose() {
    // print('on close ');
    trackingScrollController?.dispose();
    super.onClose();
    return null;
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

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  HomeController({@required this.repository}) : assert(repository != null);
  User user;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  getUser() {
    this.user = repository.getUser();
    // update();
  }

  Future<bool> logout() => repository.logout();
}
