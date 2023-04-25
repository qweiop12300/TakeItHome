import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/AuthInterceptor.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/sys_user.dart';
import 'package:take_it_home/models/user_e.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'Global.dart';
export 'package:dio/dio.dart' show DioError;

class Git {

  static WebSocketChannel? channel;

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

  static Future<BaseBean<T>> getList<T>(String url,{Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
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

  static Future<BaseBean<T>> getInfo<T>(String url,int id) async{
    Response response;
    BaseBean<T> baseBean;

    response = await Git.getDio().get(url+'/'+id.toString());
    baseBean = BaseBean<T>.fromJson(response.data);
    return baseBean;
  }

  static Future<BaseBean> code(String phone,String code) async{
    Response response;
    BaseBean baseBean;

    response = await Git.getDio().get("/code?phone=${phone}&code=${code}");
    baseBean = BaseBean.fromJson(response.data);
    return baseBean;
  }




  static Future<Response?> retry(RequestOptions requestOptions) async {
    BaseBean<String> baseBean = await Git.login(API.login,Global.profile.value.userLogin?.toJson());
    if(baseBean.code==200){
      var token = baseBean.token;
      requestOptions.headers["Authorization"] = "Bearer "+ token!;

      Global.profile.update((val) {val?.userLogin?.token=token;});
      Global.saveProfile();

      return await dio.fetch(requestOptions);
    }
    return null;
  }

  static Future<BaseBean<String>> login(String url,var data) async{
    Response response;
    response = await Git.getDio().post(url,data: data);
    BaseBean<String> baseBean = BaseBean<String>.fromJson(response.data);
    return baseBean;
  }

  static Future<BaseBean<SysUser>> getUserInfo() async{
    Response response;
    BaseBean<SysUser> baseBean;
    response = await Git.getDio().get(API.userInfo);
    baseBean = BaseBean<SysUser>.fromJson(response.data);
    return baseBean;
  }

  static Future<BaseBean<UserE>> getUserList() async{
    Response response;
    BaseBean<UserE> baseBean;
    response = await Git.getDio().get(API.message+"/userList");
    baseBean = BaseBean<UserE>.fromJson(response.data);
    return baseBean;
  }


  static Future<BaseBean<SysUser>> getUserInfoV2(String userId) async{
    Response response;
    BaseBean<SysUser> baseBean;
    response = await Git.getDio().get(API.userInfoV2+"/"+userId);
    baseBean = BaseBean<SysUser>.fromJson(response.data);
    return baseBean;
  }

  static Future<String?> upload(ImageFile imageFile) async{
    FormData formdata;
    if(imageFile.path!=null){
      formdata = FormData.fromMap({
        "file":
        await MultipartFile.fromFile(
            imageFile.path!,
            filename: imageFile.name
        )
      });
    }else{
      formdata = FormData.fromMap({
        "file":
        await MultipartFile.fromBytes(
          imageFile.bytes!,                                //图片路径
          filename: imageFile.name          //图片名称
        )
      });
    }


    var result = await Git.getDio().post(          //上传结果
      API.upload,
      data: formdata,
    );
    return BaseBean.fromJson(result.data).fileName;
  }

  static Future<Map<String,dynamic>> uploadList(List<ImageFile> files) async{
    List<String> list=[];
    String? video;
    for(int i=0;i<files.length;i++){
      if(files[i].extension=="mp4"){
        video = await upload(files[i]);
      }else{
        list.add((await upload(files[i]))!);
      }
    }
    return {"video":video,"image":list.toString()};
  }


}