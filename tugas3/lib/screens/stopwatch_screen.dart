import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;
  List<Duration> _laps = [];

  bool _isPaused = false;
  bool _hasStopped = false;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_stopwatch.isRunning) {
        setState(() {});
      }
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}.${(d.inMilliseconds % 1000 ~/ 100)}";
  }

  void _startStop() {
    if (_hasStopped) return; // jangan bisa start lagi setelah stop sebelum reset

    if (_stopwatch.isRunning || _isPaused) {
      _stopwatch.stop();
      _isPaused = false;
      _hasStopped = true;
    } else {
      _stopwatch.start();
      _hasStopped = false;
    }
    setState(() {});
  }

  void _pause() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _isPaused = true;
      setState(() {});
    }
  }

  void _reset() {
    _stopwatch.reset();
    _laps.clear();
    _isPaused = false;
    _hasStopped = false;
    setState(() {});
  }

  void _lap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _stopwatch.elapsed);
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsed;

    return Scaffold(
      appBar: AppBar(
      title: Text(
          "Stopwatch",
          style: TextStyle(color: Colors.white),
        ),
      backgroundColor: Colors.blueAccent,
    ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  _formatDuration(elapsed),
                  style: TextStyle(
                    fontSize: 56,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  (_stopwatch.isRunning || _isPaused) ? Icons.stop : Icons.play_arrow,
                  (_stopwatch.isRunning || _isPaused) ? "Stop" : "Start",
                  _startStop,
                  (_stopwatch.isRunning || _isPaused) ? Colors.red : Colors.green,
                  isEnabled: !_hasStopped || (_stopwatch.isRunning || _isPaused),
                ),
                _buildActionButton(
                  _isPaused ? Icons.play_arrow : Icons.pause,
                  _isPaused ? "Unpause" : "Pause",
                  _pause,
                  Colors.orange,
                  isEnabled: _stopwatch.isRunning,
                ),
                _buildActionButton(
                  Icons.flag,
                  "Lap",
                  _lap,
                  Colors.blue,
                  isEnabled: _stopwatch.isRunning,
                ),
                _buildActionButton(
                  Icons.refresh,
                  "Reset",
                  _reset,
                  Colors.grey,
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _laps.isEmpty
                  ? Center(child: Text("Belum ada lap."))
                  : ListView.builder(
                      itemCount: _laps.length,
                      itemBuilder: (context, index) {
                        final lapTime = _laps[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text('${_laps.length - index}'),
                          ),
                          title: Text(_formatDuration(lapTime)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label,
    VoidCallback onPressed,
    Color color, {
    bool isEnabled = true,
  }) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(16),
            backgroundColor: isEnabled ? color : Colors.grey[300],
          ),
          onPressed: isEnabled ? onPressed : null,
          child: Icon(icon, size: 32, color: isEnabled ? Colors.white : Colors.grey),
        ),
        SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}
