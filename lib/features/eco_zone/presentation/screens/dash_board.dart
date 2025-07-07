import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/features/eco_zone/presentation/screens/live_stream_screen.dart';
import 'package:untitled/features/eco_zone/presentation/screens/setting_page.dart';
import 'package:untitled/routing/app_router.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, dynamic>> features = [
    {
      'title': 'Water Quality',
      'route': AppRouter.waterQuality,
      'image': 'assets/images/water quality.png',
    },
    {
      'title': 'Environment',
      'route': AppRouter.environment,
      'image': 'assets/images/environment.png',
    },
    {
      'title': 'BiologicalSystem',
      'route': AppRouter.biologicalSystem,
      'image': 'assets/images/biologicalsystem.png',
    },
    {
      'title': 'Devices',
      'route': AppRouter.devices,
      'image': 'assets/images/devices.png',
    },

    {
      'title': 'Chat with Eco',
      'route': AppRouter.chat,
      'image': 'assets/images/bot.png',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0D98BA),
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),

        actions: [
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LiveStreamScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: features.length,
          separatorBuilder: (context, index) => SizedBox(height: 16),
          itemBuilder: (context, index) {
            final feature = features[index];
            return GestureDetector(
              onTap: () {
                GoRouter.of(context).push(feature['route']);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                      child: Image.asset(
                        feature['image'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        feature['title'],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
