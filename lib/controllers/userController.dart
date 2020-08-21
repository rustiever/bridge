import 'package:Bridge/models/Users.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final Repository repository = Repository.instance;

  final user = User().obs;

  @override
  void onInit() => getuser();

  getuser() {
    user.value = repository.getUser();
  }
}
