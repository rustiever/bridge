import 'package:Bridge/models/models.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

class AuthController extends GetxController {
  final Repository repository;
  AuthController({@required this.repository}) : assert(repository != null);

  Future<bool> login(UserType userType) async =>
      await repository.login(userType);

  Future<bool> logout() async => await repository.logout();
}
