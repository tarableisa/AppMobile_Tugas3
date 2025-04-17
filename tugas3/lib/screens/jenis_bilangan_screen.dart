import 'package:flutter/material.dart';
import 'dart:math';

class JenisBilanganScreen extends StatefulWidget {
  @override
  _JenisBilanganScreenState createState() => _JenisBilanganScreenState();
}

class _JenisBilanganScreenState extends State<JenisBilanganScreen> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

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
      setState(() => _result = "Masukkan angka terlebih dahulu.");
      return;
    }

    final double? value = double.tryParse(input);
    if (value == null) {
      setState(() => _result = "Input bukan angka yang valid.");
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
      _result = "Jenis Bilangan:\n" + jenis.join(", ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Jenis Bilangan")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Masukkan angka",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _cekBilangan,
              child: Text("Cek"),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}
