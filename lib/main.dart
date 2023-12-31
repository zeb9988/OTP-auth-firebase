import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:taxiapp/controller/auth_controller.dart';
import 'package:taxiapp/screens/Loginscreen.dart';
import 'package:taxiapp/screens/profilescreen.dart';
import 'package:taxiapp/screens/register.dart';
import 'package:taxiapp/splashscreen/splash.dart';
import 'package:taxiapp/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAJisN_EMVJupZJl8wnwiD6kJyJivb2pBM',
          appId: 'com.exam.taxiapp',
          messagingSenderId: '',
          projectId: 'taxiapp-64c06'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    authController.decideRoute();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: MyTheme.lighTheme,
      darkTheme: MyTheme.darkTheme,
      home: Login(),
    );
  }
}

class SplashScreenWidget extends StatefulWidget {
  @override
  _SplashScreenWidgetState createState() => _SplashScreenWidgetState();
}

class _SplashScreenWidgetState extends State<SplashScreenWidget> {
  @override
  void initState() {
    super.initState();
    // Simulate a splash screen delay
    Future.delayed(Duration(seconds: 2), () {
      // Navigate to the main screen after the delay
      Get.to(() => ProfileScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Login(); // Show your splash screen widget
  }
}
