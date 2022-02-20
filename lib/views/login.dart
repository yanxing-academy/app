import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:yanxing_app/main.dart';
import 'package:yanxing_app/routes.dart';

class LoginController extends GetxController {
  Future<bool> tryLogin(String username, String password) async {
    final host = PlatformController.to.host;
    final url = 'http://$host/api/v1/token/login';
    log("fetching login from $url");
    final resp = await http.post(
      Uri.parse(url),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (resp.statusCode == 200) {
      final map = json.decode(resp.body);
      final expire = map['expire'];
      final token = map['token'];
      final jwt = json.encode({
        'expire': expire,
        'token': token,
        'username': username,
      });

      // 将jwt写入存储以便之后判定登录状态
      final storage = MainService.to.secureStorage;
      storage.write(key: "jwt", value: jwt);

      return true;
    } else {
      log('Error trying to login for user: $username');
      return false;
    }
  }
}

class LoginBinding extends Binding {
  @override
  List<Bind> dependencies() {
    return [Bind.lazyPut<LoginController>(() => LoginController())];
  }
}

class LoginView extends GetView<LoginController> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({Key? key}) : super(key: key);

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
        title: const Text('登录'),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: '用户名'),
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: '密码'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () => doLogin(context),
                      child: const Text('登录')),
                  TextButton(
                    onPressed: () {
                      context.navigation.back();
                    },
                    child: const Text(
                      '取消',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const Spacer(),
                  TextButton(onPressed: () {}, child: const Text('注册')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void doLogin(BuildContext context) async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    var succ = await controller.tryLogin(username, password);
    if (succ) {
      context.navigation.toNamed(Paths.HOME);
    } else {
      log("login failed for user: $username");
    }
  }
}
