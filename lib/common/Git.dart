import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/AuthInterceptor.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'Global.dart';
export 'package:dio/dio.dart' show DioError;

class Git {

  // 在网络请求过程中可能会需要使用当前的context信息，比如在请求失败时
  // 打开一个新路由，而打开新路由需要context信息。
  Git([this.context]) {
    _options = Options(extra: {"context": context});
  }

  BuildContext? context;

  late Options _options;

  static Dio dio = new Dio(BaseOptions(
    baseUrl: API.url,
  ));

  static void init() {
    dio.interceptors..add(AuthInterceptor());
  }

  static Dio getDio(){
    return dio;
  }

  static Future<BaseBean<T>> getList<T>(String url,[Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    Response response;
    BaseBean<T> baseBean;
    if (pageSize==null)pageSize=20;
    if (pageNum==null)pageNum=1;
    Map<String,dynamic> map = Map<String,dynamic>();
    map["pageNum"] = pageNum;
    map["pageSize"] = pageSize;

    if(data!=null){
      map.addAll(data);
    }

    response = await Git.getDio().get(url+"/list",queryParameters: map);
    baseBean = BaseBean<T>.fromJson(response.data);

    return baseBean;
  }

  static Future<BaseBean> add(String url,Map<String,dynamic> data) async{
    Response response;
    BaseBean baseBean;

    response = await Git.getDio().post(url,data: data);
    baseBean = BaseBean.fromJson(response.data);
    return baseBean;
  }

  static Future<BaseBean<String>> login(String url,var data) async{
    Response response;
    response = await Git.getDio().post(url,data: data);
    BaseBean<String> baseBean = BaseBean<String>.fromJson(response.data);
    return baseBean;
  }

  static Future<Response?> retry(RequestOptions requestOptions) async {
    BaseBean<String> baseBean = await Git.login(API.login,Global.profile.value.userLogin?.toJson());
    if(baseBean.code==200){
      var token = baseBean.token;
      Global.profile.update((val) {val?.userLogin?.token=token;});
      Global.saveProfile();
      requestOptions.headers["Authorization"] = "Bearer "+ token!;
      return await dio.fetch(requestOptions);
    }
    return null;
  }



}