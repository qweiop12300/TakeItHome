import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Global.dart';

import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'logic.dart';
class MineViewPage extends StatefulWidget {

  const MineViewPage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return MineViewPageState();
  }
}
class MineViewPageState extends State<MineViewPage>{
  final logic = Get.put(MineViewLogic());
  final state = Get.find<MineViewLogic>().state;

  @override
  void initState() {

    logic.getUserInfo().then((value) => {
      logic.getNum((){setState(() {});}),
      Future.wait(
        [
          logic.getAnimalState(data: {"uid":state.sysUser.userId}),
          logic.getAnimalState(data: {"hid":state.sysUser.userId}),
          logic.getAnimalState(data: {"bid":state.sysUser.userId}),]
      ).then((value){

        setState((){
          state.isLoading=false;
        });
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return state.isLoading?Loading()
        :SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: Row(
                children: [
                  ClipOval(child: Image.network(Util.getStartImageUrl(state.sysUser.avatar),width: 70,height: 70,fit: BoxFit.cover,),),
                  SizedBox(width: 10,),
                  Column(children: [
                    Text(state.sysUser.nickName,style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold),),
                    Text(state.sysUser.userData.desc==null?"":state.sysUser.userData.desc)
                  ],)
                ],),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              child: Stack(
                children: [
                  Text("你的宠物",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                  state.animalStatelist.length==0?Text("")
                      :Positioned(
                      right: 0,
                      bottom: 0,
                      child: TextButton(
                        child: Text("添加宠物",style: TextStyle(fontWeight: FontWeight.bold),),
                        onPressed: () {
                          Get.toNamed("/addAnimal");
                        },
                      ))
                ],
              )
            ),
            Container(
                height: state.animalStatelist.length==0?50:300,
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 10,
                      color: Color(0x1a5282FF),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child:state.animalStatelist.length==0?
                ElevatedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("去领养/添加宝贝",style: TextStyle(fontSize: 15),),
                  onPressed: (){
                    Get.toNamed("/addAnimal");
                  },
                ):
                Swiper(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Get.toNamed("/animalInfo?id="+state.animalStatelist[index].appAnimal!.id.toString());
                      },
                      child: Stack(
                        children: [
                          Positioned(child: ClipRRect( //剪裁为圆角矩形
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(Util.getStartImageUrl(state.animalStatelist[index].appAnimal!.icon!),fit: BoxFit.cover,alignment: Alignment.center,),
                          ),left: 0,right: 0,top: 0,bottom: 0,),
                          Positioned(child: Text(state.animalStatelist[index].appAnimal!.name!,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold),),left: 15,top: 15,)
                        ],
                      ),
                    );
                  },
                  itemCount: state.animalStatelist.length,
                  itemWidth: double.infinity,
                  itemHeight: double.infinity,
                  autoplay: true,
                  layout: SwiperLayout.DEFAULT,
                )
            ),
            Container(
              height: 60,
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  const BoxShadow(
                    blurRadius: 10,
                    color: Color(0x1a5282FF),
                  )
                ],
                borderRadius: BorderRadius.circular(16),
              ),
                child: Flex(
                  direction: Axis.horizontal,
                children: [
                  Expanded(flex: 1,child: GestureDetector(
                    onTap: (){
                      Get.toNamed("/mineList?index=5");
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.num1.toString(),style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                        Text("动态",)
                      ],
                    ),
                  )),
                  Expanded(flex:1,child: GestureDetector(
                    onTap: (){Get.toNamed("/mineList?index=3");},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.num2.toString(),style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                        Text("关注")
                      ],
                    ),
                  )),
                  Expanded(flex:1,child: GestureDetector(
                    onTap: (){Get.toNamed("/mineList?index=4");},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.num3.toString(),style: TextStyle(color: Colors.black,fontSize: 17,fontWeight: FontWeight.bold)),
                        Text("粉丝")
                      ],
                    ),
                  ))
                ],
              )
            ),

            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 10,
                      color: Color(0x1a5282FF),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(children: [
                            Image.asset("assets/img/icons/Google.png",width: 50,height: 50,),
                            SizedBox(height: 5,),
                            Text("我的动态",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                          ],),
                          onTap: (){
                          Get.toNamed("/mineList?index=5");
                          },
                        ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(children: [
                          Image.asset("assets/img/icons/Google.png",width: 50,height: 50,),
                          SizedBox(height: 5,),
                          Text("我的评论",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                        ],),
                        onTap: (){
                          Get.toNamed("/mineList?index=1");
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(children: [
                          Image.asset("assets/img/icons/Google.png",width: 50,height: 50,),
                          SizedBox(height: 5,),
                          Text("我的收藏",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                        ],),
                        onTap: (){
                          Get.toNamed("/mineList?index=2");
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        child: Column(children: [
                          Image.asset("assets/img/icons/Google.png",width: 50,height: 50,),
                          SizedBox(height: 5,),
                          Text("我的点赞",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                        ],),
                        onTap: (){
                          Get.toNamed("/mineList?index=0");
                        },
                      ),
                    ),
                  ],
                )
            ),
            Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 8),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 10,
                      color: Color(0x1a5282FF),
                    )
                  ],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.terrain_outlined,size: 30,),
                          SizedBox(width: 10,),
                          Text("设置",style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                      onTap: (){

                      },
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.terrain_outlined,size: 30,),
                          SizedBox(width: 10,),
                          Text("关于",style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Icon(Icons.terrain_outlined,size: 30,),
                          SizedBox(width: 10,),
                          Text("退出登录",style: TextStyle(fontSize: 20,color: Colors.black),)
                        ],
                      ),
                      onTap: (){
                        CommentsView.showCupertinoAlertDialog(context, "是否退出登录?", "", (code){
                          if(code==0){
                            Global.profile.update((val) {val!.userLogin=null;});
                            Global.saveProfile();
                            Get.offAllNamed("/");
                          }
                        });
                      },
                    ),
                  ],
                )
            ),

          ],
        ),
      ),
    );
  }
}
