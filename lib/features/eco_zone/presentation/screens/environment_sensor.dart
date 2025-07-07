import 'package:flutter/material.dart';

class EnvironmentSensorsScreen extends StatelessWidget {
  final Color greenShade = Color(0xFFB2FFB2);
  final Color blueShade = Color(0xFF0D98BA);
  final Color greenAccent = Color(0xFF388E3C);

  EnvironmentSensorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueShade,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Environment Sensors',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          buildSensorCard(
            icon: Icons.thermostat,
            title: 'Temperature',
            currentValue: '24.9°C',
            idealRange: '22 - 28°C',
          ),
          buildSensorCard(
            icon: Icons.water_drop,
            title: 'Humidity',
            currentValue: '60%',
            idealRange: '50% - 70%',
          ),
          buildSensorCard(
            icon: Icons.wb_sunny,
            title: 'Plant Light',
            currentValue: '1709 lux',
            idealRange: '1000 - 2000 lux',
          ),
        ],
      ),
    );
  }

  Widget buildSensorCard({
    required IconData icon,
    required String title,
    required String currentValue,
    required String idealRange,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [greenShade, blueShade],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 40, color: greenAccent),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Current Value: $currentValue',
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Text(
              'Ideal Range: $idealRange',
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}