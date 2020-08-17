import 'dart:io';
import 'package:Bridge/models/Feeds.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../services/Service.dart';

// final userProvider = FutureProvider.autoDispose<User>((ref) {
//   try {
//     return ApiService.instance.getUserDetails();
//   } catch (e) {
//     print('object');
//   }
// });

// final userData = Provider.autoDispose(
//   (ref) {
//     return ref.read(userProvider).data.value;
//   },
// );

final anonPostProvider = FutureProvider.autoDispose<FeedModel>((ref) {
  return ApiService.instance.getAnonFeeds();
});

final platform = Provider.autoDispose((ref) {
  return Platform.operatingSystem;
});
// final anonPost = Provider.autoDispose((ref) {
//   return
// });
