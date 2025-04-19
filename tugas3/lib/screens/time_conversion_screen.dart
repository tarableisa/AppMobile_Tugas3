import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

      if (input.contains('.')) {
        // Gunakan double untuk angka desimal
        final double year = double.parse(input);
        final double hours = year * 365.25 * 24;
        final double minutes = hours * 60;
        final double seconds = minutes * 60;

        setState(() {
          _result = '$year tahun =\n'
              '${hours.toStringAsFixed(2)} jam\n'
              '${minutes.toStringAsFixed(2)} menit\n'
              '${seconds.toStringAsFixed(2)} detik';
        });
      } else {
        // Gunakan BigInt untuk angka bulat besar
        final BigInt year = BigInt.parse(input);
        final BigInt hours =
            year * BigInt.from(36525) ~/ BigInt.from(100) * BigInt.from(24);
        final BigInt minutes = hours * BigInt.from(60);
        final BigInt seconds = minutes * BigInt.from(60);

        setState(() {
          _result = '$year tahun =\n$hours jam\n$minutes menit\n$seconds detik';
        });
      }
    } catch (e) {
      _showSnackbar(
          'Input bukan angka yang valid, silahkan input angka yang valid!');
    }
  }

  void _clearInput() {
    setState(() {
      _yearController.clear();
      _result = '';
    });
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  Widget _buildResultRow(
      IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(0.15),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              '$value $label',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
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
      backgroundColor: const Color(0xFFEEF2FF),
      appBar: AppBar(
        title: const Text(
          "Stopwatch",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          Icon(Icons.access_time, color: Colors.white),
          SizedBox(width: 12),
        ],
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
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _convertTime,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF5B67F1),
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 6,
                      ),
                      icon: Icon(Icons.calculate, color: Colors.white),
                      label: Text(
                        'Konversi',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  if (_result.isNotEmpty)
                    IconButton(
                      icon: Icon(Icons.clear, color: Colors.redAccent),
                      tooltip: 'Bersihkan',
                      onPressed: _clearInput,
                    ),
                ],
              ),
              if (_result.isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 24),
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color:
                        Color(0xFFE3E7FF), // Warna solid pastel biru keunguan
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[900],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      _buildResultRow(Icons.schedule, "Jam",
                          _extractPart(_result, 1), Colors.indigo),
                      _buildResultRow(Icons.timelapse, "Menit",
                          _extractPart(_result, 2), Colors.teal),
                      _buildResultRow(Icons.av_timer, "Detik",
                          _extractPart(_result, 3), Colors.deepOrange),
                    ],
                  ),
                )
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
