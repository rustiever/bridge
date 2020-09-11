import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/constants/enums.dart';
import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FeedView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Responsive(
            mobile: FeedMobile(
                scrollController: controller.trackingScrollController),
            desktop: FeedDesktop(
              scrollController: controller.trackingScrollController,
            )));
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
        if (controller.status == Status.Loading) {
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
              child: CreatePostContainer(currentUser: controller.user),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  // final FeedDatum post = controller.feedList[index];
                  // print(controller.feedList.length);
                  return PostContainer(
                    index: index,
                  );
                },
                childCount: controller.feeds.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                child: controller.status == Status.Loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : !controller.isMoreAvailable
                        ? Center(
                            child: Text('End'),
                          )
                        : null,
              ),
            ),
          ],
        );
      },
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
