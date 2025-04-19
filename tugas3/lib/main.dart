import 'package:flutter/material.dart';
import 'package:tugas3/screens/login_screen.dart';
import 'package:tugas3/screens/home_screen.dart';
import 'package:tugas3/screens/stopwatch_screen.dart';
import 'package:tugas3/screens/jenis_bilangan_screen.dart';
import 'package:tugas3/screens/tracking_lbs_screen.dart';
import 'package:tugas3/screens/time_conversion_screen.dart';
import 'package:tugas3/screens/site_recommendation_screen.dart';
import 'package:tugas3/utils/session_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _session = SessionManager();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tugas 3',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: _session.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else {
            return snapshot.data == true ? HomeScreen() : LoginScreen();
          }
        },
      ),
      // Menambahkan routes
      routes: {
        '/stopwatch': (context) =>StopwatchScreen(), 
        '/jenis-bilangan': (context) => JenisBilanganScreen(),
        '/tracking-lbs': (context) => TrackingLbsScreen(),
        '/time-conversion': (context) => TimeConversionScreen(),
        '/site-recommendation': (context) => SiteRecommendationScreen(),
      },
    );
  }
}
