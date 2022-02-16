import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes.dart';

class RootController extends GetxController {
  //TODO: Implement RootController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}

class RootBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<RootController>(
            () => RootController(),
      )
    ];
  }
}

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return RouterOutlet.builder(
      delegate: Get.nestedKey(null),
      builder: (context) {
        final title = context.location;
        return Scaffold(
          appBar: GetPlatform.isDesktop ? null : AppBar(
            title: Text(title),
            centerTitle: true,
          ),
          //body: HomeView(),

          body: GetRouterOutlet(
            initialRoute: Routes.HOME,
            delegate: Get.nestedKey(null),
            anchorRoute: '/',
            filterPages: (afterAnchor) {
              return afterAnchor.take(1);
            },
          ),
        );
      },
    );
  }
}
