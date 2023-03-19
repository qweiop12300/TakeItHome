import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/video.dart';
import '../../../models/concern.dart';
import 'logic.dart';

class VideoViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VideoViewSate();
  }
}
class VideoViewSate extends State<VideoViewPage>{
  final logic = Get.put(VideoViewLogic());
  final state = Get.find<VideoViewLogic>().state;

  @override
  void initState() {
    logic.getPostList().then((value) => {
      setState((){
        state.isLoading=false;


      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return state.isLoading?Loading():PageView.builder(
        scrollDirection:Axis.vertical,
        pageSnapping:true,
        itemCount: state.postList.length,
        itemBuilder: (context,index){
      return ListItem(state.postList[index]);
    });
  }

}

class ListItem extends StatelessWidget{
  late Post post;
  ListItem(this.post);

  @override
  Widget build(BuildContext buildContext) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child:VideoView(Util.getImageUrl(post.video))
          ),
          Positioned(
            bottom: 20,
            right: 20,
            width: 50,
            child:
            GestureDetector(
             child: GetBuilder<VideoViewLogic>(builder: (context){
               return Column(
                 children: [
                   IconButton(onPressed: (){
                      context.add(API.like,post.id!).then((value) => {
                        if(value?.code==200){
                          post..isLike=Like()..likeNumber = post.likeNumber!+1
                        }else{
                          post..isLike=null..likeNumber = post.likeNumber!-1
                        },context.update()
                      });
                   }, icon: post.isLike==null?Image.asset("imgs/dianzan.png"):Image.asset("imgs/dianzan_1.png")),
                   Text(post.likeNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                   IconButton(onPressed: (){CommentsView.showBottomView(buildContext);}, icon: Image.asset("imgs/pinglun.png")),
                   Text(post.commentsNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                   IconButton(onPressed: (){
                     context.add(API.collection,post.id!).then((value) => {
                       if(value?.code==200){
                         post..isCollection=Like()..collectionNumber = post.collectionNumber!+1
                       }else{
                         post..isCollection=null..collectionNumber = post.collectionNumber!-1
                       },context.update()
                     });
                   }, icon: post.isCollection==null?Image.asset("imgs/shoucang.png"):Image.asset("imgs/shoucang_1.png")),
                   Text(post.collectionNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                 ],
               );
             },),
             onTap: (){

             },
            )
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height:60,
                        width: 60,
                        child: IconButton(onPressed: (){}, icon: Image.network(Util.getImageUrl(post.user!.avatar!))),
                      ),
                      SizedBox(width: 10,),
                      Text(post.user!.nickName!,style: TextStyle(color: Colors.white),),
                      SizedBox(width: 5,),
                      GetBuilder<VideoViewLogic>(builder: (builder){
                        return ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(primary: post.isConcern==null?Colors.blue:Colors.black12),
                          icon: post.isConcern==null?Icon(Icons.add,size: 18,):Icon(Icons.expand_circle_down_outlined),
                          label: post.isConcern==null?Text("关注",style: TextStyle(fontSize: 18),):Text("已关注",style: TextStyle(fontSize: 18),),
                          onPressed: (){
                            builder.concern(API.concern, post.user!.userId!).then((value) =>{
                              if(value?.code==200){
                                post.isConcern=Concern()
                              }else{
                                post.isConcern=null
                              },
                              builder.update()
                            });
                          },);
                      })
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(width: 15,),
                      Text(post.title!,style: TextStyle(color: Colors.white),)
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              )
          )
        ],
      );
  }
}
