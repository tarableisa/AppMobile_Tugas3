import 'package:flutter/material.dart';

class AnggotaScreen extends StatelessWidget {
  final List<String> anggota = [
    'Shah Delphi Muhammad - 123220027',
    'Kartika Rahmi Anjani - 123220143',
    'Tara Bleisa Ayomi    - 123220173',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: anggota.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.person),
          title: Text(anggota[index]),
        );
      },
    );
  }
}
