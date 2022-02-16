import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/main.dart';
import 'package:yanxing_app/models/mat.dart';

import '../models/constants.dart';
import 'list_card.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(NAV_CONTENT),
      initialRoute: '/mat/list',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/mat/list':
            {
              MainController.to.fetchBooks();
              return GetPageRoute(
                page: () => Center(
                  child: GetBuilder<MainController>(
                    builder: (_) => Column(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Row(children: [
                          const Icon(Icons.book),
                          Expanded(
                            child: Text(
                              "文库",
                              style: Get.textTheme.headline4,
                            ),
                          ),
                          const Icon(Icons.search),
                          const SizedBox(width: 10,),
                          const Icon(Icons.sort),
                        ]),
                      ),
                      Expanded(
                        child: GridView.extent(
                          primary: false,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          maxCrossAxisExtent: 500,
                          childAspectRatio: 1 / 0.8,
                          children: [
                            for (var m in MainController.to.mats)
                              ListCard(mat: m)
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            }
          case '/mat/view':
            return GetPageRoute(
              page: () => MatView(mat: settings.arguments as Mat),
            );
        }
      },
    );
  }
}
