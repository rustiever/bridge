import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final RelativePositionedTransition repository;
  UserController({@required this.repository}) : assert(repository != null);
}
