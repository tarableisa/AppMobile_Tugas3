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
    try {
      final input = _yearController.text.trim();

      if (input.isEmpty || !RegExp(r'^\d+$').hasMatch(input)) {
        _showSnackbar('Masukkan angka yang valid!');
        return;
      }

      final BigInt year = BigInt.parse(input);
      final BigInt hours =
          year * BigInt.from(36525) ~/ BigInt.from(100) * BigInt.from(24);
      final BigInt minutes = hours * BigInt.from(60);
      final BigInt seconds = minutes * BigInt.from(60);

      setState(() {
        _result = '$year tahun =\n$hours jam\n$minutes menit\n$seconds detik';
      });
    } catch (e) {
      _showSnackbar('Terjadi kesalahan dalam konversi.');
    }
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Widget _buildResultRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: Colors.blueAccent),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              '$value $label',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  String _extractPart(String result, int line) {
    final lines = result.split('\n');
    return lines.length > line ? lines[line].split(' ')[0] : '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F3FF),
      appBar: AppBar(
        title: Text(
          "Konversi Waktu",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
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
                  prefixIcon: Icon(Icons.calendar_today),
                  labelText: 'Masukkan jumlah tahun',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _convertTime,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
                icon: Icon(Icons.calculate, color: Colors.white,),
                label: Text(
                  'Konversi',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              if (_result.isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFa1c4fd), Color(0xFFc2e9fb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '${_yearController.text} Tahun =',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildResultRow(
                          Icons.schedule, "Jam", _extractPart(_result, 1)),
                      _buildResultRow(
                          Icons.timelapse, "Menit", _extractPart(_result, 2)),
                      _buildResultRow(
                          Icons.av_timer, "Detik", _extractPart(_result, 3)),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }
}
