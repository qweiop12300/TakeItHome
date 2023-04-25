
import 'dart:convert';

import 'package:dart_vlc/channel.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as Get;
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/base_bean.dart';
import 'API.dart';

class AuthInterceptor extends Interceptor {
  @override
  onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // 从本地缓存中取出 Token
    var token = Global.profile.value.userLogin?.token;
    if(token!=null){
      options.headers["Authorization"] = "Bearer "+ token;
    }
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {

    BaseBean<String> baseBean = BaseBean<String>.fromJson(response.data);
    if(baseBean.code==401){
      if(response.requestOptions.headers.containsKey("Authorization")==null){
        Get.Get.toNamed("/login");
      }else{
        Response? res = await Git.retry(response.requestOptions);
        if(res!=null){
          handler.next(res);
        }
      }
    }
    else{
      if(Git.channel==null){
        if(response.requestOptions.headers["Authorization"]!=null){
          var host = API.url.split('/')[API.url.split('/').length-1];
          final wsUrl = Uri.parse('ws://'+host+'/webSocket/'+(response.requestOptions.headers["Authorization"] as String).split(' ')[1]);
          Git.channel = WebSocketChannel.connect(wsUrl);
          Git.channel!.stream.listen((event) {
            Map<String, dynamic> jsonMap = json.decode(event);
            BaseBean<Mymessage> bean = BaseBean<Mymessage>.fromJson(jsonMap);
            if(bean.code==201){
              Global.eventBus.emit("newMessage",bean.data);
            }
            if(baseBean.code==200){
              print("连接成功");
              Global.eventBus.emit("socketNone");
            }
          });
        }

      }
      handler.next(response);
    }
  }


}