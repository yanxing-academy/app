import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ThemeOptions {
  light,
  dark,
}

class SettingsController extends GetxController {
  var themeOption = ThemeOptions.light.obs;
  var themeMode = ThemeMode.light.obs;

  void setThemeMode(ThemeMode mode) {
    themeMode(mode);
    Get.changeThemeMode(mode);
  }

  void setThemeOption(ThemeOptions option) {
    themeOption(option);

    if (option == ThemeOptions.light) {
      Get.changeTheme(ThemeData.light());
    } else {
      Get.changeTheme(ThemeData.dark());
    }
  }
}

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
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('应用设置'),
        ),
        body: Center(
          child: SizedBox(
            width: 500,
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.palette,
                          color: Get.theme.colorScheme.secondary,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          '切换主题',
                          style: Get.textTheme.headline5!
                              .copyWith(color: Get.theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: controller.themeMode.value,
                    title: const Text('浅色主题'),
                    onChanged: (ThemeMode? mode) {
                      controller.setThemeMode(mode!);
                    },
                  ),
                  const Divider(),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: controller.themeMode.value,
                    title: const Text('深色主题'),
                    onChanged: (ThemeMode? mode) {
                      controller.setThemeMode(mode!);
                    },
                  ),
                  const Divider(),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: controller.themeMode.value,
                    title: const Text('系统主题'),
                    onChanged: (ThemeMode? mode) {
                      controller.setThemeMode(mode!);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
