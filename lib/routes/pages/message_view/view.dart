import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/user_e.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/widgetUtil.dart';

import 'logic.dart';

class MessageViewPage extends StatefulWidget {

  const MessageViewPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MessageViewPageState();
  }
}
class MessageViewPageState extends State<MessageViewPage>{
  final logic = Get.put(MessageViewLogic());
  final state = Get.find<MessageViewLogic>().state;

  @override
  void initState() {
    logic.getUserList().then((value){
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return state.userList==null?Loading():
    Container(
      padding: EdgeInsets.all(10),
      child: ListView.builder(itemBuilder: (context,index){
        UserE userE = state.userList![index];
        return GestureDetector(
          onTap: (){
            Get.toNamed("/chat?id="+state.userList![index].userId.toString());
          },
          child: Container(
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
            padding: EdgeInsets.all(5),
            child: WidgetUtil.getUserWidget(state.userList![index])
          ),
        );
      },itemCount: state.userList!.length,),
    );
  }
}
