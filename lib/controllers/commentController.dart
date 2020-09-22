import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class CommentController extends GetxController {
  static CommentController get to => Get.find();
  final Repository repository;
  CommentController({@required this.repository}) : assert(repository != null);
  static HomeController get hc => Get.find();
  ScrollController commentScrollController;

  CommentModel commentModel;
  List<CommentDatum> comments = [];

  bool isCommentMoreAvailable = true, isCommentLoading = false;
  dynamic commentTime;

  @override
  void onInit() {
    commentTime = null;
    super.onInit();
  }

  @override
  Future<void> onClose() {
    // print('on close ');
    commentScrollController?.dispose();
    return super.onClose();
  }

  getComments() async {
    print('comments $isCommentMoreAvailable ${Get.isBottomSheetOpen}');
    // if (!Get.isBottomSheetOpen) {
    //   feeds.clear();
    //   print(feeds.length);
    // }
    if (!isCommentLoading && isCommentMoreAvailable) {
      await _fetchComments();
    }
  }

  Future<void> _fetchComments() async {
    print(hc.feeds[hc.feedIndex].postId);
    isCommentLoading = true;
    // this.commentModel = await repository.getComments(
    //     time: commentTime,
    //     authorizeToken: user.authorizeToken,
    //     postId: feeds[feedIndex].postId);
    // if (commentTime == null) isCommentMoreAvailable = false;
    // comments.addAll(commentModel.commentData);

    // comments.forEach((element) {
    //   print(element.id);
    // });
    isCommentLoading = false;

    update();
  }
}
