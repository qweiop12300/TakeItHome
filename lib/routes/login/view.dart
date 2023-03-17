import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Global.dart';

import 'logic.dart';

class LoginPage extends StatelessWidget {
  final logic = Get.put(LoginLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: logic.username,
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "手机号",
                  hintText: "手机号或用户名",
                  prefixIcon: Icon(Icons.person)
              ),
            ),
            TextField(
              controller: logic.password,
              decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock)
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                TextButton(
                  child: Text("忘记密码？"),
                  onPressed: () {
                  },
                ),
              ],
            ),
          Obx((){
            if(logic.isClick.value==1){
              return
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: ElevatedButton(
                    child: Text("登录"),
                    onPressed: () {
                      logic.login();
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