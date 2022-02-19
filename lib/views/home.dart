import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/main.dart';
import 'package:yanxing_app/themes/theme_data.dart';

import '../routes.dart';

class HomeController extends GetxController {}

class HomeBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut<HomeController>(() => HomeController())];
  }
}

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetRouterOutlet.builder(
      routerDelegate: Get.nestedKey(Routes.HOME),
      builder: (context) {
        final delegate = context.navigation;
        final currentLocation = context.location;
        var currentIndex = 0;
        log("CurrentLocation: $currentLocation");
        if (currentLocation.startsWith(Routes.STUDY) == true) {
          currentIndex = 1;
        }
        if (currentLocation.startsWith(Routes.PROFILE) == true) {
          currentIndex = 2;
        }
        if (currentLocation.startsWith(Routes.SETTINGS) == true) {
          currentIndex = 3;
        }

        log("width: ${context.width} / height: ${context.height}");

        if (!PlatformController.isNarrowScreen(context)) {
          return Scaffold(
            body: Row(
              children: [
                LayoutBuilder(builder: (context, constraints) {
                  return Container(
                    color:
                        Theme.of(context).navigationRailTheme.backgroundColor,
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: constraints.maxHeight),
                        child: IntrinsicHeight(
                          child: NavigationRail(
                            // labelType: NavigationRailLabelType.selected,
                            selectedIconTheme: const IconThemeData().copyWith(
                                color: YanxingThemeData.yanxingBlue20,
                                size: 28),
                            unselectedIconTheme: const IconThemeData()
                                .copyWith(color: YanxingThemeData.yanxingBlue9),
                            destinations: const [
                              NavigationRailDestination(
                                  icon: Icon(Icons.collections_bookmark),
                                  label: Text('书馆')),
                              NavigationRailDestination(
                                  icon: Icon(Icons.school), label: Text('学习')),
                              NavigationRailDestination(
                                  icon: Icon(Icons.face), label: Text('我')),
                              NavigationRailDestination(
                                  icon: Icon(Icons.settings),
                                  label: Text('选项')),
                            ],
                            selectedIndex: currentIndex,
                            onDestinationSelected: (idx) =>
                                onIndexChanged(idx, context),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                // const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: Center(
                    child: GetRouterOutlet(
                      initialRoute: Routes.LIBRARY,
                      anchorRoute: Routes.HOME,
                    ),
                    // child: ConstrainedBox(
                    //   constraints: const BoxConstraints(maxWidth: 1340),
                    // child: mainViewByMenuIdx(MainController.to.menuIdx),
                    // ),
                  ),
                )
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: null,
            body: GetRouterOutlet(
              initialRoute: Routes.LIBRARY,
              anchorRoute: Routes.HOME,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              selectedItemColor: YanxingThemeData.yanxingBlue20,
              unselectedItemColor: YanxingThemeData.yanxingBlue9,
              onTap: (idx) => onIndexChanged(idx, context),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.collections_bookmark),
                  label: '书馆',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: '学习',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.face),
                  label: '我',
                ),
              ],
            ),
          );
        }
      },
    );
  }

  void onIndexChanged(int index, BuildContext context) {
    var delegate = context.navigation;
    switch (index) {
      case 0:
        delegate.toNamed(Routes.LIBRARY);
        break;
      case 1:
        delegate.toNamed(Routes.STUDY);
        break;
      case 2:
        delegate.toNamed(Routes.PROFILE);
        break;
      case 3:
        delegate.toNamed(Routes.SETTINGS);
        break;
      default:
        break;
    }
  }
}
