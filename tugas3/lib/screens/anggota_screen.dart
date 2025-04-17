import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnggotaScreen extends StatelessWidget {
  final List<Map<String, String>> anggota = [
    {
      'name': 'Shah Delphi Muhammad',
      'nim': '123220027',
      'image': 'assets/images/shah.jpg',
    },
    {
      'name': 'Kartika Rahmi Anjani',
      'nim': '123220143',
      'image': 'assets/images/kartika.jpg',
    },
    {
      'name': 'Tara Bleisa Ayomi',
      'nim': '123220173',
      'image': 'assets/images/tara.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: anggota.length,
      itemBuilder: (context, index) {
        final person = anggota[index];
        return Card(
          elevation: 5,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              // Foto anggota dalam bentuk persegi
              Container(
                width: double.infinity, // Lebar mengikuti ukuran layar
                height: 200, // Tinggi tetap 200
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(person['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Nama dan NIM
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      person['name']!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      person['nim']!,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
