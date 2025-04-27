import 'package:flutter/material.dart';

class BiologicalSystemPage extends StatelessWidget {
  const BiologicalSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Biological System Data')),
      body: Center(child: Text('Display data for Biological System here')),
    );
  }
}