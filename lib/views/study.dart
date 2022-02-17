import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudyController extends GetxController {
  final now = DateTime.now().obs;
  @override
  void onReady() {
    super.onReady();
    Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        now.value = DateTime.now();
      },
    );
  }
}

class StudyBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<StudyController>(
        () => StudyController(),
      )
    ];
  }
}

class StudyView extends GetView<StudyController> {
  const StudyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '学习模块正在开发中....',
                style: TextStyle(fontSize: 20),
              ),
              Text('Time: ${controller.now.value.toString()}'),
            ],
          ),
        ),
      ),
    );
  }
}
