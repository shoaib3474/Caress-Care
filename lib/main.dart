import 'package:caress_care/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Calm Zone',
      initialRoute: AppRoutes.doctorRefScreen,
      getPages: AppRoutes.routes,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
    );
  }
}
