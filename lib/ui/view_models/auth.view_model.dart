import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:queue/data/repos/auth.repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {

  final AuthRepo repo;

  AuthViewModel({required this.repo});

  Future<Map<String, dynamic>> signIn(String username, String password) async {
    final String token = await repo.signIn(username, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    final claims = JwtDecoder.decode(token);
    await prefs.setString('username', claims['username']);
    await prefs.setString('role', claims['role']);
    return claims;
  }

}