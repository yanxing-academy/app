import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yanxing_app/models/constants.dart';

import '../models/mat.dart';

class ListCard extends StatelessWidget {
  const ListCard({Key? key, required this.mat}) : super(key: key);

  final Mat mat;

  @override
  Widget build(BuildContext context) {
    return MatCard(mat);
    /*
    return OpenContainer(
      closedBuilder: (context, openContainer) {
        return MatCard(mat);
      },
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      openBuilder: (context, closedContainer) {
        return MatView(mat: mat);
      },
    );
     */
  }
}

class MatView extends StatelessWidget {
  const MatView({
    Key? key,
    required this.mat,
  }) : super(key: key);

  final Mat mat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          child: Material(
            color: Theme.of(context).cardColor,
            child: SingleChildScrollView(
              padding: const EdgeInsetsDirectional.only(
                top: 42,
                start: 20,
                end: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mat.title),
                  ElevatedButton(
                    onPressed: () {
                      //Navigator.pop(context);
                      // Get.back();
                      Get.back(id: NAV_CONTENT);
                    },
                    child: const Text("back"),
                  ),
                  Text(mat.content),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MatCard extends StatelessWidget {
  final Mat mat;
  const MatCard(this.mat, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Text(mat.title, style: Theme.of(context).textTheme.headline4),
                  onPressed: () {
                    log("going to mat view for mat ${mat.title}");
                    Get.toNamed("/mat/view", arguments: mat, id: NAV_CONTENT);
                  },
                ),
                TextButton(
                  child: Text(mat.author,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      )),
                  onPressed: () {},
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
