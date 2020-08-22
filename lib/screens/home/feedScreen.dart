import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/controllers/userController.dart';
import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../navScreen.dart';

class Homee extends GetWidget<NavController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: HomeScreenMobile(
            scrollController: controller.trackingScrollController),
        desktop: HomeScreenDesktop(
            scrollController: controller.trackingScrollController),
      ),
    );
  }
}

class HomeScreenDesktop extends GetView<UserController> {
  final TrackingScrollController scrollController;

  const HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: MoreOptionsList(currentUser: controller.user.value),
            ),
          ),
        ),
        const Spacer(),
        Container(
          width: 600.0,
          child: GetX<FeedController>(
            init: Get.find(),
            builder: (aController) {
              if (aController.feeds() != null) {
                print('inside');
                return CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: CreatePostContainer(
                          currentUser: controller.user.value),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final FeedData post =
                              aController.feeds.value.feedData[index] ??
                                  FeedData.fromJson({});
                          return PostContainer(
                            post: post,
                          );
                        },
                        childCount:
                            aController?.feeds?.value?.feedData?.length ?? 0,
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          // child:
        ),
        const Spacer(),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              // child: ContactsList(users: onlineUsers),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeScreenMobile extends GetView<UserController> {
  final TrackingScrollController scrollController;

  const HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<FeedController>(
      builder: (_) {
        if (_.feeds() == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CustomScrollView(
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
                  onPressed: () => print('Search'),
                ),
                CircleButton(
                  icon: MdiIcons.filter,
                  iconSize: 30.0,
                  onPressed: () => print('filter'),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: CreatePostContainer(currentUser: controller.user.value),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final FeedData post = _.feeds.value.feedData[index];
                  return PostContainer(
                    post: post,
                  );
                },
                childCount: _.feeds.value.feedData.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
