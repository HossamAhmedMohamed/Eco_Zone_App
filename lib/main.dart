import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/cache/cache_helper.dart';
import 'package:untitled/core/send_fcm_token.dart';
import 'package:untitled/core/utils/notifications/get_fcm_token.dart';
import 'package:untitled/core/utils/notifications/handle_notifications.dart';
import 'package:untitled/core/utils/notifications/local_notification.dart';
import 'package:untitled/features/eco_zone/presentation/provider/theme_provider.dart';
import 'package:untitled/firebase_options.dart';
import 'package:untitled/routing/router_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: ".env");
  // await dotenv.load();
  await CacheHelper().init();

  try {
    await Future.wait([
      PushNotificationsService.init(),
      HandleNotifications.init(),
      LocalNotificationService.init(),
    ]);
  } catch (e, stack) {
    log("🚨 Error in notification init: $e");
    log("📌 Stack: $stack");
  }

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(sendFcmToken: SendFcmToken(dio: Dio())),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.sendFcmToken});

  final SendFcmToken sendFcmToken;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    widget.sendFcmToken.sendFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return StreamBuilder(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: RouterGenerator.mainRouting,
          themeMode: themeProvider.themeMode,
          title: 'ECO ZONE',
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(0xFF0D98BA),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFF0D98BA),
              foregroundColor: Colors.white,
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
          ),
        );
      },
    );
  }
}
