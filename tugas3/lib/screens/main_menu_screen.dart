import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/stopwatch');
          },
          child: Text("Stopwatch"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/jenis-bilangan');
          },
          child: Text("Jenis Bilangan"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/tracking-lbs');
          },
          child: Text("Tracking LBS"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/time-conversion');
          },
          child: Text("Konversi Waktu"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/site-recommendation');
          },
          child: Text("Daftar Situs Rekomendasi"),
        ),
      ],
    );
  }
}
