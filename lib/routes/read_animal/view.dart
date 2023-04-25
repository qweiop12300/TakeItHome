import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:take_it_home/common/MyIcon.dart';
import '../../common/API.dart';
import '../../generated/fonts.gen.dart';
import '../../models/user_e.dart';
import '../../widgets/post_list_view.dart';
import 'logic.dart';

class ReadAnimalPage extends StatefulWidget {
  ReadAnimalPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ReadAnimalPageState();
  }
}

class ReadAnimalPageState extends State<ReadAnimalPage>{

  final logic = Get.put(ReadAnimalLogic());
  final state = Get.find<ReadAnimalLogic>().state;


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(state.animalState==null?"":state.animalState!.appAnimal!.name!),),
      floatingActionButton: InkWell(
        onTap: () {
          logic.concern(API.concern,state.animalState!.aid!).then((value) => {
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
      body: state.animalState==null?Loading():
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
                        child: Image.network(Util.getStartImageUrl(state.animalState!.appAnimal!.icon!),width: 150,height: 150,fit: BoxFit.cover,),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 25,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(state.animalState!.appAnimal!.name!,style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.bold),),
                              Icon(MyIcon.dog,color: state.animalState!.appAnimal!.sex==0?Colors.blue:Colors.pinkAccent,size: 16,)
                            ],),
                          SizedBox(height: 5,),
                          Text.rich(TextSpan(
                              children: [
                                TextSpan(text: "已经"),
                                TextSpan(text: state.animalState!.appAnimal!.year.toString(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                                TextSpan(text: "岁啦")
                              ]
                          )),
                          SizedBox(height: 5,),
                          Text.rich(TextSpan(
                              children: [
                                TextSpan(text: "在"),
                                TextSpan(text: state.animalState!.appAnimal!.createDate.toString(),style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                                TextSpan(text: "被找到")
                              ]
                          )),

                          SizedBox(height: 5,),
                          Text.rich(TextSpan(
                              children: [
                                TextSpan(text: "状态:"),
                                TextSpan(text: state.animalState!.appAnimal!.appAnimalStateData!.title,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                              ]
                          )),

                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text("它的关系:",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                  Row(
                    children: [
                      state.animalState!.bid==null?SizedBox():
                      ImageItem(state.animalState!.bsysUser!),
                      state.animalState!.hid==null?SizedBox():
                      ImageItem(state.animalState!.hsysUser!),
                      state.animalState!.uid==null?SizedBox():
                      ImageItem(state.animalState!.usysUser!),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Text("关联的动态:",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
                  SizedBox(height: 5,),
                ],
              ),
            ),
          ),
          PostListViewBuilder(posts: state.postList!, withShadow: false,isComplete: false),
        ],
      )
    );
  }

  @override
  void initState() {
    String? id = Get.parameters['id'];
    logic.getInfo(id!).then((value){
      logic.getPostList(data: {"aid":state.animalState!.aid}).then((value) => setState(() {}));
    });
  }
}

class ImageItem extends StatelessWidget{
  final UserE userE;
  ImageItem(this.userE);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: [
            ClipOval(child: Image.network(Util.getStartImageUrl(userE.avatar!),width: 60,height: 60,fit: BoxFit.cover,),),
            SizedBox(height: 5,),
            Text(userE.nickName!)
          ],
        ),
      ),
      onTap: (){
        Get.toNamed("/userInfo?id="+userE.userId!.toString());
      },
    );
  }

}