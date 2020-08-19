import 'package:Bridge/services/Service.dart';
import 'package:meta/meta.dart';

class Repository {
  final ApiService service;
  Repository({@required this.service}) : assert(service != null);

  login() => service.login();

  logout() => service.serverLogout();
}
