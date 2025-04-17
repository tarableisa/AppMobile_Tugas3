import 'package:flutter/material.dart';

class BantuanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Cara Penggunaan Aplikasi:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 15),
            Text(
              '''
1. Login menggunakan username dan password
2. Pilih menu di halaman utama:
   - Stopwatch
   - Jenis Bilangan
   - Tracking Lokasi
   - Konversi Waktu
   - Rekomendasi Situs
3. Gunakan navigasi bawah untuk berpindah halaman
4. Logout dapat dilakukan dari halaman Bantuan
              ''',
            ),
          ],
        ),
      ),
    );
  }
}
