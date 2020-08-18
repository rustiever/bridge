import 'dart:io';
import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/Users.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/Service.dart';

final userProvider = FutureProvider.autoDispose<User>((ref) async {
  try {
    var u = await ApiService.instance.getUserDetails();
    print('futre provider $u');
    return u;
  } catch (e) {
    print('object $e');
    return null;
  }
});

final anonPostProvider = FutureProvider.autoDispose<FeedModel>((ref) {
  return ApiService.instance.getAnonFeeds();
});

final platform = Provider.autoDispose((ref) {
  return Platform.operatingSystem;
});
// final anonPost = Provider.autoDispose((ref) {
//   return
// });
