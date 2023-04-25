import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/widgets/loading.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../common/MyIcon.dart';
import '../../common/Util.dart';
import '../../models/base_bean.dart';
import '../../models/comments.dart';
import '../../models/concern.dart';
import '../../models/post.dart';
import '../../widgets/post_list_view.dart';
import 'logic.dart';

class MineListPage extends StatelessWidget {
  MineListPage({Key? key}) : super(key: key);

  final logic = Get.put(MineListLogic());
  final state = Get.find<MineListLogic>().state;

  @override
  Widget build(BuildContext context) {
    String? index = Get.parameters['index'];
    return Scaffold(
      appBar: AppBar(title: Builder(builder: (bu){
        switch(index){
          case '0':return Text('我的点赞');
          case '1':return Text('我的评论');
          case '2':return Text('我的收藏');
          case '3':return Text('我的关注');
          case '4':return Text('我的粉丝 ');
          case '5':return Text('我的动态 ');
        }
        return Text("");
      },),),
      body: Builder(builder: (bu){
        switch(index){
          case '0':return MyLike("点赞");
          case '1':return MyComments();
          case '2':return MyLike("收藏");
          case '3':return MyConcern("关注");
          case '4':return MyConcern("粉丝");
          case '5':return MyPost();
        }
        return Text("");
      },),
    );
  }
}


class MyLike extends StatefulWidget{
  MyLike(this.title);
  String title;
  @override
  State<StatefulWidget> createState() {
    return MyLikeState(title);
  }
}
class MyLikeState extends State<MyLike>{
  String title;
  MyLikeState(this.title);

  List<Like> list=[];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(itemBuilder: (context,index){
        return GestureDetector(
          onTap: (){
            Get.toNamed("/postInfo?id="+list[index].pid.toString());
          },
          child: Container(
            margin: EdgeInsets.all(5),
            child: Text.rich(TextSpan(
                children: [
                  TextSpan(text: title+":"),
                  TextSpan(text: list[index].appPost!.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.black)),
                ]
            )),
          ),
        );
      },itemCount: list.length,),
    );
  }

  @override
  void initState() {
    Git.getList<Like>(title=="点赞"?API.like:API.collection,data: {'uid':Global.profile.value.userLogin!.sysUser!.userId}).then((value){
      list=value.rows!;
      setState(() {
      });
    });
  }
}

class ListItem extends StatelessWidget{

  ListItem(this.comments);

  Comments comments;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: comments.toId==null?10:25,bottom: 25,right: 10),
      child: GestureDetector(
        onTap: (){Get.toNamed("/postInfo?id="+comments.pid.toString());},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipOval(child: Image.network(Util.getStartImageUrl(comments.user!.avatar!),width: 50,height: 50,fit: BoxFit.cover,)),
                SizedBox(width: 10,),
                Text(comments.user!.nickName!)
              ],
            ),
            SizedBox(height: 10,),
            comments.image==null?SizedBox():GestureDetector(
              child: Hero(tag: "image_show",child:Image.network(Util.getStartImageUrl(comments.image!),width: 80,height: 80,fit: BoxFit.cover,),),
              onTap: (){
                Get.toNamed("/image_show",arguments: <String>[Util.getStartImageUrl(comments.image!)]);
              },
            ),
            SizedBox(height: 10,),
            Text(comments.content!),
            SizedBox(height: 10,),
            Row(
              children: [
                GestureDetector(child: Icon(
                  CupertinoIcons.hand_thumbsup,
                  size: 16,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),onTap: (){

                },),
                const SizedBox(width: 4,),
                Text(comments.likeNumber.toString()),
                const SizedBox(width: 10,),
                Icon(
                  CupertinoIcons.clock,
                  size: 16,
                  color: Theme.of(context).textTheme.bodyText2?.color,
                ),
                const SizedBox(width: 4,),
                Text(
                  comments.createDate,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}

class MyComments extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyCommentsState();
  }
}
class MyCommentsState extends State<MyComments>{
  List<Comments> list=[];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(itemBuilder: (context,index){
        return ListItem(list[index]);
      },itemCount: list.length,),
    );
  }

  @override
  void initState() {
    Git.getList<Comments>(API.comments,data: {"uid":Global.profile.value.userLogin!.sysUser!.userId}).then((value){
      list = value.rows!;
      setState(() {

      });
    });

  }
}

class MyConcern extends StatefulWidget{
  String title;
  MyConcern(this.title);
  @override
  State<StatefulWidget> createState() {
    return MyConcernState(title);
  }
}
class MyConcernState extends State<MyConcern>{
  String title;
  List<Concern> list=[];
  MyConcernState(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child:title=='关注'?
      ListView.builder(itemBuilder: (itemBuilder,index){
        Concern concern = list[index];
        String url =  Util.getStartImageUrl(concern.toAid==null?concern.toUserE!.avatar!:concern.appAnimal!.icon!);
        String name = concern.toAid==null?concern.toUserE!.nickName!:concern.appAnimal!.name!;
        String sex = concern.toAid==null?concern.toUserE!.sex!:concern.appAnimal!.sex!.toString();
        return GestureDetector(
          onTap: (){
            concern.toAid==null?
            Get.toNamed("/userInfo?id="+concern.toUserE!.userId.toString()):
            Get.toNamed("/animalInfo?id="+concern.appAnimal!.id.toString());
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.network(url,width: 60,height: 60,fit: BoxFit.cover),),
                SizedBox(width: 5,),
                Text(name,style: TextStyle(fontSize: 18,color: Colors.black),),
                SizedBox(width: 5,),
                Icon(concern.toAid==null?MyIcon.accessibility:MyIcon.dog,color: sex==0?Colors.blue:Colors.pinkAccent,),
              ],
            ),
          ),
        );
      },itemCount: list.length,):
      ListView.builder(itemBuilder: (itemBuilder,index){
        Concern concern = list[index];
        return GestureDetector(
          onTap: (){
            Get.toNamed("/userInfo?id="+concern.sysUserE!.userId.toString());
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(10.0),child: Image.network(Util.getStartImageUrl(concern.sysUserE!.avatar!),width: 60,height: 60,fit: BoxFit.cover),),
                SizedBox(width: 5,),
                Text(concern.sysUserE!.nickName!,style: TextStyle(fontSize: 18,color: Colors.black),),
                SizedBox(width: 5,),
                Icon(MyIcon.accessibility,color: concern.sysUserE!.sex==0?Colors.blue:Colors.pinkAccent,),
              ],
            ),
          ),
        );
      },itemCount: list.length,)


    );
  }

  @override
  void initState() {
    Git.getList<Concern>(API.concern,data: {title=="关注"?"uid":"toUid":Global.profile.value.userLogin!.sysUser!.userId}).then((value){
      list = value.rows!;
      setState(() {

      });
    });
  }


}

class MyPost extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MyPostState();
  }
}
class MyPostState extends State<MyPost>{
  List<Post>? list;

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data);
    list = bean.rows!;
  }

  @override
  Widget build(BuildContext context) {
    return list==null?Loading():Container(
      margin: EdgeInsets.all(0),
      child: CustomScrollView(
        slivers: [
          PostListViewBuilder(posts: list!, withShadow: false,isComplete: false),
        ],
      ),
    );
  }

  @override
  void initState() {
    getPostList(data: {"uid":Global.profile.value.userLogin!.sysUser!.userId}).then((value){
      setState(() {
      });
    });
  }
}
