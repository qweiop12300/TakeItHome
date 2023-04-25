

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'API.dart';

class  Util{

  static List<String> splitStringToMap(String str){
    if(str=="[]"){
      return [];
    }
    List<String> list = str.split('[')[1].split(']')[0].split(', ');
    List<String> result = [];
    list.forEach((element) {
      result.add(getStartImageUrl(element));
    });
    return result;
  }

  static String getStartImageUrl(String url){
    if(url.isNotEmpty&&url!=""){
      if(url[0]=='/'){
        return API.url+url;
      }
      return url;
    }
    return "https://via.placeholder.com/800x1000";
  }

  static List<String> getImageUrlList(String url){
    return splitStringToMap(url);
  }

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  static Map<String,dynamic> deptIdtoMap(int deptId,int uid,{Map<String,dynamic>? data}){
    Map<String,dynamic> map = Map();
    if(data!=null)map.addAll(data);
    switch(deptId%110){
      case 0:
        map.addAll({"bid":uid});
      break;
      case 1:
        map.addAll({"uid":uid});
      break;
      case 2:
        map.addAll({"hid":uid});
      break;
    }
    return map;
  }
}