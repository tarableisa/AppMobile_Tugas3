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
    return Scaffold(
      backgroundColor: const Color.fromARGB(249, 250, 251, 252),
      body: Container(
         // Matching the yellow from the first image
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: anggota.length,
          itemBuilder: (context, index) {
            final person = anggota[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.all(12),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        person['image']!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          person['name']!,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          person['nim']!,
                          style: GoogleFonts.poppins(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(12),
                    
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}