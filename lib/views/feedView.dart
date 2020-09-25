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
    HomeController.to.feedIndex = index;
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
                      // ProfileAvatar(imageUrl: post.ownerPhotoUrl),
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
                    // child: Image.network(post.photoUrl),
                  )
                : const SizedBox.shrink(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              // child: _PostStats(
              //   index: index,
              // ),
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
                            // controller.getComments();
                            // Get.bottomSheet(
                            //     Container(
                            //       // height: 1200,
                            //       color: Colors.lightBlueAccent,
                            //     ),
                            //     isScrollControlled: true);
                            Get.bottomSheet(CommentBuild(),
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
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ReceivedMessageWidget(
                                content: _.comments[index].comment,
                                time: '11:23',
                              ),
                              SendedMessageWidget(
                                content: _.comments[index].comment,
                                time: '11:23',
                              ),
                            ],
                          );
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

class SendedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const SendedMessageWidget({
    Key key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
            right: 8.0, left: 50.0, top: 4.0, bottom: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15)),
          child: Container(
            color: Colors.blue[500],
            // margin: const EdgeInsets.only(left: 10.0),
            child: Stack(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: 12.0, left: 23.0, top: 8.0, bottom: 15.0),
                child: Text(
                  content,
                ),
              ),
              Positioned(
                bottom: 1,
                left: 10,
                child: Text(
                  time,
                  style: TextStyle(
                      fontSize: 10, color: Colors.black.withOpacity(0.6)),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class ReceivedMessageWidget extends StatelessWidget {
  final String content;
  final String time;
  const ReceivedMessageWidget({
    Key key,
    this.content,
    this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding:
          const EdgeInsets.only(right: 75.0, left: 8.0, top: 8.0, bottom: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15)),
        child: Container(
          color: Colors.orange[700],
          child: Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 8.0, left: 8.0, top: 8.0, bottom: 15.0),
              child: Text(
                content,
              ),
            ),
            Positioned(
              bottom: 1,
              right: 10,
              child: Text(
                time,
                style: TextStyle(
                    fontSize: 10, color: Colors.black.withOpacity(0.6)),
              ),
            )
          ]),
        ),
      ),
    ));
  }
}

class CommentBuilds extends StatelessWidget {
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
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView.builder(
                itemCount: _.comments.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      ProfileAvatar(
                        imageUrl: _.comments[index].photoUrl,
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
                                maxWidth:
                                    MediaQuery.of(context).size.width * .6),
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              color: Color(0xfff9f9f9),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(25),
                                bottomLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25),
                              ),
                            ),
                            child: Text(
                              "${_.comments[index].id}",
                              style:
                                  Theme.of(context).textTheme.bodyText1.apply(
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
                            onPressed: () {},
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
        );
      },
    );
  }
}
