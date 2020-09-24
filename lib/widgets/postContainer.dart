import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/comments.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'widgets.dart';

class PostContainer extends GetView<HomeController> {
  final int index;

  const PostContainer({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    // controller.index(index);
    return GetBuilder<HomeController>(
      builder: (_) {
        // if (controller.status == Status.LOADING) {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
        return Card(
          margin: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: isDesktop ? 5.0 : 0.0,
          ),
          elevation: isDesktop ? 1.0 : 0.0,
          shape: isDesktop
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0))
              : null,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _PostHeader(
                        index: index,

                        // post: controller.feedList[index],
                      ),
                      const SizedBox(height: 4.0),
                      Text(controller.feeds[index].caption),
                      controller.feeds[index].photoUrl != null
                          ? const SizedBox.shrink()
                          : const SizedBox(height: 6.0),
                    ],
                  ),
                ),
                controller.feeds[index].photoUrl != null
                    ? Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CachedNetworkImage(
                          imageUrl: controller.feeds[index].photoUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          placeholderFadeInDuration:
                              Duration(milliseconds: 400),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                        // child: Image.network(post.photoUrl),
                      )
                    : const SizedBox.shrink(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: _PostStats(
                    index: index,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PostHeader extends GetView<HomeController> {
  final int index;

  const _PostHeader({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // ProfileAvatar(imageUrl: post.ownerPhotoUrl),
        ProfileAvatar(imageUrl: controller.feeds[index].ownerPhotoUrl),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.feeds[index].ownerName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${timeago.format(DateTime.fromMillisecondsSinceEpoch(controller.feeds[index].timeStamp.seconds * 1000), locale: 'en_short')} • ',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  Icon(
                    Icons.public,
                    color: Colors.grey[600],
                    size: 12.0,
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.more_horiz),
          // ignore: avoid_print
          onPressed: () => print('More'),
        ),
      ],
    );
  }
}

class _PostStats extends GetView<HomeController> {
  final int index;

  const _PostStats({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Palette.facebookBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                controller.feeds[index].likes.toString(),
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            Text(
              '${controller.feeds[index].comments} Comments',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(width: 8.0),
            Text(
              '${controller.feedIndex.toString()} Shares',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
        const Divider(),
        Row(
          children: [
            _PostButton(
              icon: Icon(
                MdiIcons.thumbUpOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Like',
              onTap: () async {
                // ignore: avoid_print
                print('Like');
                if (controller.user != null) {
                  controller.index = index;
                  await controller.getLikes();
                }
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.commentOutline,
                color: Colors.grey[600],
                size: 20.0,
              ),
              label: 'Comment',
              onTap: () async {
                print('Comment');
                if (controller.user != null) {
                  controller.index = index;
                  // controller.getComments();
                  Get.bottomSheet(_CommentBuild(),
                      isScrollControlled: true,
                      ignoreSafeArea: false,
                      enableDrag: true);
                }
              },
            ),
            _PostButton(
              icon: Icon(
                MdiIcons.shareOutline,
                color: Colors.grey[600],
                size: 25.0,
              ),
              label: 'Share',
              onTap: () {
                // ignore: avoid_print
                print('Share');
              },
            )
          ],
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final void Function() onTap;

  const _PostButton({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 2.0),
                Flexible(child: Text(label)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommentBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
      init: CommentController(repository: Get.find()),
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
              itemCount: _.comments.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    ProfileAvatar(
                      imageUrl: HomeController.to.feeds[index].ownerPhotoUrl,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${_.comments[index].name}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * .6),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: Color(0xfff9f9f9),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            "${_.comments[index].id}",
                            style: Theme.of(context).textTheme.bodyText1.apply(
                                  color: Colors.black87,
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Text(
                      "{messages}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .apply(color: Colors.grey),
                    ),
                  ],
                );
              }),
          Container(
            margin: const EdgeInsets.all(15.0),
            height: 61,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35.0),
                      boxShadow: [
                        const BoxShadow(
                            offset: Offset(0, 3),
                            blurRadius: 5,
                            color: Colors.grey)
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            icon: const Icon(Icons.face), onPressed: () {}),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                hintText:
                                    "Type Something...{HomeController.to.comments.length}",
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.photo_camera),
                          onPressed: () {
                            // print('hh');
                            HomeController.to.clearComments();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.attach_file),
                          onPressed: () {
                            HomeController.to.comments.add(CommentDatum(
                                id: null,
                                time: null,
                                edited: null,
                                name: null));
                          },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: const BoxDecoration(
                      color: Colors.green, shape: BoxShape.circle),
                  child: InkWell(
                    onTap: () {
                      // HomeController.to.clearComments();
                      Get.back();
                    },
                    child: const Icon(
                      Icons.keyboard_voice,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
