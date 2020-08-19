import 'package:Bridge/constants/constants.dart';
import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/models.dart';
import 'package:Bridge/services/Service.dart';
import 'package:Bridge/stateProviders/Providers.dart';
import 'package:Bridge/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Home extends HookWidget {
  final TrackingScrollController trackingScrollController;

  const Home({Key key, @required this.trackingScrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider);
    return user.when(
      data: (user) => Scaffold(
        body: Responsive(
          mobile: _HomeScreenMobile(scrollController: trackingScrollController),
          desktop:
              _HomeScreenDesktop(scrollController: trackingScrollController),
        ),
      ),
      loading: () => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (e, s) => Scaffold(
        body: Center(
          child: Text("$e  $s"),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenDesktop extends HookWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenDesktop({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider).data.value;
    final refresh = useState(true);
    var anonFuture =
        useMemoized(() => ApiServices.instance.getAnonFeeds(), [refresh.value]);
    AsyncSnapshot<FeedModel> snapshot = useFuture(anonFuture);
    print(snapshot.connectionState);
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        return Row(
          children: [
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: MoreOptionsList(currentUser: currentUser),
                ),
              ),
            ),
            const Spacer(),
            Container(
              width: 600.0,
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: CreatePostContainer(currentUser: user),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final FeedData post = snapshot?.data?.feedData[index] ??
                            FeedData.fromJson({});
                        return PostContainer(
                          post: post,
                        );
                      },
                      childCount: snapshot?.data?.feedData?.length ?? 0,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 2,
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ContactsList(users: onlineUsers),
                ),
              ),
            ),
          ],
        );
      case ConnectionState.active:
      case ConnectionState.none:
      case ConnectionState.waiting:
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

class _HomeScreenMobile extends HookWidget {
  final TrackingScrollController scrollController;

  const _HomeScreenMobile({
    Key key,
    @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = useProvider(userProvider).data.value;
    final refresh = useState(true);
    var anonFuture =
        useMemoized(() => ApiServices.instance.getAnonFeeds(), [refresh.value]);
    AsyncSnapshot<FeedModel> snapshot = useFuture(anonFuture);
    print(user == null);
    print(user);
    switch (snapshot.connectionState) {
      case ConnectionState.done:
        print(snapshot?.data?.feedData[0]?.caption ?? 'none');
        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              brightness: Brightness.light,
              backgroundColor: Colors.white,
              title: Text(
                'Bridge',
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
              child: CreatePostContainer(currentUser: user),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final FeedData post = snapshot.data.feedData[index];
                  return PostContainer(
                    post: post,
                  );
                },
                childCount: snapshot.data.feedData.length,
              ),
            ),
          ],
        );
      case ConnectionState.active:
      case ConnectionState.waiting:
      case ConnectionState.none:
      default:
        return Center(
          child: CircularProgressIndicator(),
        );
    }
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Home(
        trackingScrollController: _trackingScrollController,
      ),
    );
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    super.dispose();
  }
}
