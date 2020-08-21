import 'package:Bridge/models/Feeds.dart';
import 'package:Bridge/models/Users.dart';
import 'package:Bridge/services/Service.dart';

class Repository {
  Repository._instance();
  static final instance = Repository._instance();
  final ApiService service = ApiService.instance;

  Future<bool> login() async => await service.login();

  Future<bool> logout() async {
    return await service.serverLogout();
  }

  User getUser() => service.getUserDetails();

  Future<FeedModel> anonFeeds() async {
    print('in anon repo ');
    var t = await service.getAnonFeeds();
    print(t?.feedData[0]?.caption ?? 'hello');
    return t;
  }
}
