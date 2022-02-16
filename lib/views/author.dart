import 'package:flutter/material.dart';
class AuthorView extends StatelessWidget {
  const AuthorView({Key? key, required this.aid}) : super(key: key);

  final String aid;

  @override
  Widget build(BuildContext context) {
    return Text("Author: $aid");
  }
}
