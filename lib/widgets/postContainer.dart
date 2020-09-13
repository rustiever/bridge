import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/controllers/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    controller.index = index;
    final bool isDesktop = Responsive.isDesktop(context);
    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.status == Status.LOADING) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
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
              decoration: BoxDecoration(
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
              '${controller.feeds[index].comments} Shares',
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
              onTap: () {
                print('Like');
                if (controller.user != null) {
                  controller.index = index;
                  controller.getLikes();
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
                  // controller.index = index;
                  controller.getComments();
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
              onTap: () => print('Share'),
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
  final Function onTap;

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
