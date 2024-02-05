import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/page/all/login.dart';
import 'package:untitled1/page/user/home_page.dart';
import 'package:untitled1/page/userDelivery/orders.dart';
import 'package:untitled1/page/vendor/get_vendor_shop.dart';
import 'network/local/cache.dart';

String? type = CacheHelper.getData(key: 'type');

Future<void> backgroundMessageHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await CacheHelper.init();
  runApp(DevicePreview(builder: (context)=>const MyApp()));
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    String? token = CacheHelper.getData(key: 'token');
    bool status = false;
    Widget startWidget = Login();
    if (token != null) {
      status = true;
    }
    if (CacheHelper.getData(key: 'type') == 'vendor') {
      startWidget = const GetVendorShop();
    } else if (CacheHelper.getData(key: 'type') == 'customer') {
      startWidget = const HomePage();
    } else {
      startWidget = const Orders('orders');
    }

    return MaterialApp(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      home:  Login(),
    );
  }
}
