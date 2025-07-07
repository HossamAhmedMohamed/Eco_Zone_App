 

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  BluetoothDevice? selectedDevice;
  BluetoothConnection? connection;
  bool isConnected = false;

  // ✅ الحالات لكل جهاز
  final Map<String, bool> devicesStatus = {
    'Heater': false,
    'Pump': false,
    'Feeder': false,
    'Fan': false,
    'Valve': false,
    'Filter': false,
  };

  void connectToDevice() async {
    final bondedDevices =
        await FlutterBluetoothSerial.instance.getBondedDevices();

    final device = await showDialog<BluetoothDevice>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text("Select Device"),
        children: bondedDevices
            .map((d) => SimpleDialogOption(
                  child: Text(d.name ?? d.address),
                  onPressed: () => Navigator.pop(context, d),
                ))
            .toList(),
      ),
    );

    if (device != null) {
      try {
        connection = await BluetoothConnection.toAddress(device.address);
        setState(() {
          selectedDevice = device;
          isConnected = true;
        });
        if (kDebugMode) {
          print('Connected to ${device.name}');
        }
      } catch (e) {
        if (kDebugMode) {
          print('Cannot connect, exception occured');
          print(e);
        }
      }
    }
  }

  void sendCommand(String command) {
    if (connection != null && connection!.isConnected) {
      connection!.output.add(Uint8List.fromList("$command\n".codeUnits));
      if (kDebugMode) {
        print("Sent: $command");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices Control'),
        backgroundColor: const Color(0xFF0D98BA),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: connectToDevice,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D98BA),
              ),
              child: Text(isConnected ? "Connected ✅" : "Connect to Device"),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: devicesStatus.entries.map((entry) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0D98BA), Color(0xFFB2FFB2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    trailing: Switch(
                      value: entry.value,
                      onChanged: isConnected
                          ? (bool newValue) {
                              setState(() {
                                devicesStatus[entry.key] = newValue;
                              });

                              // ✅ إرسال الأمر لـ ESP32
                              sendCommand(
                                  "${entry.key.toLowerCase()}_${newValue ? 'on' : 'off'}");

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${entry.key} turned ${newValue ? 'ON' : 'OFF'}'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          : null,
                      activeColor: Colors.greenAccent,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}