import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pgroom/src/features/filter/filter.dart';
import 'package:pgroom/src/features/new_search/new_search.dart';
import 'package:pgroom/src/features/new_search_home/new_search_home.dart';
import 'package:pgroom/src/features/splash/splash_screen.dart';
import 'package:pgroom/src/res/routes/app_routes.dart';
import 'package:pgroom/src/utils/Theme/theme.dart';
import 'package:pgroom/src/utils/ad_helper/services/ad_services.dart';
import 'package:provider/provider.dart';

//global object for accessing device screen size
late Size mediaQuery;

Future<void> main() async {
  // for initializer  firebase on open a app

  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AdProvider()), // Add your ChangeNotifier here
      ],
      child: const MyApp(), // Your main application widget
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Appixo',
        themeMode: ThemeMode.light,
        darkTheme: AppTheme.darkTheme,
        theme: AppTheme.lightTheme,

        //theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        home:  NewSearch(),//NewSearchHome(),//SplashScreen(),
        getPages: AppRoutes.appRoutes()
    );
  }
}
