import 'package:Bridge/controllers/controllers.dart';
import 'package:Bridge/models/repository/repository.dart';
import 'package:Bridge/services/Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

class My {
  int ss;
  String sd;

  My({this.ss, this.sd});
}

class MyController extends GetxController {
  final ll = [].obs;

  ups(s) {
    ll[0] = My(ss: s++, sd: 'mhh');
  }
}

class Home extends StatelessWidget {
  final controller = Get.put<HomeController>(HomeController(
      repository: Repository(service: ApiService(httpClient: Client()))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            // GetBuilder(
            //     init: HomeController(
            //         repository:
            //             Repository(service: ApiService(httpClient: Client()))),
            //     builder: (_) => Text(controller.feedList[0].likes.toString())),
            // GetX<HomeController>(
            //   // init: HomeController(
            //   //     repository:
            //   //         Repository(service: ApiService(httpClient: Client()))),
            //   builder: (_) => Column(
            //     children: [
            //       Center(
            //         child: RaisedButton(
            //           onPressed: _.user != null
            //               ? () async {
            //                   _.getLikes(0);
            //                 }
            //               : null,
            //           child: Text('logout'),
            //         ),
            //       ),
            //       Text(_.feedList[0].likes.toString()),
            //       Text(_.likes.value.toString()),
            //     ],
            //   ),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48.0),
                child: RaisedButton(
                  onPressed: controller.user != null
                      ? () async {
                          // Get.offAllNamed(Authroute);
                          // if (await controller.logout()) {
                          // Get.offAllNamed(Authroute);
                          // controller.feedList[0].likes++;
                          controller.getLikes(0);
                          // } else {
                          //   Get.snackbar('Sorry',
                          //       'Looks like no connection, Try with proper connection');
                          // }
                        }
                      : null,
                  child: Text('logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
