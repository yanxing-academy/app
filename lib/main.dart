import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/models/mat.dart';
import 'package:yanxing_app/routes.dart';
import 'package:http/http.dart' as http;
import 'package:yanxing_app/views/library.dart';

import 'themes/theme_data.dart';
import 'views/study.dart';
import 'views/home.dart';
import 'views/mat.dart';
import 'views/profile.dart';
import 'views/root.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "衍星书院",
      theme: YanxingThemeData.lightThemeData,
      darkTheme: YanxingThemeData.darkThemeData,
      initialBinding: BindingsBuilder(() {}),
      initialRoute: Routes.HOME,
      getPages: [
        GetPage(
          name: '/',
          page: () => RootView(),
          bindings: [RootBinding()],
          participatesInRootNavigator: true,
          preventDuplicates: true,
          children: [
            GetPage(
                preventDuplicates: true,
                name: Paths.HOME,
                page: () => const HomeView(),
                bindings: [HomeBinding()],
                title: null,
                children: [
                  GetPage(
                    name: Paths.STUDY,
                    page: () => const StudyView(),
                    bindings: [ StudyBinding()],
                  ),
                  GetPage(
                    name: Paths.LIBRARY,
                    page: () => const LibraryView(),
                    bindings: [LibraryBinding()],
                  ),
                  GetPage(
                    name: Paths.PROFILE,
                    page: () => ProfileView(),
                    bindings: [ProfileBinding()],
                  ),
                  GetPage(
                    name: Paths.VIEW_MAT,
                    page: () => MatDetailView(Get.arguments as Mat),
                    bindings: [MatBinding()],
                  )
                ]),
          ],
        ),
      ],
    ),
  );
}

class MainController extends GetxController {
  static MainController get to => Get.find();
  String host = "localhost:8080";

  int menuIdx = 0;
  List<Mat> mats = [];
  late Author author;

  @override
  void onInit() {
    if (GetPlatform.isAndroid) {
      host = "10.0.2.2:8080";
    }
    // log("<> Start fetching books....");
    // fetchBooks();
    super.onInit();
  }

  void fetchBooks() async {
    log("fetching books...");
    var url = "http://$host/api/v1/mats/search?limit=9&offset=0&o=t&k=6";
    final resp = await http.get(Uri.parse(url));

    if (resp.statusCode == 200) {
      final js = jsonDecode(resp.body);
      for (var m in js['mats']) {
        var mat = Mat.fromJSON(m);
        mats.add(mat);
      }
      update();
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> fetchAuthor(String aid) async {
    log("fetching author info for $aid...");
    var url = "http://$host/api/v1/people/get/$aid";
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final js = jsonDecode(resp.body);
      author = Author.fromJSON(js);
      update();
    } else {
      throw Exception('Failed to load author');
    }
  }

  void changeMenuIdx(int idx) {
    menuIdx = idx;
    update();
  }
}

/*

class YanxingApp extends StatelessWidget {
  const YanxingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "衍星书院",
      theme: YanxingThemeData.lightThemeData,
      darkTheme: YanxingThemeData.darkThemeData,
      home: GetBuilder(
        init: MainController(),
        builder: (_) => Scaffold(
          body: Row(
            children: [
              LayoutBuilder(builder: (context, constraints) {
                return Container(
                  color: Theme.of(context).navigationRailTheme.backgroundColor,
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: IntrinsicHeight(
                        child: NavigationRail(
                          destinations: const [
                            NavigationRailDestination(
                                icon: Icon(Icons.home), label: Text('主页')),
                            NavigationRailDestination(
                                icon: Icon(Icons.star), label: Text('收藏')),
                            NavigationRailDestination(
                                icon: Icon(Icons.search), label: Text('搜索')),
                          ],
                          selectedIndex: MainController.to.menuIdx,
                          onDestinationSelected: (int idx) {
                            Get.find<MainController>().changeMenuIdx(idx);
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const VerticalDivider(
                thickness: 1,
                width: 1,
              ),
              const Expanded(
                child: Center(
                  child: Library(),
                  // child: ConstrainedBox(
                  //   constraints: const BoxConstraints(maxWidth: 1340),
                  // child: mainViewByMenuIdx(MainController.to.menuIdx),
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/
