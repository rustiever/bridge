import '../constants/constants.dart';
import '../controllers/controllers.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../router.dart';

class FeedView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile:
            FeedMobile(scrollController: controller.trackingScrollController),
        desktop: FeedDesktop(
          scrollController: controller.trackingScrollController,
        ),
      ),
    );
  }
}

class FeedMobile extends GetView<HomeController> {
  final scrollController;

  const FeedMobile({Key key, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        if (controller.isFeedLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text(
                'bridge',
                style: const TextStyle(
                  color: Palette.facebookBlue,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              centerTitle: false,
              floating: true,
              actions: [
                CircleButton(
                  icon: Icons.search,
                  iconSize: 30.0,
                  onPressed: () async {
                    print('Search');
                    if (await controller.logout()) {
                      await Get.offAllNamed(Authroute);
                    } else {
                      Get.snackbar('Sorry',
                          'Looks like no connection, Try with proper connection');
                    }
                  },
                ),
                CircleButton(
                  icon: MdiIcons.filter,
                  iconSize: 30.0,
                  onPressed: () async {
                    print('filter');
                    await Get.offAllNamed(Authroute);
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: controller.user),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // print(controller.feeds.length);
                  return PostCon(
                    index: index,
                  );
                },
                childCount: controller.feeds.length,
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     child: controller.isFeedMoreAvailable
            //         ? Center(
            //             child: CircularProgressIndicator(),
            //           )
            //         : Center(
            //             child: Text('End'),
            //           ),
            //   ),
            // ),
          ],
        );
      },
    );
  }
}

class PostCon extends StatelessWidget {
  final index;

  const PostCon({Key key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    // print(HomeController.to.feedIndex);
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: isDesktop ? 5.0 : 0.0,
      ),
      elevation: isDesktop ? 1.0 : 0.0,
      shape: isDesktop
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))
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
                  Row(
                    children: [
                      ProfileAvatar(
                          imageUrl:
                              HomeController.to.feeds[index].ownerPhotoUrl),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              HomeController.to.feeds[index].ownerName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  '${timeago.format(DateTime.fromMillisecondsSinceEpoch(HomeController.to.feeds[index].timeStamp.seconds * 1000), locale: 'en_short')} • ',
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
                  ),
                  const SizedBox(height: 4.0),
                  Text(HomeController.to.feeds[index].caption),
                  HomeController.to.feeds[index].photoUrl != null
                      ? const SizedBox.shrink()
                      : const SizedBox(height: 6.0),
                ],
              ),
            ),
            HomeController.to.feeds[index].photoUrl != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CachedNetworkImage(
                      imageUrl: HomeController.to.feeds[index].photoUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      placeholderFadeInDuration: Duration(milliseconds: 400),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
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
                          HomeController.to.feeds[index].likes.toString(),
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Text(
                        '${HomeController.to.feeds[index].comments} Comments',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        '${HomeController.to.feedIndex.toString()} Shares',
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
                          if (HomeController.to.user != null) {
                            HomeController.to.index = index;
                            await HomeController.to.getLikes();
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
                          if (HomeController.to.user != null) {
                            HomeController.to.index = index;
                            Get.bottomSheet(
                              CommentBuild(),
                              isScrollControlled: true,
                              useRootNavigator: true,
                              ignoreSafeArea: false,
                            );
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
              ),
            ),
          ],
        ),
      ),
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

class FeedDesktop extends StatelessWidget {
  final scrollController;

  const FeedDesktop({Key key, @required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CommentBuild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CommentController>(
        init: CommentController(repository: Get.find()),
        builder: (_) {
          if (_.isCommentLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Column(
              children: [
                Container(
                  // height: 60,
                  width: context.width,
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios_rounded),
                        onPressed: () => Get.back(),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(MdiIcons.thumbUpOutline),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                        controller: _.commentScrollController,
                        itemBuilder: (context, index) {
                          if (_.comments[1].id ==
                              HomeController.to.user.userData.uid) {
                            return CommentMessageWidget(
                              name: _.comments[index].name,
                              comment: _.comments[index].comment,
                              imgUrl: _.comments[index].photoUrl,
                              leading: false,
                              time: timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      _.comments[index].time.seconds * 1000),
                                  locale: 'en_short'),
                            );
                          } else {
                            return CommentMessageWidget(
                              time: timeago.format(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      _.comments[index].time.seconds * 1000),
                                  locale: 'en_short'),
                              name: _.comments[index].name,
                              comment: _.comments[index].comment,
                              imgUrl: _.comments[index].photoUrl,
                              leading: true,
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: _.comments.length),
                  ),
                ),
                Container(
                  color: Colors.white,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      maxLines: 20,
                      // controller: _text,
                      decoration: InputDecoration(
                        // contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {},
                        ),
                        border: InputBorder.none,
                        hintText: "enter your message",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class CommentMessageWidget extends StatelessWidget {
  final String imgUrl;
  final String time;
  final bool leading;
  final String comment;
  final String name;
  const CommentMessageWidget({
    Key key,
    @required this.imgUrl,
    @required this.time,
    @required this.leading,
    @required this.comment,
    @required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: !leading ? ProfileAvatar(imageUrl: imgUrl) : null,
      leading: leading
          ? ProfileAvatar(
              imageUrl: imgUrl,
            )
          : null,
      subtitle: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [Text(name ?? ''), Spacer(), Text(time)],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(15)),
        ),
      ),
      title: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(comment ?? ''),
        ),
      ),
    );
  }
}
