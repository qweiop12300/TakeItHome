
import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/routes/home/view.dart';
import 'package:take_it_home/routes/login/view.dart';

import 'common/Global.dart';

void main() {
  // HttpOverrides.global = new MyHttpOverrides();
  Global.init().then((value) => {
    if(Platform.isWindows||Platform.isLinux){
      DartVLC.initialize()
    },
    runApp(MainPage())
  });

}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return (super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port)=> true);
//   }
// }

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: RouteConfig.home,
      getPages: RouteConfig.getPages,
    );
  }
}

class RouteConfig {
  ///主页面
  static const String main = "/";

  static const String home = "/home";

  static const String login = "/login";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: login, page: () =>LoginPage())
  ];
}
