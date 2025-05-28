import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caress Care',
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.routes,
      theme: ThemeData(useMaterial3: true, fontFamily: 'Poppins'),
    );
  }
}
