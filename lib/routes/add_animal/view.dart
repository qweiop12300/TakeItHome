import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/MyIcon.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/widgets/comments.dart';
import 'package:take_it_home/widgets/loading.dart';

import 'logic.dart';

class AddAnimalPage extends StatefulWidget {
  AddAnimalPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return AddAnimalPageState();
  }
}

class AddAnimalPageState extends State<AddAnimalPage>{
  final logic = Get.put(AddAnimalLogic());
  final state = Get.find<AddAnimalLogic>().state;

  final controller = MultiImagePickerController(
      maxImages: 1,
      allowedImageTypes: ['png', 'jpg', 'jpeg'],
      withData: false,
      withReadStream: false,
      images: <ImageFile>[] // array of pre/default selected images
  );

  TextEditingController controller1 = TextEditingController();

  TextEditingController controller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("建立宠物档案"),),
      body: state.animalStateList==null?Loading():
      Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              autofocus: true,
              controller: controller1,
              decoration: InputDecoration(
                labelText: "名字",
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: controller2,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "年龄",
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Text("性别",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(width: 10,),
                GestureDetector(
                  child: Icon(MyIcon.dog,color: state.sex?Colors.blue:Colors.black26,size: 40,),
                  onTap: (){
                    setState(() {
                      state.sex=!state.sex;
                    });
                  },
                ),
                GestureDetector(
                  child: Icon(MyIcon.dog,color: state.sex?Colors.black26:Colors.pinkAccent,size: 40,),
                  onTap: (){
                    setState(() {
                      state.sex=!state.sex;
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 10,),
            Text("头像",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Container(
              width: 100,
              height: 100,
              child: MultiImagePickerView(
                  onChange: (images) {},
                  controller: controller
              ),
            ),
            SizedBox(height: 10,),
            GestureDetector(
              child: Text.rich(TextSpan(
                  children: [
                    TextSpan(text: "状态:"),
                    TextSpan(text: state.animalStateData!.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold))
                  ]
              )),
              onTap: (){
                List<String> list = [];
                state.animalStateList!.forEach((element) {
                  list.add(element.title);
                });
                CommentsView.showStringList(context, list, (index){
                  setState(() {
                    state.animalStateData = state.animalStateList![index];
                  });
                });
              },
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){
                  if(controller1.text==""||controller2.text==""){
                    FlutterToastr.show("请补全信息", context);
                    return;
                  }
                  if(controller.images.length>0){
                    Git.upload(controller.images.toList()[0]).then((value){
                      Animal animal = Animal();
                      animal..icon=value!..sex=state.sex?0:1..name=controller1.text..year=controller2.text..sid=state.animalStateData!.id;
                      logic.addAnimal(animal).then((value){
                        if(value.code==200){
                          FlutterToastr.show("保存成功", context);
                          Get.back();
                        }else{
                          FlutterToastr.show("保存失败", context);
                        }
                      });
                    });
                  }else{
                    FlutterToastr.show("请选择头像", context);
                    return;
                  }
                  }, child: Text("创建",style: TextStyle(fontSize: 18),)))
              ],
            )

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    logic.getAnimalStateList().then((value){
      setState(() {

      });
    });
  }


}