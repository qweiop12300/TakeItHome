import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/post_type.dart';
import 'package:take_it_home/routes/pages/home_view/view.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/post_list_view.dart';

import '../../common/API.dart';
import '../../models/like.dart';
import '../../models/post.dart';
import '../../widgets/my_notification.dart';
import 'logic.dart';

class ListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage>{
  final logic = Get.put(ListLogic());
  final state = Get.find<ListLogic>().state;


  @override
  void initState() {
    Future.wait([
      logic.getPostTypeList(),
      logic.getPostList()
    ]).then((value) => {
      setState((){
        state.isLoading=false;
      })
    });

  }

  @override
  Widget build(BuildContext context) {
    return state.isLoading?Scaffold(
      appBar: AppBar(),
      body: Loading(),
    ):NotificationListener<MyNotification>(
        onNotification: (myNotification){
          switch(myNotification.type){
            case NotificationType.postLike:
              Post post = myNotification.post!;
              logic.add(API.like, post.id!).then((value) => {
                setState((){
                  if(value?.code==200){
                    post..isLike=Like()..likeNumber = post.likeNumber!+1;
                  }else{
                    post..isLike=null..likeNumber = post.likeNumber!-1;
                  }
                })
              });
              break;
            case NotificationType.postCollection:
              Post post = myNotification.post!;
              logic.add(API.collection, post.id!).then((value) => {
                setState((){
                  if(value?.code==200){
                    post..isCollection=Like()..collectionNumber = post.collectionNumber!+1;
                  }else{
                    post..isCollection=null..collectionNumber = post.collectionNumber!-1;
                  }
                })
              });
              break;
          }
          return true;
        },
        child:DefaultTabController(
          length: state.postTypeList!.length, // tab的数量.
          child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                    sliver: SliverAppBar(
                      title: const Text('动态'),
                      floating: true,
                      snap: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        labelPadding:EdgeInsets.all(0),
                        labelColor: Colors.black87,
                        indicatorWeight:2,
                        tabs: state.postTypeList!.map((post) => Tab(text: post.name,)).toList(),
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                children: state.postTypeList!.map((post) {
                  return Builder(
                    builder: (BuildContext context) {
                      return PageView(postType: post);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}

class PageView extends StatefulWidget{
  final PostType postType;

  const PageView(
      {Key? key, required this.postType})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PageViewState(postType);
  }
}


class PageViewState extends State<PageView> with AutomaticKeepAliveClientMixin{
  final PostType postType;

  PageViewState(this.postType);

  List<Post>? postList;

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data,pageNum: pageNum,pageSize: pageSize);
    postList = bean.rows!;
  }

  @override
  Widget build(BuildContext context) {
    return postList==null?Loading():
    CustomScrollView(
      slivers: <Widget>[
        PostListViewBuilder(posts: postList!, withShadow: false,isComplete: false),
      ],
    );

  }

  @override
  void initState() {
    getPostList(data: {"typeId":postType.id}).then((value){
      setState(() {});
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
