import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yanxing_app/models/mat.dart';
import 'package:yanxing_app/routes.dart';
import 'package:yanxing_app/views/author.dart';
import 'package:yanxing_app/views/library.dart';

import 'themes/theme_data.dart';
import 'views/home.dart';
import 'views/mat.dart';
import 'views/profile.dart';
import 'views/root.dart';
import 'views/study.dart';

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
                    bindings: [StudyBinding()],
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
                  ),
                  GetPage(
                    name: Paths.VIEW_AUTHOR + '/:aid',
                    page: () => AuthorDetailView(),
                    bindings: [AuthorBinding()],
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
}

class PlatformController extends GetxController {
  static PlatformController get to => PlatformController();

  static bool isNarrowScreen(BuildContext context) {
    return context.width / context.height < 0.8;
  }

  static bool isWideScreen(BuildContext context) {
    return context.width / context.height > 1.3;
  }

  String _host = "localhost:8080";

  get host => _host;

  @override
  void onInit() {
    if (GetPlatform.isAndroid) {
      _host = "10.0.2.2:8080";
    }
    super.onInit();
  }
}
