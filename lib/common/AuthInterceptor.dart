
import 'package:dio/dio.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';

import '../models/base_bean.dart';

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
    if(baseBean.token==401){
      Response? res = await Git.retry(response.requestOptions);
      if(res!=null){
        handler.next(res);
      }
    }
    else{
      handler.next(response);
    }
  }


}