import 'package:flutter/material.dart';
import 'dart:math';

class JenisBilanganScreen extends StatefulWidget {
  @override
  _JenisBilanganScreenState createState() => _JenisBilanganScreenState();
}

class _JenisBilanganScreenState extends State<JenisBilanganScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";
  bool _showResult = false;

  List<Map<String, dynamic>> history = [];

  bool isPrime(int n) {
    if (n <= 1) return false;
    if (n == 2) return true;
    for (int i = 2; i <= sqrt(n).toInt(); i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cekBilangan() {
    final input = _controller.text;
    if (input.isEmpty) {
      _showSnackBar("Masukkan angka terlebih dahulu.");
      return;
    }

    final double? value = double.tryParse(input);
    if (value == null) {
      _showSnackBar("Input bukan angka yang valid.");
      return;
    }

    final bool isInteger = value == value.toInt();
    final int intVal = value.toInt();

    List<String> jenis = [];

    if (value >= 0 && isInteger) jenis.add("Cacah");
    if (isInteger) jenis.add("Bulat " + (value >= 0 ? "Positif" : "Negatif"));
    if (!isInteger) jenis.add("Desimal");
    if (isInteger && isPrime(intVal)) jenis.add("Prima");

    setState(() {
      _result = input;
      _showResult = true;
      history.insert(0, {
        'input': input,
        'jenis': jenis,
      });
    });
  }

  void _clearRiwayat() {
    setState(() {
      if (history.isNotEmpty) {
        history = [history.first]; // Sisakan hasil terakhir
      }
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      duration: Duration(seconds: 2),
    ));
  }

  Widget _buildChip(String jenis) {
    final Map<String, dynamic> chipStyle = {
      "Cacah": {"icon": Icons.exposure_zero, "color": Colors.green},
      "Bulat Positif": {"icon": Icons.plus_one, "color": Colors.blue},
      "Bulat Negatif": {"icon": Icons.exposure_neg_1, "color": Colors.blueGrey},
      "Desimal": {"icon": Icons.linear_scale, "color": Colors.orange},
      "Prima": {"icon": Icons.star, "color": Colors.purple},
    };

    return Chip(
      avatar: Icon(
        chipStyle[jenis]?['icon'] ?? Icons.label,
        size: 18,
        color: Colors.white,
      ),
      label: Text(jenis),
      backgroundColor: chipStyle[jenis]?['color'] ?? Colors.grey,
      labelStyle: TextStyle(color: Colors.white),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Jenis Bilangan",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Stack(
        children: [
          // Background gradient statis
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.purpleAccent.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Konten utama
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Masukkan angka",
                        prefixIcon: Icon(Icons.calculate_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _cekBilangan,
                    icon: Icon(Icons.search),
                    label: Text("Cek"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 230, 215, 255),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 30),
                  if (_showResult)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hasil:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 10),
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          color: Colors.white.withOpacity(0.95),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  "Angka: $_result",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  children: (_showResult && history.isNotEmpty)
                                      ? history.first['jenis']
                                          .map<Widget>(
                                              (jenis) => _buildChip(jenis))
                                          .toList()
                                      : [],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (history.length > 1) ...[
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Riwayat Pengecekan",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: _clearRiwayat,
                          icon: Icon(Icons.delete_forever, color: Colors.red),
                          tooltip: "Hapus semua riwayat",
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: history
                          .skip(1)
                          .map((item) => Card(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: Icon(Icons.history,
                                      color: Colors.deepPurple),
                                  title: Text("Angka: ${item['input']}"),
                                  subtitle: Wrap(
                                    spacing: 6,
                                    children: item['jenis']
                                        .map<Widget>(
                                            (jenis) => _buildChip(jenis))
                                        .toList(),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
