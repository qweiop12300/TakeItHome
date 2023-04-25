import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/post_type.dart';
import '../common/Util.dart';
import '../models/animal.dart';
import 'my_notification.dart';

class CommentsView{

  static showCupertinoAlertDialog(BuildContext context,String title,String content, Function callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(title),
            content: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Align(
                  child: Text(content),
                  alignment: Alignment(0, 0),
                ),
              ],
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text("取消"),
                onPressed: () {
                  callback(1);
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text("确定"),
                onPressed: () {
                  callback(0);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  static showAnimalList(BuildContext context,List<Animal> animalList,Function callback) async{
    return await showModalBottomSheet<MyNotification>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            height: 130,
            child:
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,index){
              return GestureDetector(
                child: ImageItem(animalList[index]),
                onTap: (){
                  callback(index);
                  Navigator.pop(context);
                },
              );
            },itemCount: animalList.length,)
        );
      },
    );
  }

  static showStringList(BuildContext context,List<String> strings,Function callback) async{
    return await showModalBottomSheet<MyNotification>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
            clipBehavior: Clip.antiAlias,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            height: 200,
            child:
            ListView.builder(itemBuilder: (context,index){
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Text(strings[index]),
                ),
                onTap: (){
                  callback(index);
                  Navigator.pop(context);
                },
              );
            },itemCount: strings.length,)
        );
      },
    );

  }

  static Future<MyNotification?> showComments(BuildContext context,Function function) async{
    ImageFile? imageFile;
    TextEditingController _unameController = TextEditingController();
    var controller = MultiImagePickerController(
        maxImages: 1,
        allowedImageTypes: ['png', 'jpg', 'jpeg'],
        withData: false,
        withReadStream: false,
        images: <ImageFile>[] // array of pre/default selected images
    );
    return await showModalBottomSheet<MyNotification>(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.antiAlias,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          height: 200,
          child:
          Stack(
            children: [
              Positioned(child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                autofocus: true,
                controller: _unameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "评论",
                ),
              )),
              Positioned(child:
                Container(height: 60,width: 60,child:
                  MultiImagePickerView(
                      onChange: (images) {
                        if(images.length!=0){
                          imageFile = images.first;
                        }

                      },
                      controller: controller,initialContainerBuilder: (context,fun){
                    return GestureDetector(child:
                      Icon(Icons.image_search),onTap: (){
                        fun();
                    },);
                  }
                  ),
                ),bottom: 0,left: 0,),
              Positioned(child: ElevatedButton(onPressed: (){
                if(imageFile!=null){
                  Git.upload(imageFile!).then((value){
                    function(_unameController.text,value);
                  });
                }else{
                  function(_unameController.text,null);
                }
                controller.dispose();
                _unameController.dispose();
                Navigator.pop(context);
              }, child: Text("发送"),),bottom: 0,right: 0,)
            ],
          )
        );
      },
    );
  }

}

class ImageItem extends StatelessWidget{
  final Animal animal;
  ImageItem(this.animal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ClipOval(child: Image.network(Util.getStartImageUrl(animal.icon!),width: 60,height: 60,fit: BoxFit.cover,),),
          SizedBox(height: 5,),
          Text(animal.name!)
        ],
      ),
    );
  }

}