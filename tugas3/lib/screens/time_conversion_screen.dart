import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  String _result = '';

  // Fungsi untuk konversi tahun ke jam, menit, dan detik
  void _convertTime() {
    // Ambil nilai tahun dari input
    final year = double.tryParse(_yearController.text);
    
    if (year == null) {
      setState(() {
        _result = 'Masukkan angka yang valid!';
      });
      return;
    }

    // 1 tahun = 365.25 hari, 1 hari = 24 jam, 1 jam = 60 menit, 1 menit = 60 detik
    final hours = year * 365.25 * 24;
    final minutes = hours * 60;
    final seconds = minutes * 60;

    setState(() {
      _result = '$year tahun = ${hours.toStringAsFixed(2)} jam = ${minutes.toStringAsFixed(2)} menit = ${seconds.toStringAsFixed(2)} detik';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Konversi Waktu")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Masukkan jumlah tahun',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan jumlah tahun';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _convertTime();
                  }
                },
                child: Text('Konversi'),
              ),
              SizedBox(height: 20),
              Text(
                _result,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
