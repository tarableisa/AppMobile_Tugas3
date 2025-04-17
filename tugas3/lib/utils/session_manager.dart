import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final String _keyLogin = 'isLoggedIn';

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyLogin) ?? false;
  }

  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLogin, true);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyLogin, false);
  }
}
