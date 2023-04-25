import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/widgets/VideoPlayerBean.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';
import '../../../models/concern.dart';
import 'logic.dart';
import 'package:take_it_home/widgets/VideoPlayer.dart'
if(dart.library.html) 'package:take_it_home/widgets/VideoPlayerAndroid.dart'
if(dart.library.io) 'package:take_it_home/widgets/VideoPlayerWindows.dart';

class VideoViewPage extends StatefulWidget {

  const VideoViewPage({Key? key}) : super(key: key);

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
      state.url = Util.getStartImageUrl(logic.state.postList[0].video),
      setState((){
        state.isLoading=false;
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return state.isLoading?Loading():
    PageView.builder(
        scrollDirection:Axis.vertical,
        pageSnapping:true,
        itemCount: state.postList.length,
        onPageChanged: (index){
          // state.url = Util.getStartImageUrl(state.postList[index].video);
          // setState(() {
          //
          // });
        },
        itemBuilder: (context,index){
          return ListItem(state.postList[index]);
        });
  }

}

class ListItem extends StatelessWidget{
  late Post post;
  ListItem(this.post);

  like(context){
    context.add(API.like,post.id!).then((value) => {
      if(value?.code==200){
        post..isLike=Like()..likeNumber = post.likeNumber!+1
      }else{
        post..isLike=null..likeNumber = post.likeNumber!-1
      },context.update()
    });
  }

  @override
  Widget build(BuildContext buildContext) {
    return
      Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child:GetBuilder<VideoViewLogic>(builder: (logic){
              return GestureDetector(
                child: VideoPlayer(url:Util.getStartImageUrl(post.video))
              );
            },)
          ),
          Positioned(
            bottom: 20,
            right: 20,
            width: 50,
            child: GetBuilder<VideoViewLogic>(builder: (context){
               return Column(
                 children: [
                   IconButton(onPressed: (){
                      like(context);
                   }, icon: Icon(size:28,color:Colors.white,post.isLike==null?CupertinoIcons.hand_thumbsup:CupertinoIcons.hand_thumbsup_fill)
                   ),
                   Text(post.likeNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                   IconButton(onPressed: (){Get.toNamed("/postInfo?id="+post.id!.toString());}, icon: Icon(size:28,color:Colors.white,CupertinoIcons.bubble_middle_bottom)),
                   Text(post.commentsNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                   IconButton(onPressed: (){
                     context.add(API.collection,post.id!).then((value) => {
                       if(value?.code==200){
                         post..isCollection=Like()..collectionNumber = post.collectionNumber!+1
                       }else{
                         post..isCollection=null..collectionNumber = post.collectionNumber!-1
                       },context.update()
                     });
                   }, icon: Icon(size:28,color:Colors.white,post.isCollection==null?CupertinoIcons.bookmark:CupertinoIcons.bookmark_fill)),
                   Text(post.collectionNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                 ],
               );
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
                        child: IconButton(onPressed: (){}, icon: Image.network(Util.getStartImageUrl(post.user!.avatar!))),
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
