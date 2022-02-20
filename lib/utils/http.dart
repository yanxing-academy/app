import 'package:http/http.dart' as http;

import '../main.dart';

Future<http.Response> httpGet(String url) {
  return http.get(
    Uri.parse(url),
    headers: {"Access-Control-Allow-Origin": "*"},
  );
}

Future<http.Response> authGet(String url) async {
  final token = await MainService.to.jwtToken;
  return http.get(
    Uri.parse(url),
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token",
    },
  );
}
