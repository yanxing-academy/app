import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {}

class SettingsBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<SettingsController>(
        () => SettingsController(),
      )
    ];
  }
}

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              '设置模块正在开发中....',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
