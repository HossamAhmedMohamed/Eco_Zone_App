import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/cache/cache_helper.dart';
import 'package:untitled/features/eco_zone/presentation/provider/theme_provider.dart';
import 'package:untitled/routing/app_router.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF0D98BA),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔁 اللغة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Language", style: TextStyle(fontSize: 18)),
                DropdownButton<String>(
                  value: 'en',
                  items: [
                    DropdownMenuItem(value: 'en', child: Text("English")),
                    DropdownMenuItem(value: 'ar', child: Text("عربي")),
                  ],
                  onChanged: (value) {
                    // تغيير اللغة لو حبيتي مستقبلاً
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // 🌙 الوضع الليلي
            SwitchListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text("Dark Mode", style: TextStyle(fontSize: 18)),
              value: themeProvider.isDarkMode,
              onChanged: (val) {
                themeProvider.toggleTheme(val);
              },
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              icon: Icon(Icons.logout),
              label: Text("Log Out", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () async {
                await CacheHelper().removeData(key: 'userId');
                if (context.mounted) {
                  GoRouter.of(context).goNamed(AppRouter.login);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
