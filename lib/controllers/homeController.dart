import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/comments.dart';
import '../models/models.dart';
import '../models/repository/repository.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  final Repository repository;
  User user;
  TrackingScrollController trackingScrollController;
  ScrollController commentScrollController;

  FeedModel feedModel;
  CommentModel commentModel;

  List<FeedDatum> feeds = [];
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

  Future<void> fetchFeeds() async {
    if (!isFeedLoading && isFeedMoreAvailable) {
      // print('feeds');
      await _getFeeds();
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

  @override
  FutureOr onClose() {
    // print('on close ');
    trackingScrollController?.dispose();
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

    super.onInit();
  }

  Future<void> _getFeeds() async {
    if (isFeedMoreAvailable) {
      isFeedLoading = true;
      feedModel = await repository.getFeeds(time: feedTime, user: user);
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
