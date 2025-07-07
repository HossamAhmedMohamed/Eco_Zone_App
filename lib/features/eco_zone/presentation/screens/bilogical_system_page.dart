import 'package:flutter/material.dart';

class BiologicalSystemPage extends StatelessWidget {
  const BiologicalSystemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biological System'),
        backgroundColor: const Color(0xFF0D98BA),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/devices');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D98BA), Color(0xFFB2FFB2)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildGeneralStatus(),
            const SizedBox(height: 20),
            _buildSectionTitle("🐟 Fish Care"),
            _buildInfoTile("Feeding Reminder", "Next feeding: Today at 6 PM"),
            _buildInfoTile(
                "Fish Health Status", "Healthy - Normal activity observed"),
            const SizedBox(height: 20),
            _buildSectionTitle("🌿 Plant Care"),
            _buildInfoTile("Nutrient Check", "Check NPK, Iron weekly"),
            _buildInfoTile(
                "Growth Monitoring", "Measure height & leaf color every week"),
            _buildInfoTile("Root Cleaning", "Clean gently every 2-3 weeks"),
            _buildInfoTile("Pruning", "Trim yellow or dead leaves"),
            const SizedBox(height: 20),
            _buildSectionTitle("💧 Automated Irrigation Schedule"),
            _buildIrrigationSchedule(),
            const SizedBox(height: 20),
            _buildSectionTitle("⚙️ General Tips"),
            _buildInfoTile("System Inspection", "Full check every 2 days"),
            _buildInfoTile(
                "Backup Energy", "Use UPS or generator during outages"),
            _buildInfoTile("Alerts Settings",
                "Enable alerts for any abnormal sensor reading"),
            const SizedBox(height: 20),
            _buildSectionTitle("📅 Weekly Maintenance Schedule"),
            _buildMaintenanceTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralStatus() {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.eco, color: Color(0xFF0D98BA), size: 40),
        title: const Text(
          'Overall Biological Health',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: const Text('Good - All systems are operating normally'),
        trailing: const Icon(Icons.check_circle, color: Colors.green, size: 30),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading:
            const Icon(Icons.check_circle_outline, color: Color(0xFF0D98BA)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }

  Widget _buildIrrigationSchedule() {
    final irrigationTimes = {
      "8:00 AM": "Morning irrigation (10 mins)",
      "2:00 PM": "Midday irrigation (5 mins)",
      "6:00 PM": "Evening irrigation (10 mins)",
    };

    return Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 4,
      child: Column(
        children: irrigationTimes.entries.map((entry) {
          return ListTile(
            leading: const Icon(Icons.water_drop, color: Color(0xFF0D98BA)),
            title: Text(entry.key,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(entry.value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMaintenanceTable() {
    final maintenanceSchedule = {
      "Monday": "Check fish behavior + clean filters",
      "Tuesday": "Inspect plant roots + trim dead leaves",
      "Wednesday": "Test pH & nutrient levels",
      "Thursday": "Partial water change (10-15%)",
      "Friday": "Check system for leaks or sensor faults",
      "Saturday": "Clean tank walls + refill nutrients",
      "Sunday": "Rest / Observation only",
    };

    return Card(
      color: Colors.white.withOpacity(0.95),
      elevation: 4,
      child: Column(
        children: maintenanceSchedule.entries.map((entry) {
          return ListTile(
            leading: const Icon(Icons.calendar_today, color: Color(0xFF0D98BA)),
            title: Text(entry.key,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(entry.value),
          );
        }).toList(),
      ),
    );
  }
}