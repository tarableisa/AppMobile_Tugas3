import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:latlong2/latlong.dart';

class TrackingLbsScreen extends StatefulWidget {
  @override
  _TrackingLbsScreenState createState() => _TrackingLbsScreenState();
}

class _TrackingLbsScreenState extends State<TrackingLbsScreen> {
  Location _location = Location();
  String _locationStatus = "Menunggu lokasi...";
  LatLng _initialPosition = LatLng(0.0, 0.0);
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _getLocation();
  }

  Future<void> _getLocation() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) {
        setState(() {
          _locationStatus = "Layanan lokasi tidak aktif.";
        });
        return;
      }
    }

    _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        setState(() {
          _locationStatus = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    LocationData _locationData = await _location.getLocation();

    setState(() {
      _locationStatus =
          "Lokasi ditemukan: \nLat: ${_locationData.latitude}, Long: ${_locationData.longitude}";
      _initialPosition =
          LatLng(_locationData.latitude!, _locationData.longitude!);
    });

    _mapController.move(
        _initialPosition, 15.0); // Memindahkan peta ke lokasi pengguna
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tracking Lokasi")),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _initialPosition,
                zoom: 15.0,
              ),
              children: [
                // Ganti 'layers' menjadi 'children'
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _initialPosition,
                      builder: (ctx) => Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  _locationStatus,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _getLocation,
                  child: Text("Cek Lokasi Saya"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
