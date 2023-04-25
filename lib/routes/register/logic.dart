import 'dart:async';

import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/base_bean.dart';

import '../../common/API.dart';

class RegisterLogic extends GetxController {

  RxInt yzm = 61.obs;

  RxInt zcClick = 1.obs;

  startTime(String phone,String password){
    if(password!=""&&phone!=""){
      register(phone, password).then((value){
        if(value.code==200){
          yzm--;
          Timer.periodic(
              Duration(milliseconds: 1000),(timer){
            yzm--;
            if(yzm==-1){
              yzm.update((val) {
                val=61;
                timer.cancel();
              });
            }
          }
          );
        }
      });
    }
  }

  Future<BaseBean> register(String name,String password) async {
    BaseBean baseBean = await Git.add(API.register,{"username":name,"password":password});
    return baseBean;
  }

  Future<BaseBean> code(String name,String code) async {
    BaseBean baseBean = await Git.code(name, code);
    return baseBean;
  }



}
