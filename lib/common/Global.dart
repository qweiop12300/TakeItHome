import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting/my_setting.dart';
import 'Git.dart';

// 提供五套可选主题色
const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {

  static late SharedPreferences _prefs;
  static late Rx<MySetting> profile;
  // 网络缓存对象

  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool isLogin(){
    if(profile.value!=null&&profile.value.userLogin!=null&&profile.value.userLogin!.token!=null){
      return true;
    }
    return false;
  }

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = MySetting.fromJson(jsonDecode(_profile)).obs;
        print("object");
      } catch (e) {
        print(e);
      }
    }else{
      // 默认主题索引为0，代表蓝色
      profile= (MySetting()..theme=0).obs;
      saveProfile();
    }
    //初始化网络请求相关配置
    Git.init();
  }

  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}

