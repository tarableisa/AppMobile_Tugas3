import 'package:flutter/material.dart';
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
  final PageController _pageController = PageController();
  final SessionManager _session = SessionManager();

  final List<Map<String, dynamic>> menuItems = [
    {'title': 'Stopwatch', 'icon': Icons.timer, 'route': '/stopwatch'},
    {
      'title': 'Jenis Bilangan',
      'icon': Icons.calculate,
      'route': '/jenis-bilangan'
    },
    {
      'title': 'Tracking LBS',
      'icon': Icons.location_on,
      'route': '/tracking-lbs'
    },
    {
      'title': 'Konversi Waktu',
      'icon': Icons.access_time,
      'route': '/time-conversion'
    },
    {
      'title': 'Situs Rekomendasi',
      'icon': Icons.link,
      'route': '/site-recommendation'
    },
  ];

  final List<String> tabTitles = ['Beranda', 'Anggota', 'Bantuan'];

  List<Widget> get _pages => [
        _buildMainMenu(),
        AnggotaScreen(),
        BantuanScreen(),
      ];

  void _onItemTapped(int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildMainMenu() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: menuItems.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, i) {
          final item = menuItems[i];
          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, item['route']),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item['icon'], size: 40, color: Colors.blueAccent),
                  SizedBox(height: 12),
                  Text(
                    item['title'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _logout(BuildContext ctx) async {
    await _session.logout();
    Navigator.pushReplacement(
        ctx, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color.fromARGB(250, 169, 198, 212).withOpacity(0.02),
              blurRadius: 4)
        ],
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(165, 250, 250, 250),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.blueGrey.shade200,
        items: [
          _buildNavItem(Icons.home_outlined, Icons.home, 'Beranda', 0),
          _buildNavItem(Icons.group_outlined, Icons.group, 'Anggota', 1),
          _buildNavItem(Icons.help_outline, Icons.help, 'Bantuan', 2),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData off, IconData on, String label, int idx) {
    final bool active = _selectedIndex == idx;
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: active
            ? BoxDecoration(
                color: Color(0xFFE3F2FD), // pastel biru muda
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Icon(active ? on : off, size: 24),
      ),
      label: label,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 0,
        title: Text(tabTitles[_selectedIndex],
            style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => _logout(context)),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }
}
