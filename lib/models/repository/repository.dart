import 'package:Bridge/models/models.dart';
import 'package:Bridge/services/Service.dart';
import 'package:meta/meta.dart';

class Repository {
  final ApiService service;
  Repository({@required this.service}) : assert(service != null);

  Future<bool> login(UserType userType) async => await service.login(userType);

  Future<bool> logout() async {
    return await service.serverLogout();
  }

  User getUser() => service.getUserDetails();

  getLike(String postId) async => await service.getLike(postId);

  Future<FeedModel> getFeeds(dynamic time) async {
    print('in anon repo ');
    FeedModel t = await service.getFeeds(time);
    // FeedModel t = FeedModel.fromRawJson('{"lastTime":null,"feedData":[{"postId":"MDVmVt1YPOzrvxrRfg8v","caption":"THIS IS A POST WITH NUMBER-20","likes":0,"photoUrl":"https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80","ownerName":"Sharan","ownerPhotoUrl":"https://firebasestorage.googleapis.com/v0/b/bridge-fd58f.appspot.com/o/DummyPost%2FWIN_20191024_15_45_00_Pro.jpg?alt=media&token=9d061db8-c7db-4dbd-85ea-48faaddb93d4","ownerUid":"H3KOr0tq8Wcg5cK8HIY6AeRRZj73","timeStamp":{"seconds":1598800417,"nanoseconds":438000000},"scope":false,"comments":0},{"postId":"vrZq7qU8LyecdjKeDy0F","caption":"THIS IS A POST WITH NUMBER-11","likes":0,"photoUrl":"https://images.unsplash.com/photo-1573331519317-30b24326bb9a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80","ownerName":"Sharan","ownerPhotoUrl":"https://firebasestorage.googleapis.com/v0/b/bridge-fd58f.appspot.com/o/DummyPost%2FWIN_20191024_15_45_00_Pro.jpg?alt=media&token=9d061db8-c7db-4dbd-85ea-48faaddb93d4","ownerUid":"H3KOr0tq8Wcg5cK8HIY6AeRRZj73","timeStamp":{"seconds":1598800188,"nanoseconds":941000000},"scope":false,"comments":0}]}');
    print(t?.feedData[0]?.caption ?? 'hello');
    return t;
  }
}
