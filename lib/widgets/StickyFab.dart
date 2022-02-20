import 'package:flutter/material.dart';
import 'package:yanxing_app/themes/theme_data.dart';

class StickyFab extends StatefulWidget {
  final Widget child;
  const StickyFab({Key? key, required this.child}) : super(key: key);

  @override
  _StickyFabState createState() => _StickyFabState();
}

class _StickyFabState extends State<StickyFab> {
  _StickyFabState();

  bool isSheetOpen = false;
  PersistentBottomSheetController? bottomSheetController;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: isSheetOpen
          ? YanxingThemeData.yanxingBlue1
          : YanxingThemeData.yanxingBlue10,
      onPressed: () {
        if (!isSheetOpen) {
          bottomSheetController = showBottomSheet(
            // TODO: move constraints into constructor
            constraints: const BoxConstraints(maxHeight: 600),
            context: context,
            builder: (context) => Card(child: widget.child),
          );
          setSheetOpen(true);

          bottomSheetController!.closed.then((value) {
            setSheetOpen(false);
          });
        } else {
          if (bottomSheetController != null) {
            bottomSheetController!.close();
          }
          setSheetOpen(false);
        }
      },
      child: Icon(isSheetOpen ? Icons.clear : Icons.add,
          color: isSheetOpen
              ? YanxingThemeData.yanxingBlue10
              : YanxingThemeData.yanxingBlue1),
    );
  }

  void setSheetOpen(bool value) {
    setState(() {
      isSheetOpen = value;
    });
  }
}
