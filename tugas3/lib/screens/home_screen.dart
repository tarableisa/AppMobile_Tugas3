import 'package:flutter/material.dart';
import '../utils/session_manager.dart';
import 'login_screen.dart';
import 'main_menu_screen.dart';
import 'anggota_screen.dart';
import 'bantuan_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final SessionManager _session = SessionManager();

  static final List<Widget> _pages = [
    MainMenuScreen(),
    AnggotaScreen(),
    BantuanScreen(),
  ];

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
      appBar: AppBar(
        title: Text(_selectedIndex == 0
            ? 'Halaman Utama'
            : _selectedIndex == 1
                ? 'Daftar Anggota'
                : 'Bantuan'),
        actions: _selectedIndex == 2
            ? [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () => _logout(context),
                )
              ]
            : null,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
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
