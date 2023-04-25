import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/post_list_view.dart';

import '../../common/API.dart';
import '../../models/like.dart';
import '../../models/post.dart';
import '../../widgets/my_notification.dart';
import 'logic.dart';

class TopicPage extends StatefulWidget {
  TopicPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TopicPageState();
  }
}

class TopicPageState extends State<TopicPage>{
  final logic = Get.put(TopicLogic());
  final state = Get.find<TopicLogic>().state;

  @override
  Widget build(BuildContext context) {
    return
      NotificationListener<MyNotification>(
        onNotification: (myNotification){
      switch(myNotification.type){
        case NotificationType.postLike:
          Post post = myNotification.post!;
          logic.add(API.like, post.id!).then((value) => {
            if(value?.code==200){
              post..isLike=Like()..likeNumber = post.likeNumber!+1
            }else{
              post..isLike=null..likeNumber = post.likeNumber!-1
            }, logic.update()
          });
          break;
        case NotificationType.postCollection:
          Post post = myNotification.post!;
          logic.add(API.collection, post.id!).then((value) => {
            if(value?.code==200){
              post..isCollection=Like()..collectionNumber = post.collectionNumber!+1
            }else{
              post..isCollection=null..collectionNumber = post.collectionNumber!-1
            }, logic.update()
          });
          break;
      }
      return true;
    },
      child:
      Scaffold(
        appBar: AppBar(title: Text("话题"),),
        body: state.postList==null?Loading():
        Stack(
          children: [
            Positioned(
                child:Image.network(Util.getStartImageUrl(state.topic!.image!),fit: BoxFit.cover,height: 200,width: double.infinity,)),
            Positioned(
              child: GetBuilder<TopicLogic>(
              builder: (builder){
                return CustomScrollView(
                  slivers: <Widget>[
                    PostListViewBuilder(posts: state.postList!, withShadow: false,isComplete: false),
                  ],
                );
              },
            ),)
          ],
        )
    )
      );
  }

  @override
  void initState() {
    String? id = Get.parameters['id'];
    logic.getPostList(data: {"tid":id}).then((value){
      logic.getInfo(id!).then((value) => setState(() {}));
    });
  }
}
