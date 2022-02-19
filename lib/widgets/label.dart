import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label(this.text, {Key? key, this.style, this.icon}) : super(key: key);

  final String text;
  final TextStyle? style;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon!,
          const SizedBox(width: 6),
          Text(text, style: style),
        ],
      ),
    );
  }
}
