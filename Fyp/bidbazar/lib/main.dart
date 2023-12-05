import 'package:bidbazar/Views/Login.dart';
import 'package:bidbazar/Views/Signup.dart';
import 'package:bidbazar/Views/splash.dart';
import 'package:bidbazar/routes/app_pages.dart';
import 'package:bidbazar/routes/app_routesnames.dart';
import 'package:bidbazar/widgets/buttonController.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const bidbazar());
}

class bidbazar extends StatelessWidget {
  const bidbazar({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ButtonController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bidbazar',
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
    );
  }
}
