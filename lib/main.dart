import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:untitled/core/cache/cache_helper.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/routing/router_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  // await dotenv.load();
  await CacheHelper().init();
  runApp(MyApp());
  

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: RouterGenerator.mainRouting,
          title: 'ECO ZONE',
          theme: ThemeData(primarySwatch: Colors.blue),
        );
      },
    );
  }
}
