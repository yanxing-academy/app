import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import 'routes.dart';
import 'views/author.dart';
import 'views/home.dart';
import 'views/library.dart';
import 'views/login.dart';
import 'views/mat.dart';
import 'views/profile.dart';
import 'views/root.dart';
import 'views/settings.dart';
import 'views/study.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "衍星书院",
      theme: ThemeData.light(), //YanxingThemeData.lightThemeData,
      darkTheme: ThemeData.dark(), //YanxingThemeData.darkThemeData,
      themeMode: ThemeMode.dark,
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
                name: Paths.LOGIN,
                page: () => LoginView(),
                bindings: [LoginBinding()]),
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
                    page: () => const ProfileView(),
                    bindings: [ProfileBinding()],
                  ),
                  GetPage(
                    name: Paths.VIEW_MAT,
                    page: () => const MatDetailView(),
                    bindings: [MatBinding()],
                  ),
                  GetPage(
                    name: Paths.VIEW_AUTHOR + '/:aid',
                    page: () => const AuthorDetailView(),
                    bindings: [AuthorBinding()],
                  ),
                  GetPage(
                    name: Paths.SETTINGS,
                    page: () => const SettingsView(),
                    bindings: [SettingsBinding()],
                  ),
                ]),
          ],
        ),
      ],
    ),
  );
}

class MainService extends GetxService {
  static MainService get to => MainService();
  final secureStorage = const FlutterSecureStorage();

  get jwtToken async {
    final jwt = await secureStorage.read(key: 'jwt');
    if (jwt != null) {
      final map = json.decode(jwt);
      return map['token'];
    } else {
      return '';
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
