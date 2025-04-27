import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/features/eco_zone/presentation/screens/water_quality_page.dart';
import 'package:untitled/features/eco_zone/presentation/widgets/dash_board_card.dart';
import 'package:untitled/routing/app_router.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: <Widget>[
            DashboardCard(
              title: 'Water Quality',
              imagePath: 'assets/images/quality_water.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WaterQualitySensorsPage(),
                  ),
                );
              },
            ),
            DashboardCard(
              title: 'Environment',
              imagePath: 'assets/images/environment.png',
              onTap: () {
               GoRouter.of(context).pushNamed(AppRouter.environment);
              },
            ),
            DashboardCard(
              title: 'Biological System',
              imagePath: 'assets/images/biological_system.png',
              onTap: () {
              GoRouter.of(context).pushNamed(AppRouter.biologicalSystem);
              },
            ),
            DashboardCard(
              title: 'Devices',
              imagePath: 'assets/images/devices.png',
              onTap: () {
              GoRouter.of(context).pushNamed(AppRouter.devices);
              },
            ),
          ],
        ),
      ),
    );
  }
}