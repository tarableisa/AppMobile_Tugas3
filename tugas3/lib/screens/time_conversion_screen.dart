import 'package:flutter/material.dart';

class TimeConversionScreen extends StatefulWidget {
  @override
  _TimeConversionScreenState createState() => _TimeConversionScreenState();
}

class _TimeConversionScreenState extends State<TimeConversionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();
  String _result = '';

  void _convertTime() {
    final year = double.tryParse(_yearController.text);

    if (year == null) {
      setState(() {
        _result = 'Masukkan angka yang valid!';
      });
      return;
    }

    final hours = year * 365.25 * 24;
    final minutes = hours * 60;
    final seconds = minutes * 60;

    setState(() {
      _result =
          '$year tahun =\n${hours.toStringAsFixed(2)} jam\n${minutes.toStringAsFixed(2)} menit\n${seconds.toStringAsFixed(2)} detik';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Konversi Waktu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Konversi',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              if (_result.isNotEmpty)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _result,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
