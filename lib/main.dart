import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pgroom/src/res/routes/app_routes.dart';
import 'package:pgroom/src/utils/Theme/theme.dart';
import 'package:pgroom/src/view/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

//globel object for accessing device scren size
late Size mediaQuery;

Future<void> main() async {
  // for initilazerfirebase on open a app
  _initializerFirebase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
         darkTheme: AppTheme.darkTheme,
         theme: AppTheme.lightTheme,

         //theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home: SplashScreen(),
        getPages: AppRoutes.appRoutes());
  }
}

// ===for initialize firebase method ===
_initializerFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
