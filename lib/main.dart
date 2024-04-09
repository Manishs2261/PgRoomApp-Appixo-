
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:pgroom/src/features/splash/splash_screen.dart';
import 'package:pgroom/src/res/routes/app_routes.dart';
import 'package:pgroom/src/utils/Theme/theme.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';


//global object for accessing device screen size
late Size mediaQuery;

Future<void> main() async {
  // for initializer  firebase on open a app

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDbOPMm6_yzLJNCvSYwKbi3Ajby1wadkH0",
        authDomain: "pgroomapp-e7b8c.firebaseapp.com",
        databaseURL: "https://pgroomapp-e7b8c-default-rtdb.asia-southeast1.firebasedatabase.app",
        projectId: "pgroomapp-e7b8c",
        storageBucket: "pgroomapp-e7b8c.appspot.com",
        messagingSenderId: "482025845866",
        appId: "1:482025845866:web:1a32fd93682fe4d75d8613",
        measurementId: "G-BXYHY78C24"

    )
  );
  //_initializerFirebase();

  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("212272d1-35f0-4d7c-84ad-5a0ccee76ae1");
  

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;


  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
        themeMode: ThemeMode.light,
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
