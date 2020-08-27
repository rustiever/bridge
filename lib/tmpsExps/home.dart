import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../router.dart';

class Home extends StatelessWidget {
  final controller = Get.put<HomeController>(HomeController(
      repository: Repository(service: ApiService(httpClient: Client()))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: controller.user != null
                ? () async {
                    // Get.offAllNamed(Authroute);
                    if (await controller.logout()) {
                      Get.offAllNamed(Authroute);
                    } else {
                      Get.snackbar('Sorry',
                          'Looks like no connection, Try with proper connection');
                    }
                  }
                : null,
            child: Text('logout'),
          ),
        ),
      ),
    );
  }
}
