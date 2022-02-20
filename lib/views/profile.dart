import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/routes.dart';

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
  const ProfileView({Key? key}) : super(key: key);

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
            ),
            TextButton(
              onPressed: () {
                context.navigation.toNamed(Paths.LOGIN);
              },
              child: const Text("登录"),
            )
          ],
        ),
      ),
    );
  }
}
