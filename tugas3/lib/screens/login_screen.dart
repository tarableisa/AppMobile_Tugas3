import 'package:flutter/material.dart';
import '../utils/session_manager.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  final SessionManager _session = SessionManager();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  void _doLogin(BuildContext context) async {
    // Contoh login tanpa validasi (bisa disesuaikan)
    await _session.login();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _username,
              decoration: InputDecoration(labelText: "Username"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _doLogin(context),
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}
