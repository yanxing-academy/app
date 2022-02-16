import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/models/mat.dart';
import 'package:yanxing_app/themes/theme_data.dart';
import 'package:yanxing_app/views/library.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const YanxingApp());
}

class MainController extends GetxController {
  static MainController get to => Get.find();

  int menuIdx = 0;
  List<Mat> mats = [];

  /*
  @override
  void onInit() {
    // log("<> Start fetching books....");
    fetchBooks();
    super.onInit();
  }
  */

  void fetchBooks() async {
    log("fetching books...");
    var url = "http://localhost:8080/api/v1/mats/search?limit=9&offset=0&o=t&k=6";
    if (GetPlatform.isAndroid) {
      url = "http://10.0.2.2:8080/api/v1/mats/search?limit=9&offset=0&o=t&k=6";
    }
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


  void changeMenuIdx(int idx) {
    menuIdx = idx;
    update();
  }
}

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
              Expanded(
                child: Center(
                  child: mainViewByMenuIdx(MainController.to.menuIdx),
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

  Widget mainViewByMenuIdx(int menuIdx) {
    if (menuIdx == 1) {
      return const Library();
    } else {
      return const Library();
    }
  }
}
