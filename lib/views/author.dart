import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yanxing_app/main.dart';

import '../models/mat.dart';

class AuthorController extends GetxController {
  var author = Author('', '', '').obs;

  final String aid;

  AuthorController(this.aid);

  @override
  void onInit() {
    fetchAuthor(aid);
    super.onInit();
  }

  Future<void> fetchAuthor(String aid) async {
    log("fetching author info for $aid...");
    var host = PlatformController.to.host;
    var url = "http://$host/api/v1/people/get/$aid";
    final resp = await http.get(Uri.parse(url));
    if (resp.statusCode == 200) {
      final js = jsonDecode(resp.body);
      author(Author.fromJSON(js));
      log("got author: ${author.value.fullname}");
    } else {
      throw Exception('Failed to load author');
    }
  }
}

class AuthorBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<AuthorController>(
        () => AuthorController(Get.parameters['aid'] ?? ''),
      )
    ];
  }
}

class AuthorDetailView extends GetView<AuthorController> {
  const AuthorDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.navigation.back();
          },
        ),
        title: const Text('人物详情'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Column(
              children: [
                Text('Arthor id: ${controller.aid}'),
                Obx(() => Text(controller.author.value.fullname)),
              ],
            ),
          ),
          const SizedBox(width: 40),
          const Center(
            child: Text("notes"),
          ),
        ],
      ),
    );
  }
}
