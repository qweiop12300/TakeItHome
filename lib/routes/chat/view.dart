import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:take_it_home/widgets/loading.dart';

import 'logic.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends State<ChatPage>{
  final logic = Get.put(ChatLogic());
  final state = Get.find<ChatLogic>().state;

  TextEditingController content = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if(state.myMessage!=null){
      Future.delayed(Duration(milliseconds: 500)).then((value){
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    String? id = Get.parameters['id'];
    return Scaffold(
      appBar: AppBar(title: state.sysUser==null?Text(""):
        Row(
          children: [
            ClipOval(
              child: Image.network(Util.getStartImageUrl(state.sysUser!.avatar),fit: BoxFit.cover,width: 50,height: 50,),
            ),
            SizedBox(width: 5,),
            Text(state.sysUser!.nickName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
      body: state.sysUser==null?Loading():
      Container(
        child: Column(
          children: [
            Expanded(flex:10,child:
              ListView.builder(controller:scrollController,itemBuilder: (context,index){
                Mymessage mymessage = state.myMessage[index];
                return Container(
                  height: 80,
                  padding: EdgeInsets.all(10),
                  child:mymessage.uid==int.parse(id!)?
                  Stack(
                    children: [
                      Positioned(child: GestureDetector(
                        child: ClipOval(
                          child: Image.network(Util.getStartImageUrl(state.sysUser!.avatar),fit: BoxFit.cover,width: 60,height: 60,),
                        ),
                        onTap: (){
                          Get.toNamed("/userInfo?id="+mymessage.uid.toString());
                        },
                      ),left: 0,),
                      Positioned(child: Container(
                        child: Text(mymessage.content!),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color:
                              Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                      ),left: 60,),
                      Positioned(child: Text(mymessage.createDate!),bottom: 0,left: 60,)
                    ],
                  ):
                  Stack(
                    children: [
                      Positioned(child: ClipOval(
                        child: Image.network(Util.getStartImageUrl(Global.profile.value.userLogin!.sysUser!.avatar),fit: BoxFit.cover,width: 60,height: 60,),
                      ),right: 0,),
                      Positioned(child: Container(
                        child: Text(mymessage.content!),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 5,
                              color:
                              Theme.of(context).colorScheme.primary.withOpacity(0.2),
                            )
                          ],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                      ),right: 60,),
                      Positioned(child: Text(mymessage.createDate!),bottom: 0,right: 60,)
                    ],
                  )
                );
            },itemCount: state.myMessage.length,)),
            Expanded(flex:1,child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(flex:5,child:
                    TextField(controller: content,
                        minLines: 1,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "发射",
                        )
                    )
                  ),
                  Expanded(flex:1,child: ElevatedButton(
                    onPressed: (){
                      Mymessage message = Mymessage();
                      var now = new DateTime.now();
                      message..id=null..pid=null..isShow=0..typeId=4..content=content.text..uid=Global.profile.value.userLogin!.sysUser!.userId..toUid=int.parse(id!)..createDate="${now.year.toString()}-${now.month.toString().padLeft(2,'0')}-${now.day.toString().padLeft(2,'0')} ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
                      logic.addMessage(message).then((value){
                        if(value.code==200){
                          state.myMessage.add(message);
                          setState(() {

                          });
                          scrollController.jumpTo(scrollController.position.maxScrollExtent+80);
                        }
                      });
                      content.text="";
                    },
                    child: Icon(Icons.send,),
                  ))
                ],
              ),
            ))
          ],
        )
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    if(callback!=null){
      Global.eventBus.off("newMessage",callback);
      print("object");
    }
  }



  dynamic callback;

  @override
  void initState() {
    String? id = Get.parameters['id'];

    callback = (arg) {
      Mymessage mymessage = arg;
      if((mymessage.uid==int.parse(id!)||mymessage.toUid==int.parse(id))&&mymessage.typeId==4){
        state.myMessage.add(mymessage);
        setState(() {

        });
      }
    };
    Global.eventBus.on("newMessage", callback);

    logic.getUser(id!).then((value){
      Future.wait(
          [
            logic.getMyMessageList(int.parse(id)),
            logic.getToMessageList(int.parse(id))
          ]
      ).then((value){
        logic.sort();
        setState(() {

        });
      });
    });



  }


}
