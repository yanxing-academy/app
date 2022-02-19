import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/mat.dart';
import '../themes/theme_data.dart';
import 'mat.dart';

class LibraryController extends GetxController {
  String host = "localhost:8080";
  var mats = [].obs;
  var author = Author("", "", "").obs;

  @override
  void onInit() {
    if (GetPlatform.isAndroid) {
      host = "10.0.2.2:8080";
    }
    log("<> Start fetching books....");
    fetchBooks();
    super.onInit();
  }

  void fetchBooks() async {
    log("fetching books...");
    var url = "http://$host/api/v1/mats/search?limit=9&offset=0&o=t&k=6";
    final resp = await http.get(
      Uri.parse(url),
      headers: {"Access-Control-Allow-Origin": "*"},
    );

    if (resp.statusCode == 200) {
      final js = jsonDecode(resp.body);
      for (var m in js['mats']) {
        var mat = Mat.fromJSON(m);
        mats.add(mat);
      }
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
      author.update((a) {
        a = Author.fromJSON(js);
      });
    } else {
      throw Exception('Failed to load author');
    }
  }
}

class LibraryBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<LibraryController>(
        () => LibraryController(),
      )
    ];
  }
}

class LibraryView extends GetView<LibraryController> {
  const LibraryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xFFEEEEEE),
      // backgroundColor: const Color(0xFFECF5FF),
      backgroundColor: YanxingThemeData.yanxingBlue2,
      appBar: AppBar(
        // leading: const Icon(Icons.collections_bookmark),
        title: const Text('书馆'),
        actions: [
          const Icon(Icons.search),
          const SizedBox(width: 10),
          IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
          const SizedBox(width: 10),
        ],
      ),
      body: Obx(() => GridView.extent(
            primary: false,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: GetPlatform.isDesktop ? 400 : 300,
            childAspectRatio: 1 / 0.8,
            children: [for (var m in controller.mats) MatCard(m)],
          )),
    );
  }
}
