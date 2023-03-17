import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/VO/user_login.dart';
import '../../models/base_bean.dart';


class LoginLogic extends GetxController {

  var isClick = 1.obs;

  TextEditingController username = TextEditingController(text: Global.profile.value.userLogin?.username);
  TextEditingController password = TextEditingController(text: Global.profile.value.userLogin?.password);


  Future<void> login() async {
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
      Get.offAllNamed("/home");
    }else{
        Fluttertoast.showToast(
            msg: "登录失败",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
    }
    // if(loginResultEntity.token!=null){

    // }else{

    // }
  }
}
