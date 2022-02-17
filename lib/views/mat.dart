import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/main.dart';
import 'package:yanxing_app/models/mat.dart';

import '../routes.dart';

class MatController extends GetxController {
  var mat = Mat("", "", "", "", "", "").obs;

  var lineSelectd = 0.obs;

  void selectLine(int index) {
    lineSelectd(index);
  }
}

class MatBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [
      Bind.lazyPut<MatController>(
        () => MatController(),
      )
    ];
  }
}

// 素材的预览卡片，用来展示素材列表项
class MatCard extends GetView<MatController> {
  final Mat mat;
  const MatCard(this.mat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFBFBFB),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: const Color(0xFFE6E6E6),
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
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      )),
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
  final Mat mat;

  const MatDetailView(this.mat, {Key? key}) : super(key: key);

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
              title: Text("${mat.title} - 详情", style: Get.textTheme.headline5),
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
                    SelectableText(mat.title,
                        style: Get.textTheme.headline3?.copyWith(fontSize: 40)),
                    isWideScreen
                        ? const SizedBox(height: 30)
                        : ElevatedButton(
                            onPressed: () => showNotesSheet(context),
                            child: const Text("查看笔记")),
                    // 素材内容
                    buildMatContentView(),
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
    var lines = mat.content.split('\n');
    var style = Get.textTheme.headline4
        ?.copyWith(height: 2, fontSize: 24, fontWeight: FontWeight.w500);
    var selectedStyle =
        style?.copyWith(color: Colors.blue, fontWeight: FontWeight.w800);
    return Obx(() {
      return SelectableText.rich(TextSpan(
        children: lines.mapIndexed((index, ln) {
          final linenum = index + 1;
          return TextSpan(
            text: '$ln\n',
            style:
                controller.lineSelectd.value == linenum ? selectedStyle : style,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                selectSentence(linenum, ln);
              },
            mouseCursor: SystemMouseCursors.click,
          );
        }).toList(),
      ));
    });
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
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Single tap',
                  style: TextStyle(color: Colors.red[300]),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      log("single tap");
                      // Single tapped.
                    },
                ),
                TextSpan(
                    text: ' Double tap',
                    style: TextStyle(color: Colors.green[300]),
                    recognizer: DoubleTapGestureRecognizer()
                      ..onDoubleTap = () {
                        log("double tap");
                        // Double tapped.
                      }),
                TextSpan(
                  text: ' Long press',
                  style: TextStyle(color: Colors.blue[300]),
                  recognizer: LongPressGestureRecognizer()
                    ..onLongPress = () {
                      log("long press");
                      // Long Pressed.
                    },
                ),
              ],
            ),
          ),
          const Text("notes"),
        ],
      )),
    );
  }
}
