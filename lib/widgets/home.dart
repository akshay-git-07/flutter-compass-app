import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_compass_app/widgets/compass.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _hasPermissions = false;

  @override
  void initState() {
    super.initState();
    // _fetchPermissionStatus();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF1D5A9F),
        title: Center(
          child: const Text('Talking Compass'),
        ),
      ),
      body: Builder(builder: (context) {
        if (_hasPermissions) {
          return Compass();
        } else {
          return _buildPermissionSheet();
          // return Container(
          //   child: Text(
          //     'Please grant location permission',
          //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          //   ),
          // );
        }
      }),
    );
  }

  _requestPermissions() {
    Permission.locationWhenInUse.request().then((ignored) {
      _fetchPermissionStatus();
    });
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Location Permission Required',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            child: Text('Request Permissions'),
            onPressed: () {
              Permission.locationWhenInUse.request().then((ignored) {
                _fetchPermissionStatus();
              });
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Open App Settings'),
            onPressed: () {
              openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }

  void _fetchPermissionStatus() {
    Permission.locationWhenInUse.status.then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }
}
