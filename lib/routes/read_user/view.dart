
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/widgets/post_list_view.dart';

import '../../common/API.dart';
import '../../common/MyIcon.dart';
import '../../common/Util.dart';
import '../../generated/fonts.gen.dart';
import 'logic.dart';

class ReadUserPage extends StatefulWidget {
  ReadUserPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReadUserPageState();
  }
}

class ReadUserPageState extends State<ReadUserPage>{

  final logic = Get.put(ReadUserLogic());
  final state = Get.find<ReadUserLogic>().state;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: state.sysUser==null?Loading():Text(state.sysUser!.nickName),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          logic.concern(API.concern,state.sysUser!.userId).then((value) => {
            if(value?.code==200){
              FlutterToastr.show("已关注", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom)
            }else{
              FlutterToastr.show("已取关", context, duration: FlutterToastr.lengthShort, position:  FlutterToastr.bottom)
            }
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
                '关注',
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
        body: state.sysUser==null?Loading():
        CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect( //剪裁为圆角矩形
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(Util.getStartImageUrl(state.sysUser!.avatar),width: 150,height: 150,fit: BoxFit.cover,),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 25,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(state.sysUser!.nickName,style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                                Icon(MyIcon.accessibility,color: state.sysUser!.sex==0?Colors.blue:Colors.pinkAccent,size: 16,),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  child: Icon(Icons.access_alarm,size: 30,),
                                  onTap: (){
                                    Get.toNamed("chat?id=${state.sysUser!.userId.toString()}");
                                  },
                                )
                              ],),
                            SizedBox(height: 5,),
                            Text.rich(TextSpan(
                                children: [
                                  TextSpan(text: "已经"),
                                  TextSpan(text: state.sysUser!.userData.year.toString(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                                  TextSpan(text: "岁啦")
                                ]
                            )),
                            SizedBox(height: 5,),
                            Text.rich(TextSpan(
                                children: [
                                  TextSpan(text: "在"),
                                  TextSpan(text: state.sysUser!.createTime.toString(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                                  TextSpan(text: "加入")
                                ]
                            )),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("它的动物:",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    Container(
                      height: 100,
                      child: ListView.builder(itemBuilder: (context,index){
                        return ImageItem(state.animalState[index].appAnimal!);
                      },
                        scrollDirection: Axis.horizontal,
                        itemCount: state.animalState.length,),
                    ),
                    SizedBox(height: 15,),
                    Text("关联的动态:",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                    SizedBox(height: 5,),
                  ],
                ),
              ),
            ),
            PostListViewBuilder(posts: state.postList, withShadow: false,isComplete: false),
          ],
        )
    );
  }

  @override
  void initState() {
    String? id = Get.parameters["id"];
    logic.getUserInfo(id!).then((value){
      logic.getPostList(data: {"uid":id}).then((value){
        Future.wait([
          logic.getAnimalState(data: {"uid":id}),
          logic.getAnimalState(data: {"hid":id}),
          logic.getAnimalState(data: {"bid":id}),
        ]).then((value){
          setState(() {

          });
        });
      });
    });

    // logic.getUserInfo(id!).then((value){
    //   logic.getPostList(data: {"uid":id});
    // }).then((value){
    //   state.postList.addAll(value as List<Post>);
    //   logic.getPostList(data: {"bid":id});
    // }).then((value){
    //   state.postList.addAll(value as List<Post>);
    //   logic.getPostList(data: {"hid":id});
    // }).then((value){
    //   state.postList.addAll(value as List<Post>);
    //   setState(() {
    //
    //   });
    // });
  }




}

class ImageItem extends StatelessWidget{
  final Animal animal;
  ImageItem(this.animal);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            ClipOval(child: Image.network(Util.getStartImageUrl(animal.icon!),width: 60,height: 60,fit: BoxFit.cover,),),
            SizedBox(height: 5,),
            Text(animal.name!)
          ],
        ),
      ),
      onTap: (){
        Get.toNamed("/animalInfo?id="+animal.id!.toString());
      },
    );
  }

}
