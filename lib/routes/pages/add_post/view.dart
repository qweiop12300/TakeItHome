import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/MyIcon.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';

import '../../../common/Global.dart';
import '../../../common/Util.dart';
import 'logic.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddPostPageState();
  }
}

class AddPostPageState extends State<AddPostPage>{

  final logic = Get.put(AddPostLogic());
  final state = Get.find<AddPostLogic>().state;

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  final controller = MultiImagePickerController(
      maxImages: 9,
      allowedImageTypes: ['png', 'jpg', 'jpeg','mp4'],
      withData: false,
      withReadStream: false,
      images: <ImageFile>[], // array of pre/default selected images
  );

  @override
  Widget build(BuildContext context) {
    return state.postTypeList.length==0?Loading():
    Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              TextField(
                  autofocus: true,
                  maxLines: 1,
                  controller: title,
                  style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: "标题",
                    border: InputBorder.none,
                  )
              ),
              Positioned(child: ElevatedButton(
                onPressed: () {
                  print(controller.images.toList());
                  Git.uploadList(controller.images.toList()).then((value){
                    Post post = Post();
                    post..video=value["video"]..image=value["image"].toString();
                    post..title=title.text..content=content.text..aid=state.animal==null?null:state.animal!.id!..typeId=state.postType!.id!;
                    post..tid=state.topic?.id;
                    logic.addPost(post).then((value){
                      if(value.code==200){
                        FlutterToastr.show("发布成功", context);
                      }else{
                        FlutterToastr.show("发布失败", context);
                      }
                    });
                  });
                },
                child: Text("发布"),
              ),right: 0,top: 10,)
            ],
          ),
          TextField(
              autofocus: true,
              minLines: 3,
              maxLines: null,
              controller: content,
              decoration: InputDecoration(
                  hintText: "内容",
                  border: InputBorder.none,
              )
          ),
          GestureDetector(
            child:
            Text.rich(TextSpan(
                children: [
                  TextSpan(text: "动态类型:"),
                  TextSpan(text: state.postType!.name,style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold)),
                ]
            )),
            onTap: (){
              List<String> list = [];
              state.postTypeList.forEach((element) {
                list.add(element.name!);
              });
              CommentsView.showStringList(context,list,(index){
                state.postType = state.postTypeList[index];
                setState(() {

                });
              });
            },
          ),
          MultiImagePickerView(
              controller: controller,initialContainerBuilder: (context,fun){
                return SizedBox(height: 20,);
              }
          ),
          SizedBox(height: 10,),
          state.animal==null?SizedBox():
              Text("关联的动物"),
          state.animal==null?SizedBox():
          Container(
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                ClipOval(child: Image.network(Util.getStartImageUrl(state.animal!.icon!),width: 60,height: 60,fit: BoxFit.cover,),),
                SizedBox(height: 5,),
                Text(state.animal!.name!)
              ],
            ),
          ),

          Row(
            children: [
              GestureDetector(
                child: Icon(Icons.image_outlined),
                onTap: (){
                  controller.pickImages();
                },
              ),
              SizedBox(width: 10,),
              GestureDetector(
                child: Icon(MyIcon.dog),
                onTap: (){
                  CommentsView.showAnimalList(context, state.animalList, (index){
                    state.animal=state.animalList[index];
                    setState(() {

                    });
                  });
                },
              ),
              SizedBox(width: 10,),
              GestureDetector(
                child: Text("#",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                onTap: (){
                  content.text=content.text+'#';
                },
              ),
            ],
          )


        ],
      ),
    );
  }

  @override
  void initState() {
    logic.getPostTypeList().then((value){
      state.postType=state.postTypeList[0];
      logic.getAllAnimalList(Global.profile.value.userLogin!.sysUser!.userId);
      setState(() {
      });
    });
    content.addListener(() {
      List<String> list = content.text.split('#');
      if(list.length>=2){
        logic.getTopicList(list[list.length-1]).then((value){
          List<String> strs = [];
          state.topicList.forEach((element) {
            strs.add(element.title!);
          });
          CommentsView.showStringList(context, strs, (index){
            content.text=content.text.substring(0,content.text.length-1)+'!-['+ strs[index]+']';
            state.topic = state.topicList[index];
          });
        });
      }
    });

  }
}
