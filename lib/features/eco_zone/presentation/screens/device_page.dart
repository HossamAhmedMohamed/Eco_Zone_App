import 'package:flutter/material.dart';

class DevicePage extends StatefulWidget {
  const DevicePage({super.key});

  @override
  State<DevicePage> createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  bool isHeaterOn = false;
  double heaterTemp = 45.0;

  bool isFanOn = false;
  double fanSpeed = 1.0;

  bool isFilterOn = false;

  bool isFeederOn = false;
  double foodAmount = 50.0;

  bool isPumpOn = false;
  double waterFlow = 1.0;

  bool isValveOpen = false;

  Widget buildDeviceTile(String title, IconData icon, bool status, VoidCallback toggle) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, size: 30, color: Colors.lightBlue), // Change icon color to light blue
          title: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          trailing: Switch(
            value: status,
            onChanged: (value) => toggle(),
            activeColor: Colors.lightBlue, // Set the switch color to light blue
          ),
        ),
      ),
    );
  }

  Widget buildSliderTile(String title, IconData icon, double value, double min, double max, int divisions, ValueChanged<double> onChanged) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 5,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.pink, Colors.lightBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon, size: 30, color: Colors.lightBlue), // Change icon color to light blue
                  SizedBox(width: 10),
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Slider(
                value: value,
                min: min,
                max: max,
                divisions: divisions,
                label: value.toStringAsFixed(1),
                onChanged: onChanged,
                activeColor: Colors.lightBlue, // Change active slider color to light blue
                // ignore: deprecated_member_use
                inactiveColor: Colors.lightBlue.withOpacity(0.5), // Change inactive slider color
              ),
              Text(
                value.toStringAsFixed(1), // Display value with the same color as the slider
                style: TextStyle(color: Colors.lightBlue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Device Control",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            buildDeviceTile("Heater", Icons.thermostat, isHeaterOn, () => setState(() => isHeaterOn = !isHeaterOn)),
            if (isHeaterOn) buildSliderTile("Temperature", Icons.thermostat, heaterTemp, 0, 100, 10, (value) => setState(() => heaterTemp = value)),

            buildDeviceTile("Fan", Icons.air, isFanOn, () => setState(() => isFanOn = !isFanOn)),
            if (isFanOn) buildSliderTile("Speed", Icons.speed, fanSpeed, 0, 3, 3, (value) => setState(() => fanSpeed = value)),

            buildDeviceTile("Filter", Icons.filter_alt, isFilterOn, () => setState(() => isFilterOn = !isFilterOn)),

            buildDeviceTile("Feeder", Icons.restaurant, isFeederOn, () => setState(() => isFeederOn = !isFeederOn)),
            if (isFeederOn) buildSliderTile("Food Amount (g)", Icons.fastfood, foodAmount, 10, 100, 10, (value) => setState(() => foodAmount = value)),

            buildDeviceTile("Pump", Icons.water, isPumpOn, () => setState(() => isPumpOn = !isPumpOn)),
            if (isPumpOn) buildSliderTile("Water Flow (L/s)", Icons.waves, waterFlow, 0, 5, 5, (value) => setState(() => waterFlow = value)),

            buildDeviceTile("Valve", Icons.sync_alt, isValveOpen, () => setState(() => isValveOpen = !isValveOpen)),
          ],
        ),
      ),
    );
  }
}