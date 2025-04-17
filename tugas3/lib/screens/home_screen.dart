import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/session_manager.dart';
import 'login_screen.dart';
import 'anggota_screen.dart';
import 'bantuan_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final SessionManager _session = SessionManager();

  List<Widget> get _pages => [
        _buildMainMenu(),
        AnggotaScreen(),
        BantuanScreen(),
      ];

  Widget _buildMainMenu() {
    final List<Map<String, dynamic>> menuItems = [
      {'title': 'Stopwatch', 'icon': Icons.timer, 'route': '/stopwatch'},
      {'title': 'Jenis Bilangan', 'icon': Icons.calculate, 'route': '/jenis-bilangan'},
      {'title': 'Tracking LBS', 'icon': Icons.location_on, 'route': '/tracking-lbs'},
      {'title': 'Konversi Waktu', 'icon': Icons.access_time, 'route': '/time-conversion'},
      {'title': 'Situs Rekomendasi', 'icon': Icons.link, 'route': '/site-recommendation'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: menuItems.length,
      itemBuilder: (context, index) {
        final item = menuItems[index];
        return GestureDetector(
          onTap: () => Navigator.pushNamed(context, item['route']),
          child: AspectRatio(
            aspectRatio: 1, // supaya kotak
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(item['icon'], size: 48, color: Colors.blueAccent),
                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(BuildContext context) async {
    await _session.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          _selectedIndex == 0
              ? 'Halaman Utama'
              : _selectedIndex == 1
                  ? 'Daftar Anggota'
                  : 'Bantuan',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          )
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        unselectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Anggota',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help_outline),
            label: 'Bantuan',
          ),
        ],
      ),
    );
  }
}
