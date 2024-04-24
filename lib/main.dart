import 'package:ecom_2/app/modules/cart/controllers/cart_controller.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  // Get.put(LoginController(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();
  await MemoryManagement.init();
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // var token = prefs.getString('token');
  // var role = prefs.getString('role');
  Get.put(CartController(), permanent: true);
  var token = MemoryManagement.getAccessToken();
  var role = MemoryManagement.getAccessRole();

  runApp(
    KhaltiScope(
      publicKey: 'test_public_key_b8f626b63d6b481db780ce40abe3e13b',
      builder: (context, navigatorKey) => GetMaterialApp(
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: Routes.SPLASH,
        getPages: AppPages.routes,
        defaultTransition: Transition.cupertino,
      ),
    ),
  );
}
