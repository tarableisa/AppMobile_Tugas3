import 'package:flutter/material.dart';
import 'login_screen.dart'; // import screen login
import '../utils/session_manager.dart'; // misalnya file session helper

class BantuanScreen extends StatelessWidget {
  final SessionManager _session = SessionManager(); // instance session

  void _logout(BuildContext context) async {
    await _session.logout(); // hapus data login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()), // ke login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.help_outline,
              size: 60,
              color: Colors.blue,
            ),
            SizedBox(height: 15),
            Text(
              '📌 Cara Penggunaan Aplikasi:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 15),
            Text(
              '''
1. Login menggunakan username dan password.
2. Pilih menu di halaman utama:
   • Stopwatch
   • Jenis Bilangan
   • Tracking Lokasi
   • Konversi Waktu
   • Rekomendasi Situs
3. Gunakan navigasi bawah untuk berpindah halaman.
4. Logout dapat dilakukan dari halaman Bantuan.
              ''',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                onPressed: () => _logout(context),
                icon: Icon(Icons.logout),
                label: Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
