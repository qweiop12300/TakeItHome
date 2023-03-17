import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/video.dart';
import 'package:video_player/video_player.dart';

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
  Widget build(BuildContext context) {
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
             child: Column(
               children: [
                 IconButton(onPressed: (){

                 }, icon:Image.asset("imgs/dianzan.png")),
                 Text(post.likeNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                 SizedBox(
                   height: 20,
                 ),
                 IconButton(onPressed: (){

                 }, icon: Image.asset("imgs/pinglun.png")),
                 Text(post.commentsNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                 SizedBox(
                   height: 20,
                 ),
                 IconButton(onPressed: (){

                 }, icon: Image.asset("imgs/shoucang.png")),
                 Text(post.collectionNumber!.toString(),style: TextStyle(color: Colors.white,fontSize: 18),),
                 SizedBox(
                   height: 20,
                 ),
               ],
             ),
             onTap: (){

             },
            )
          )
        ],
      );

  }

}
