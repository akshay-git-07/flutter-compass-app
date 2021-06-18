import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_compass_app/services/speech_api.dart';
import 'package:flutter_compass_app/widgets/glowing_mic.dart';
import 'package:location/location.dart';

class Compass extends StatefulWidget {
  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  final SpeechAPI speechAPI = SpeechAPI();
  Location location = new Location();
  LocationData _locationData;

  @override
  void initState() {
    super.initState();
    speechAPI.setLanguage();
    speechAPI.setPitchRate();
  }

  String determineDirection(double dir) {
    String direction;
    if (dir == null) {
      return 'null';
    } else {
      if (dir > 335 && dir <= 359 || dir >= 0 && dir <= 25) {
        direction = 'North';
      } else if (dir > 25 && dir <= 65) {
        direction = 'North-East';
      } else if (dir > 65 && dir <= 115) {
        direction = 'East';
      } else if (dir > 115 && dir <= 155) {
        direction = 'South-East';
      } else if (dir > 155 && dir <= 205) {
        direction = 'South';
      } else if (dir > 205 && dir <= 245) {
        direction = 'South-West';
      } else if (dir > 245 && dir <= 295) {
        direction = 'West';
      } else {
        direction = 'North-West';
      }
    }

    return direction;
  }

  getLocationData() async {
    try {
      _locationData = await location.getLocation();
      print(_locationData);

      final text =
          'Latitude ${_locationData.latitude.toStringAsFixed(2)}, Longitude ${_locationData.longitude.toStringAsFixed(2)}';
      speechAPI.speak(text);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color(0xFF1D1D35),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.69,
            color: Color(0xFF1D1D35),
            child: _buildCompass(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.20,
            color: Color(0xFF1D1D35),
            child: PlayButton(
              function: () {
                getLocationData();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompass() {
    String prevDir = '';

    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        double direction = snapshot.data.heading;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        String curDir = determineDirection(direction);
        if (curDir != prevDir) {
          // print(curDir);
          speechAPI.speak(curDir);
          prevDir = curDir;
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: Text(
                  curDir != prevDir ? curDir : prevDir,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Material(
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
                elevation: 4.0,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Transform.rotate(
                    angle: (direction * (math.pi / 180) * -1),
                    child: Image.asset('assets/compass.jpg'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
