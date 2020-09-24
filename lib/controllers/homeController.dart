import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/comments.dart';
import '../models/models.dart';
import '../models/repository/repository.dart';

// class HomeControllers extends GetxController {
//   static HomeControllers get to => Get.find();
//   final Repository repository;
//   HomeControllers({@required this.repository}) : assert(repository != null);

//   var selectedIndex = 0.obs; // tab index used to navigate the tabs
//   final Rx<User> user = User().obs;
//   final Rx<FeedModel> feeds = Rx<FeedModel>();
//   final feedList = [].obs;
//   final RxInt likes = 0.obs;
//   TrackingScrollController trackingScrollController;
//   ScrollController commentScrollController;
//   var time;
//   final isLoading = false.obs;
//   FeedModel v = FeedModel();

//   @override
//   void onInit() {
//     time = null;
//     trackingScrollController = TrackingScrollController();
//     trackingScrollController.addListener(() {
//       if (trackingScrollController.position.pixels >=
//           trackingScrollController.position.maxScrollExtent) {
//         // fetchFeeds();
//         // print(feeds.value.length);
//         getMe();
//       }
//     });

//     getUser();
//     fetchFeeds();
//     // ever(, (d) {});
//     debugPrint('on init of HomeController');
//     super.onInit();
//   }

//   Future getLikes(int index) async {
//     // enhance the like method
//     // var like = await repository.getLike(feedList[index].postId);
//     // feedList[index].likes = like['likes'];
//     feedList[index].likes++;
// // feedList
//     // likes.value = feedList[index].likes;
//     // print(like);
//     print(feedList[index].likes.toString());
//     likes.value++;
//     update();
//   }

//   var ff = 2;
//   getMe() async {
//     // feedList.add(ff++);
//     if (!isLoading.value && isMoreAvailable.value)
//       fetchFeeds();
//     else
//       print('done');
//     print(ff);
//   }

//   @override
//   void onReady() {
//     super.onReady();
//   }

//   @override
//   //// ignore: missing_return
//   onClose() {
//     // print('on close ');
//     trackingScrollController?.dispose();
//     super.onClose();
//     return null;
//   }

//   Future<bool> login(UserType userType) async =>
//       await repository.login(userType);

//   // Future<bool> logout() async => await repository.logout();

//   void getUser() {
//     user.value = repository.getUser();
//     // print(user?.value?.userData?.usn);
//   }

//   var isMoreAvailable = true.obs;
//   void fetchFeeds({inot}) async {
//     if (isMoreAvailable.value) {
//       isLoading.value = true;
//       // feeds.value = await repository.getFeeds(time);
//       time = feeds.value.lastTime;
//       if (time == null) {
//         isMoreAvailable.value = false;
//       }
//       feedList.addAll(feeds.value.feedData);
//       if (feeds.value == null) {
//         Get.snackbar("Error", "Can't connect to server");
//       }
//       isLoading.value = false;
//     }
//     update();
//   }
// }

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  User user;
  TrackingScrollController trackingScrollController;
  ScrollController commentScrollController;
  RxList<FeedDatum> feed = <FeedDatum>[].obs;
  Rx v;
  Rx<FeedModel> ff = FeedModel().obs;
  FeedModel feedModel;
  List<FeedDatum> feeds = [];
  CommentModel commentModel;
  List<CommentDatum> comments = [];
  bool isFeedMoreAvailable = true,
      isCommentMoreAvailable = true,
      isFeedLoading = true,
      isCommentLoading = false;
  dynamic feedTime, commentTime;

  int feedIndex;
  int count = 0;

  HomeController({@required this.repository}) : assert(repository != null);

  int get index => feedIndex;

  set index(int index) => {
        feedIndex = index,
      };

  // inc() {
  //   count++;
  //   isFeedMoreAvailable = !isFeedMoreAvailable;
  //   update();
  // }

  void clearComments() {
    comments.clear();
    // print(comments.length);
    update();
  }

  void fetchFeeds() {
    if (!isFeedLoading && isFeedMoreAvailable) {
      // print('feeds');
      _getFeeds();
    }
  }

  Future getLikes() async {
    feeds[feedIndex].likes = (await repository.getLike(
        postId: feeds[feedIndex].postId,
        authorizeToken: user.authorizeToken))['likes'] as int;

    update();
    // print(feeds[feedIndex].likes.toString());
  }

  void getUser() {
    user = repository.getUser();
    update();
  }

  Future<bool> logout() => repository.logout(user.authorizeToken);

  // getComments() async {
  //   print('comments $isCommentMoreAvailable ${Get.isBottomSheetOpen}');
  //   if (!Get.isBottomSheetOpen) {
  //     feeds.clear();
  //     print(feeds.length);
  //   }
  //   if (!isCommentLoading && isCommentMoreAvailable) {
  //     await _fetchComments();
  //   }
  // }

  // Future<void> _fetchComments() async {
  //   print(feeds[feedIndex].postId);
  //   isCommentLoading = true;
  //   // this.commentModel = await repository.getComments(
  //   //     time: commentTime,
  //   //     authorizeToken: user.authorizeToken,
  //   //     postId: feeds[feedIndex].postId);
  //   // if (commentTime == null) isCommentMoreAvailable = false;
  //   // comments.addAll(commentModel.commentData);

  //   // comments.forEach((element) {
  //   //   print(element.id);
  //   // });
  //   isCommentLoading = false;

  //   update();
  // }

  @override
  FutureOr onClose() {
    // print('on close ');
    trackingScrollController?.dispose();
    commentScrollController?.dispose();
    return super.onClose();
  }

  @override
  void onInit() {
    // print('oninit ');
    feedTime = commentTime = null;

    getUser();
    _getFeeds();
    trackingScrollController = TrackingScrollController()
      ..addListener(() {
        if (trackingScrollController.position.pixels >=
            trackingScrollController.position.maxScrollExtent) {
          // print('hello');
          fetchFeeds();
        }
      });
    commentScrollController = ScrollController()
      ..addListener(() {
        if (commentScrollController.position.pixels >=
            commentScrollController.position.maxScrollExtent) {
          // print('comments scroll end  ');
          // _fetchComments();
        }
      });
    super.onInit();
  }

  Future<void> _getFeeds() async {
    if (isFeedMoreAvailable) {
      isFeedLoading = true;
      feedModel = await repository.getFeeds(time: feedTime, user: user);
      ff.value = feedModel;
      feed.addAll(ff.value.feedData);
      feedTime = feedModel.lastTime;
      // print(feedTime);
      if (feedTime == null) {
        isFeedMoreAvailable = false;
      }
      feeds.addAll(feedModel.feedData);
      isFeedLoading = false;
    } else {
      // print('nothing');
    }
    update();
  }
}
