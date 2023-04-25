import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';

import 'logic.dart';

class RegisterPage extends StatelessWidget {
  final logic = Get.put(RegisterLogic());

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController code = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? phone = Get.parameters['phone'];
    if(phone!=null){
      username.text=phone;
    }
    return Scaffold(
      appBar: AppBar(title: Text("注册"),),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: username,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "手机号",
                  hintText: "手机号或用户名",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: password,
              autofocus: true,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "密码",
                  prefixIcon: Icon(Icons.lock)
              ),
            ),
            Obx((){
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: TextField(
                      controller: code,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "验证码",
                          hintText: "验证码",
                          prefixIcon: Icon(Icons.lock)
                      ),
                    ),
                    width: 150,
                  ),
                  logic.yzm==61?
                  GestureDetector(
                    child: ElevatedButton(
                      onPressed: () {
                        logic.startTime(username.text,password.text);
                      },
                      child: Text("发送验证码",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                    ),
                  ):Text(logic.yzm.toString()+"s",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                ],
              );
            }),
            Obx((){
              if(logic.zcClick==1){
                return
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: ElevatedButton(
                        child: Text("注册"),
                        onPressed: () {
                          logic.zcClick.update((val) {val=0;});
                          logic.code(username.text, code.text).then((value){
                            if(value.code==500){
                              FlutterToastr.show("注册成功", context);
                              Get.back(result: {"phone":username.text,"password":password.text});
                            }else{
                              FlutterToastr.show("注册失败", context);
                            }
                          });
                        },
                      )
                  );
              }else{
                return CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );
              }
            }
            )
          ],
        ),
      ),
    );
  }
}
