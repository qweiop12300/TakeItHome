import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/VO/user_login.dart';
import '../../models/base_bean.dart';
import '../../models/sys_user.dart';


class LoginLogic extends GetxController {

  var isClick = 1.obs;

  TextEditingController username = TextEditingController(text: Global.profile.value.userLogin?.username);
  TextEditingController password = TextEditingController(text: Global.profile.value.userLogin?.password);


  Future<void> login(context) async {
    isClick.value=0;
    UserLogin userLogin = UserLogin();
    BaseBean<String> baseBean = await Git.login(API.login,(userLogin..username=this.username.text..password=this.password.text).toJson());
    isClick.value=1;
    if(baseBean.code==200){
      userLogin..token=baseBean.token;
      Global.profile.update((profile) {
        profile?.userLogin = userLogin;
        profile?.isLogin = true;
      });
      Global.saveProfile();

      BaseBean<SysUser> bean = await Git.getUserInfo();
      Global.profile.update((val) {val?.userLogin?.sysUser=bean.data;});
      Global.saveProfile();

      Get.offAllNamed("/home");
    }else{
      FlutterToastr.show("登录失败", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);
    }
    // if(loginResultEntity.token!=null){

    // }else{

    // }
  }
}
