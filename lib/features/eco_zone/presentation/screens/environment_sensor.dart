import 'dart:math';

import 'package:flutter/material.dart';

class EnvironmentSensorsPage extends StatefulWidget {
  const EnvironmentSensorsPage({super.key});

  @override
  State<EnvironmentSensorsPage> createState() => _EnvironmentSensorsPageState();
}

class _EnvironmentSensorsPageState extends State<EnvironmentSensorsPage> {
  // Data for the sensors with ideal ranges (removed 'Camera')
  Map<String, Map<String, String>> sensorData = {
    'Temperature': {'value': '25°C', 'ideal': '22 - 28°C'},
    'Humidity': {'value': '60%', 'ideal': '50% - 70%'},
    'Plant Light': {'value': '1500 lux', 'ideal': '1000 - 2000 lux'},
  };

  // Function to generate random values close to ideal ranges with some variation
  String _generateRandomValue(String sensorName, String idealValue) {
    final random = Random();
    List<String> idealRange;

    switch (sensorName) {
      case 'Temperature':
        idealRange = idealValue.split(' - ');
        double minTemp = double.parse(idealRange[0].replaceAll('°C', ''));
        double maxTemp = double.parse(idealRange[1].replaceAll('°C', ''));
        double randomTemp = random.nextDouble() * (maxTemp - minTemp) + minTemp;
        return '${(randomTemp + random.nextDouble() * 2 - 1).toStringAsFixed(1)}°C';
      case 'Humidity':
        idealRange = idealValue.split(' - ');
        double minHumidity = double.parse(idealRange[0].replaceAll('%', ''));
        double maxHumidity = double.parse(idealRange[1].replaceAll('%', ''));
        double randomHumidity = random.nextDouble() * (maxHumidity - minHumidity) + minHumidity;
        return '${(randomHumidity + random.nextDouble() * 5 - 2.5).toStringAsFixed(0)}%';
      case 'Plant Light':
        idealRange = idealValue.split(' - ');
        double minLight = double.parse(idealRange[0].replaceAll(' lux', ''));
        double maxLight = double.parse(idealRange[1].replaceAll(' lux', ''));
        double randomLight = random.nextDouble() * (maxLight - minLight) + minLight;
        return '${(randomLight + random.nextDouble() * 100 - 50).toStringAsFixed(0)} lux';
      default:
        return 'N/A';
    }
  }

  @override
  void initState() {
    super.initState();
    // Update sensor values every 15 seconds
  
      setState(() {
        // Update the sensor values with random data
        sensorData = sensorData.map((key, value) {
          return MapEntry(key, {
            'value': _generateRandomValue(key, value['ideal']!),
            'ideal': value['ideal']!,
          });
        });
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Environment Sensors'),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: sensorData.length,
        itemBuilder: (context, index) {
          String sensorName = sensorData.keys.elementAt(index);
          String sensorValue = sensorData[sensorName]!['value']!;
          String idealValue = sensorData[sensorName]!['ideal']!;

          // Assign appropriate icons for each sensor
          IconData icon;
          switch (sensorName) {
            case 'Temperature':
              icon = Icons.thermostat;
              break;
            case 'Humidity':
              icon = Icons.invert_colors;
              break;
            case 'Plant Light':
              icon = Icons.wb_sunny;
              break;
            default:
              icon = Icons.sensors;
          }

          return Card(
            elevation: 5,
            margin: EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Icon(
                    icon,
                    size: 60,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      sensorName,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      'Current Value: $sensorValue',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.pink, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Text(
                      'Ideal Range: $idealValue',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}