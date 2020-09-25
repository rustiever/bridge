import 'dart:async';

import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class CommentController extends GetxController {
  static CommentController get to => Get.find();
  final Repository repository;
  CommentController({@required this.repository}) : assert(repository != null);
  static HomeController get homeController => Get.find();
  ScrollController commentScrollController;

  CommentModel commentModel;
  List<CommentDatum> comments = [];

  bool isCommentMoreAvailable = true, isCommentLoading = false;
  dynamic commentTime;

  @override
  void onInit() {
    comments.clear();
    commentTime = null;
    _getComments();
    commentScrollController = ScrollController()
      ..addListener(() {
        if (commentScrollController.position.pixels >=
            commentScrollController.position.maxScrollExtent) {
          _getComments();
        }
      });
    super.onInit();
  }

  @override
  FutureOr onClose() {
    // print('on close ');
    commentScrollController?.dispose();
    return super.onClose();
  }

  _getComments() async {
    // print('comments $isCommentMoreAvailable ${Get.isBottomSheetOpen}');
    if (!isCommentLoading && isCommentMoreAvailable) {
      await _fetchComments();
    }
  }

  Future<void> _fetchComments() async {
    if (isCommentMoreAvailable) {
      isCommentLoading = true;
      commentModel = await repository.getComments(
          time: commentTime,
          authorizeToken: homeController.user.authorizeToken,
          postId: homeController.feeds[homeController.feedIndex].postId);
      commentTime = commentModel.lastTime;
      if (commentTime == null) isCommentMoreAvailable = false;
      comments.addAll(commentModel.commentData);
      isCommentLoading = false;
    } else {}

    update();
  }
}
