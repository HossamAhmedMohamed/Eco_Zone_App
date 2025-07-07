import 'package:flutter/material.dart';

class WaterQualityScreen extends StatelessWidget {
  final List<Map<String, String>> sensors = [
    {
      'title': 'Temperature',
      'value': '24.4°C',
      'range': '24 - 28°C',
      'icon': '🌡️'
    },
    {
      'title': 'Dissolved Oxygen',
      'value': '7.8 mg/L',
      'range': '6 - 8 mg/L',
      'icon': '💨'
    },
    {
      'title': 'Ammonia',
      'value': '0.02 mg/L',
      'range': '0 - 0.05 mg/L',
      'icon': '⚠️'
    },
    {
      'title': 'Nitrate',
      'value': '13.5 mg/L',
      'range': '10 - 20 mg/L',
      'icon': '🧪'
    },
    {
      'title': 'Electrical Conductivity',
      'value': '217 µS/cm',
      'range': '150 - 500 µS/cm',
      'icon': '🔌'
    },
    {
      'title': 'Dissolved Solids',
      'value': '143 ppm',
      'range': '100 - 200 ppm',
      'icon': '🧂'
    },
    {'title': 'pH', 'value': '7.2', 'range': '6.5 - 7.5', 'icon': '💧'},
    {
      'title': 'Water Level',
      'value': '91%',
      'range': '70% - 90%',
      'icon': '🌊'
    },
  ];

    WaterQualityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Water Quality Sensors")),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: sensors.length,
        itemBuilder: (context, index) {
          final sensor = sensors[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D98BA), Color(0xFFB2FFB2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Text(
                sensor['icon'] ?? '',
                style: TextStyle(fontSize: 24),
              ),
              title: Text(
                sensor['title'] ?? '',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              subtitle: Text(
                'Current Value: ${sensor['value']}\nIdeal Range: ${sensor['range']}',
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}