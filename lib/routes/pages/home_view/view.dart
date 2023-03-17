
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../../models/post.dart';
import '../../../models/post_type.dart';
import 'logic.dart';

class HomeViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeViewPage>{
  final logic = Get.put(HomeViewLogic());
  final state = Get.find<HomeViewLogic>().state;
  @override
  Widget build(BuildContext context) {
    return !state.isLoading?
        RefreshIndicator(child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.white30,
            ),
            child: Container(
              margin: EdgeInsets.only(left: 15,right: 15,top: 10),
              child:buildSliverList(),
            )
        ), onRefresh: _onRefresh):Loading();
  }

  Future<void> _onRefresh() async {
    Future.wait([
      logic.getHeadList(),
      logic.getPostTypeList(),
      logic.getPostList(),
    ]).then((value) => {
      setState((){
        state.isLoading=false;
      })
    });
  }

  @override
  void initState() {
    _onRefresh();
  }

  Widget buildSliverList() {
    var swiper = Swiper(
      itemBuilder: (context, index) {
        return Image.network(
          Util.getImageUrl(state.headList[index].post!.image),
          fit: BoxFit.cover,
        );
      },
      itemCount: state.headList.length,
      viewportFraction: 0.8,
      scale: 0.9,
        autoplay:true,
        duration: 300,
    );
    var gridView = SliverGrid.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: state.postTypeList.length,
        itemBuilder: (context,index){
      return IconListItem(state.postTypeList[index]);
    });
    var TextView = Text("紧急",style: TextStyle(color: Colors.blue),);

    var listView = SliverGrid.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.6),
      itemCount: state.postList.length,
      itemBuilder: (context,index){
      return ListItem(state.postList[index]);
      },
    );
    // 使用
    return CustomScrollView(
      shrinkWrap:true,
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            child: swiper,
            height: 200,
          ),
        ),
        gridView,
        SliverToBoxAdapter(
          child: SizedBox(
            child: TextView,
            height: 30,
          ),
        ),
        listView
      ],
    );
  }

}

class IconListItem extends StatelessWidget{
  PostType post;
  IconListItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(builder: (context,par){
                if(post.icon!=null&&post.icon!=""){
                  return Container(
                    padding: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5),
                    child: Image.network(Util.getImageUrl(post.icon!),
                      height: par.maxWidth-39,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return Text("");
              }),
              Text(post.name!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black
                ))
            ],
          ),
        );
  }
}

class ListItem extends StatelessWidget{
  Post post;
  ListItem(this.post);

  @override
  Widget build(BuildContext context) {
    return
      Card(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: LayoutBuilder(builder: (context,par){
                  Image image = Image.network(Util.getImageUrl(post.image),fit:BoxFit.cover,);
                  return Container(
                    padding: EdgeInsets.all(5),
                    child: image,
                  );
                }),
              ),
              Text(post.title!)
            ],
          ),
        ),
      );
  }

}
