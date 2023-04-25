import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/generated/fonts.gen.dart';
import 'package:take_it_home/models/comments.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/my_notification.dart';
import 'package:take_it_home/widgets/widgetUtil.dart';

import 'logic.dart';

import 'package:take_it_home/widgets/VideoPlayer.dart'
if(dart.library.html) 'package:take_it_home/widgets/VideoPlayerAndroid.dart'
if(dart.library.io) 'package:take_it_home/widgets/VideoPlayerWindows.dart';

class ReadPage extends StatefulWidget {
  ReadPage({Key? key}) : super(key: key);

  @override
  State createState() {
    return ReadPageState();
  }
}

class ReadPageState extends State<ReadPage>{

  final logic = Get.put(ReadLogic());
  final state = Get.find<ReadLogic>().state;


  @override
  void initState() {
    String? id = Get.parameters['id'];
    if(id==null){
      Util.showSnackBar(context, "错误");
    }else{
      logic.getInfo(id).then((value) => {
        logic.getComments(id).then((value){
          setState((){
            state.isLoading=false;
          });
        })
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return state.isLoading?Scaffold(appBar: AppBar(), body: Loading(),)
        :NotificationListener<MyNotification>(
        onNotification: (notification){
          switch(notification.type){
            case NotificationType.postComments:
              if(notification.comments!=null){

              }
          }
          return true;
        },
        child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            CommentsView.showComments(context,(content,url){
              Comments comments = Comments();
              comments..image=url..content=content..pid=state.post.id;
              Git.add(API.comments, comments.toJson()).then((value){
                if(value.code==200){
                  FlutterToastr.show("发射成功", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);
                  logic.getComments(state.post.id.toString());
                }
              });
            });
          },
          child: Container(
            width: 100,
            height: 48,
            decoration: BoxDecoration(
              color: themeData.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: themeData.colorScheme.primary.withOpacity(0.5))
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '评论',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: FontFamily.avenir,
                    fontWeight: FontWeight.w400,
                    color: themeData.colorScheme.onPrimary,
                  ),
                )
              ],
            ),
          ),
        ),
        backgroundColor: themeData.colorScheme.surface,
        body: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  // pinned: true,
                  // floating: true,
                  title: Text(
                    '详情',
                    style: themeData.textTheme.headline4,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Util.showSnackBar(context, 'on More is Clicked');
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                    const SizedBox(
                      width: 16,
                    )
                  ],
                ),
                SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
                            child: Text(
                              state.post.title!,
                              style: themeData.textTheme.headline4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 0, 16, 32),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(Util.getStartImageUrl(state.post.user!.avatar!),height: 48, width: 48, fit: BoxFit.cover),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.post.user!.nickName!,
                                        style: themeData.textTheme.bodyText1!
                                            .copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: themeData
                                                .colorScheme.onSecondary),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        state.post.user!.remark==null?"":state.post.user!.remark!,
                                        style: themeData.textTheme.bodyText2?.apply(
                                          color: const Color(0xff7B8BB2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.share,
                                    color: themeData.colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    Util.showSnackBar(context, API.url+"/postInfo?id="+state.post.id.toString());
                                  },
                                ),
                                IconButton(
                                  icon: Icon(
                                    CupertinoIcons.bookmark,
                                    color: themeData.colorScheme.primary,
                                  ),
                                  onPressed: () {
                                    Util.showSnackBar(context, 'on Bookmark is Clicked');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Builder(builder: (builder){
                            List<String> list = Util.getImageUrlList(state.post.image);
                            if(list.length!=0||state.post.video!=null){
                              return Container(
                                height: 300,
                                child: Hero(tag: "image_show", child:
                                  Swiper(
                                    pagination: SwiperPagination(),
                                    control: SwiperControl(),
                                    itemBuilder: (context, index) {
                                      if(index==0&&state.post.video!=null){
                                        return GestureDetector(
                                          child: VideoPlayer( url: Util.getStartImageUrl(state.post.video)),
                                          onTap: (){Get.toNamed("/image_show",arguments: list);},
                                        );
                                      }else if(state.post.video!=null){
                                        return GestureDetector(
                                          child: Image.network(list[index-1],fit: BoxFit.cover,),
                                          onTap: (){Get.toNamed("/image_show",arguments: list);},
                                        );
                                      }
                                      return GestureDetector(
                                        child: Image.network(list[index],fit: BoxFit.cover,),
                                        onTap: (){Get.toNamed("/image_show",arguments: list);},
                                      );
                                    },
                                    itemCount: state.post.video!=null?list.length+1:list.length,
                                    viewportFraction: 0.99,
                                    scale: 0.99,
                                    autoplay: state.post.video!=null?false:true,
                                  )
                                ),
                              );
                            }
                            return SizedBox();
                          }),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                            child: Text(
                              state.post.content!,
                              style: themeData.textTheme.bodyText2
                                  ?.copyWith(fontSize: 14),
                            ),
                          ),
                          state.post.aid!=null?Padding(
                            padding: const EdgeInsets.fromLTRB(32, 10, 32, 10),
                            child: GestureDetector(
                              child: Column(
                                children: [
                                  ClipOval(child: Image.network(Util.getStartImageUrl(state.post.appAnimal!.icon!,),width: 60,height: 60,fit: BoxFit.cover,),),
                                ],
                              ),
                              onTap: (){
                                Get.toNamed("/animalInfo?id="+state.post.appAnimal!.id.toString());
                              },
                            ),):SizedBox(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text("评论区",style: TextStyle(fontSize: 10,color: Colors.black),),
                          ),
                        ],
                      ),
                    ])),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context,index){
                    return GestureDetector(
                      child: ListItem(state.commentsList[index]),
                      onTap: (){
                        CommentsView.showComments(context,(content,url){
                          Comments comments = Comments();
                          comments..image=url..content=content..pid=state.post.id..toId=state.commentsList[index].id;
                          Git.add(API.comments, comments.toJson()).then((value){
                            if(value.code==200){
                              FlutterToastr.show("发射成功", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom);
                              logic.getComments(state.post.id.toString());
                            }
                          });
                        });
                      },
                    );
                  }, childCount: state.commentsList.length),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        themeData.colorScheme.surface,
                        themeData.colorScheme.surface.withOpacity(0)
                      ],
                    ),
                  ),
                ))
          ],
        )));
  }

}

class ListItem extends StatelessWidget{

  ListItem(this.comments);

  Comments comments;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReadLogic>(builder: (builder){
      return Container(
        padding: EdgeInsets.all(10),
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
          margin: EdgeInsets.only(left: comments.toId==null?10:25,bottom: 25,right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetUtil.getUserWidget(comments.user!),
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
                    builder.likeComments(comments.id!).then((value){
                      if(value.code==200){
                        comments.likeNumber++;
                      }else{
                        comments.likeNumber--;
                      }
                      builder.update();
                    });
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
      );
    });
  }

}
