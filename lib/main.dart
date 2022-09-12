import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:training/routes/app_routes.dart';
import 'package:training/splash_form_controller.dart';

void main() async {

  Get.testMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  Get.put<SplashFormController>(SplashFormController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.noTransition,
      initialRoute: "/splash",
      getPages: AppRoutes.routes,
    );
  }
}
