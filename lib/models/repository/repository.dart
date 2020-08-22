import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/Service.dart';
import 'package:meta/meta.dart';

class Repository {
  final ApiService service;
  Repository({@required this.service}) : assert(service != null);

  Future<bool> login() async => await service.login();

  Future<bool> logout() async {
    return await service.serverLogout();
  }

  User getUser() => service.getUserDetails();

  Future<FeedModel> anonFeeds() async {
    print('in anon repo ');
    var t = await service.getFeeds();
    print(t?.feedData[0]?.caption ?? 'hello');
    return t;
  }
}
