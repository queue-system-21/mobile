import 'dart:convert';

import 'package:queue/data/utils/http.dart' as http;

class AuthRepo {

  Future<String> signIn(String username, String password) async {
    final body = {
      "username": username,
      "password": password
    };
    final res = await http.post('/auth/sign-in', body: jsonEncode(body));
    if (res.statusCode > 300) {
      throw Exception('Sign in failed (${res.statusCode}): ${res.body}');
    }
    final token = jsonDecode(res.body)['token'];
    http.token = token;
    return token;
  }

}