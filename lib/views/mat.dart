import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yanxing_app/main.dart';
import 'package:yanxing_app/models/mat.dart';
import 'package:yanxing_app/themes/theme_data.dart';

import '../models/note.dart';
import '../routes.dart';

class MatController extends GetxController {
  MatController(Mat m) {
    mat(m);
  }

  static MatController get to => Get.find<MatController>();
  var mat = Mat("", "", "", "", "", "").obs;
  var notes = [].obs;

  var linenumSelected = 0.obs;

  void selectLine(int index) {
    linenumSelected(index);

    fetchNotesForline(index);
  }

  Future<void> fetchNotesForline(int linenum) async {
    final host = PlatformController.to.host;
    final mid = mat.value.id;
    // TODO: implement scope
    var url = "http://$host/api/v1/notes/list/card?mid=$mid&scope=4";
    log("fetching notes for mat: ${mat.value.title}, from url: $url");
    final resp = await http.get(
      Uri.parse(url),
      headers: {"Access-Control-Allow-Origin": "*"},
    );

    if (resp.statusCode == 200) {
      final js = jsonDecode(resp.body);
      for (var n in js) {
        var mat = Note.fromJSON(n);
        notes.add(mat);
      }
    } else {
      throw Exception('Failed to load books');
    }
  }
}

class MatBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<MatController>(
        () => MatController(Get.arguments as Mat),
      )
    ];
  }
}

// 素材的预览卡片，用来展示素材列表项
class MatCard extends StatelessWidget {
  final Mat mat;
  const MatCard(this.mat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // color: const Color(0xFFFBFBFB),
      color: YanxingThemeData.yanxingBlue1,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: YanxingThemeData.yanxingBlue3),
        borderRadius: BorderRadius.circular(10),
      ),
      // shadowColor: const Color(0xFFE6E6E6),
      shadowColor: YanxingThemeData.yanxingBlue4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(mat.title,
                      style: Theme.of(context).textTheme.headline4),
                  onPressed: () {
                    log("going to mat view for mat ${mat.title}");
                    context.navigation.toNamed(Routes.VIEW_MAT, arguments: mat);
                  },
                ),
                TextButton(
                  child: Text(mat.author,
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  onPressed: () {
                    context.navigation
                        .toNamed(Routes.VIEW_AUTHOR_DETAIL(mat.aid));
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 20),
              child: Text(
                mat.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 素材详情页面
class MatDetailView extends GetView<MatController> {
  const MatDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isWideScreen = PlatformController.isWideScreen(context);
    return Row(
      children: [
        Expanded(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.navigation.back();
                },
              ),
              title: Obx(() => Text("${controller.mat.value.title} - 详情",
                  style: Get.textTheme.headline5)),
              actions: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
              ],
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    // 素材标题
                    Obx(() => SelectableText(controller.mat.value.title,
                        style:
                            Get.textTheme.headline3?.copyWith(fontSize: 40))),
                    isWideScreen
                        ? const SizedBox(height: 30)
                        : ElevatedButton(
                            onPressed: () => showNotesSheet(context),
                            child: const Text("查看笔记")),
                    // 素材内容
                    Obx(() => buildMatContentView()),
                  ],
                ),
              ),
            ),
          ),
        ),
        isWideScreen
            ? Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(color: Colors.black, width: 0.2)),
                  ),
                  child: const NotesView(),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget buildMatContentView() {
    var lines = controller.mat.value.content.split('\n');
    var style = Get.textTheme.headline4
        ?.copyWith(height: 2, fontSize: 24, fontWeight: FontWeight.w500);
    var selectedStyle = style?.copyWith(
      color: Colors.blue,
      fontWeight: FontWeight.w800,
      // decoration: TextDecoration.underline,
    );
    return SelectableText.rich(
      TextSpan(
        children: lines.mapIndexed((index, ln) {
          final linenum = index + 1;
          return TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                selectSentence(linenum, ln);
              },
            text: index < lines.length - 1 ? '$ln\n' : ln,
            style: controller.linenumSelected.value == linenum
                ? selectedStyle
                : style,
          );
        }).toList(),
      ),
      onTap: () {
        log("single tap....");
      },
      onSelectionChanged: (TextSelection selection, cause) {
        log("select pos: $selection");
        if (selection.isCollapsed) return;
        final text = selection.textInside(controller.mat.value.content);
        log("selection: $text");
      },
    );
  }

  void showNotesSheet(BuildContext context) {
    showModalBottomSheet(
        context: context, builder: (context) => const NotesView());
  }

  void selectSentence(int index, String line) {
    log("selecting line: $index:$line");
    controller.selectLine(index);
  }
}

class NotesView extends StatelessWidget {
  const NotesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("笔记", style: Get.textTheme.headline5),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() => Column(
                  children: [
                    for (Note n in MatController.to.notes) Text(n.content),
                  ],
                ))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: '添加笔记',
        backgroundColor: YanxingThemeData.yanxingBlue10,
        child: const Icon(
          Icons.add,
          color: YanxingThemeData.yanxingBlue1,
        ),
        onPressed: () {},
      ),
    );
  }
}
