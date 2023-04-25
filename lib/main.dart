
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:take_it_home/routes/add_animal/view.dart';
import 'package:take_it_home/routes/chat/view.dart';
import 'package:take_it_home/routes/home/home.dart';
import 'package:take_it_home/routes/image_show/view.dart';
import 'package:take_it_home/routes/list/view.dart';
import 'package:take_it_home/routes/login/view.dart';
import 'package:take_it_home/routes/mine_list/view.dart';
import 'package:take_it_home/routes/read_animal/view.dart';
import 'package:take_it_home/routes/read_user/view.dart';
import 'package:take_it_home/routes/read_view/view.dart';
import 'package:take_it_home/routes/register/view.dart';
import 'package:take_it_home/routes/search/view.dart';
import 'package:take_it_home/routes/topic/view.dart';


import 'common/Global.dart';

import 'package:take_it_home/widgets/VideoPlayer.dart'
if(dart.library.html) 'package:take_it_home/widgets/VideoPlayerAndroid.dart'
if(dart.library.io) 'package:take_it_home/widgets/VideoPlayerWindows.dart';

void main() {

  Global.init().then((value) => {
    VideoPlayer.init(),
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white),
      ),
    runApp(MainPage())
  });

}


class MainPage extends StatelessWidget {

  static String defaultFontFamily = 'Avenir';

  @override
  Widget build(BuildContext context) {
    const Color primaryTextColor = Color(0xFF0D253C);
    const Color secondaryTextColor = Color(0xFF2D4379);
    const Color primaryColor = Color(0xff376AED);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: primaryTextColor,
          titleSpacing: 32,
          elevation: 0,
        ),
        colorScheme: const ColorScheme.light(
            primary: primaryColor,
            surface: Colors.white,
            onSurface: primaryTextColor,
            onSecondary: secondaryTextColor,
            onPrimary: Colors.white,
            background: Color(0xfffbfcff),
            onBackground: Colors.black),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(
                  fontSize: 14,
                  fontFamily: defaultFontFamily,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
        snackBarTheme: const SnackBarThemeData(
            backgroundColor: primaryColor,
            contentTextStyle: TextStyle(color: Colors.white)),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: primaryTextColor,
          ),
          headline5: TextStyle(
              fontFamily: defaultFontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 20,
              color: primaryTextColor),
          headline4: TextStyle(
              fontFamily: defaultFontFamily,
              fontWeight: FontWeight.w700,
              color: primaryTextColor,
              fontSize: 24),
          subtitle1: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            fontWeight: FontWeight.w200,
            fontSize: 18,
          ),
          subtitle2: TextStyle(
            fontFamily: defaultFontFamily,
            color: primaryTextColor,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
          bodyText1: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.w400,
            color: primaryTextColor,
            fontSize: 14,
          ),
          bodyText2: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            fontSize: 12,
          ),
          caption: TextStyle(
              fontFamily: defaultFontFamily,
              color: const Color(0xff7B8BB2),
              fontSize: 10,
              fontWeight: FontWeight.w800),
        ),
      ),
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

  static const String register = "/register";

  static const String list = "/list";

  static const String postInfo = "/postInfo";

  static const String image_show = "/image_show";

  static const String topic = "/topic";

  static const String animalInfo = "/animalInfo";

  static const String userInfo = "/userInfo";

  static const String search = "/search";

  static const String mineList = "/mineList";

  static const String addAnimal = "/addAnimal";

  static const String chat = "/chat";

  ///别名映射页面
  static final List<GetPage> getPages = [
    GetPage(name: main, page: () => MainPage()),
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: login, page: () =>LoginPage()),
    GetPage(name: list, page: ()=>ListPage()),
    GetPage(name: postInfo, page: ()=>ReadPage()),
    GetPage(name: image_show, page: ()=>Image_showPage()),
    GetPage(name: topic, page: ()=>TopicPage()),
    GetPage(name: animalInfo, page: ()=>ReadAnimalPage()),
    GetPage(name: userInfo, page: ()=>ReadUserPage()),
    GetPage(name: search, page: ()=>SearchPage()),
    GetPage(name: register, page: ()=>RegisterPage()),
    GetPage(name: mineList, page: ()=>MineListPage()),
    GetPage(name: addAnimal, page: ()=>AddAnimalPage()),
    GetPage(name: chat, page: ()=>ChatPage()),
  ];
}
