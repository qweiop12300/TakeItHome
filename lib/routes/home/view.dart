import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/routes/pages/home_view/view.dart';
import 'package:take_it_home/routes/pages/mine_view/view.dart';
import 'logic.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin{
  final logic = Get.put(HomeLogic());
  final state = Get.find<HomeLogic>().state;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("带它回家"),
          ),
          body:Obx((){
            return state.page[state.index.value]!;
          }),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {logic.change(0);}),
            IconButton(icon: Icon(Icons.videocam), onPressed: () {logic.change(1);}),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.message), onPressed: () {
              if(Global.isLogin()){
                logic.change(2);
              }else{
                Get.toNamed("/login");
              }
            }),
            IconButton(icon: Icon(Icons.account_box), onPressed: () {
              if(Global.isLogin()){
                logic.change(3);
              }else{
                Get.toNamed("/login");
              }
            }),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add)),
    );

  }

  @override
  void initState() {
  }
}
