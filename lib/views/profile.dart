import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class ProfileController extends GetxController {}

class ProfileBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<ProfileController>(
        () => ProfileController(),
      )
    ];
  }
}

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '"我的主页"模块正在开发中...',
              style: TextStyle(fontSize: 20),
            ),
            const Hero(
              tag: 'heroLogo',
              child: FlutterLogo(),
            ),
            MaterialButton(
              child: const Text('Show a test dialog'),
              onPressed: () {
                //shows a dialog
                Get.defaultDialog(
                  title: 'Test Dialog !!',
                  barrierDismissible: true,
                );
              },
            ),
            MaterialButton(
              child: const Text('Show a test dialog in Home router outlet'),
              onPressed: () {
                //shows a dialog

                Get.defaultDialog(
                  title: 'Test Dialog In Home Outlet !!',
                  barrierDismissible: true,
                  id: Routes.HOME,
                  // navigatorKey: Get.nestedKey(Routes.HOME),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
