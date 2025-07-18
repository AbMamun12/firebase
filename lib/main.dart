import 'package:firebase/firebase_notification_manager.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/live_score_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotificationManager.initialize();
  print(await FirebaseNotificationManager.getFcmToken());
  runApp(const LiveScoreApp());
}

class LiveScoreApp extends StatelessWidget {
  const LiveScoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home:   LiveScoreScreen(),

    );
  }
}
