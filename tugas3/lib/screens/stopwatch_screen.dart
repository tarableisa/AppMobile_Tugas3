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

  void _start() => _stopwatch.start();

  void _pause() => _stopwatch.stop();

  void _reset() {
    _stopwatch.reset();
    _laps.clear();
    setState(() {});
  }

  void _lap() {
    if (_stopwatch.isRunning) {
      setState(() {
        _laps.insert(0, _stopwatch.elapsed); // tambah ke awal
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
      appBar: AppBar(title: Text("Stopwatch")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              _formatDuration(elapsed),
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: _start, child: Text("Start")),
                ElevatedButton(onPressed: _pause, child: Text("Pause")),
                ElevatedButton(onPressed: _reset, child: Text("Reset")),
                ElevatedButton(onPressed: _lap, child: Text("Lap")),
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
                          leading: Text("Lap ${_laps.length - index}"),
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
}
