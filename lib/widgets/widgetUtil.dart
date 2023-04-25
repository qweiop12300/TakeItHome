
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/user_e.dart';

import '../common/MyIcon.dart';
import '../common/Util.dart';

class WidgetUtil{
  static Widget getUserWidget(UserE userE){
    return GestureDetector(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(Util.getStartImageUrl(userE.avatar!),width: 60,height: 60,fit: BoxFit.cover,),
          ),
          SizedBox(width: 6,),
          Text(userE.nickName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Icon(MyIcon.accessibility,color: userE.sex==0.toString()?Colors.blue:Colors.pinkAccent,)
        ],
      ),
      onTap: (){
        Get.toNamed("/userInfo?id="+userE.userId.toString());
      },
    );
  }

  static Widget getUserAnimalWidget(UserE userE,Animal animal){
    return GestureDetector(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(Util.getStartImageUrl(userE.avatar!),width: 60,height: 60,fit: BoxFit.cover,),
          ),
          SizedBox(width: 6,),
          Text(userE.nickName!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Icon(MyIcon.accessibility,color: userE.sex==0.toString()?Colors.blue:Colors.pinkAccent,),
          SizedBox(width: 10,),
          GestureDetector(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(Util.getStartImageUrl(animal.icon!),width: 60,height: 60,fit: BoxFit.cover,),
            ),
            onTap: (){Get.toNamed("/animalInfo?id="+animal.id.toString());},
          ),
          Icon(MyIcon.dog,color: animal.sex==0?Colors.blue:Colors.pinkAccent,)
        ],
      ),
      onTap: (){
        Get.toNamed("/userInfo?id="+userE.userId.toString());
      },
    );
  }

  static Widget getAnimalWidget(Animal animal){
    return GestureDetector(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(Util.getStartImageUrl(animal.icon!),width: 60,height: 60,fit: BoxFit.cover,),
          ),
          SizedBox(width: 6,),
          Text(animal.name!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          Icon(MyIcon.dog,color: animal.sex==0?Colors.blue:Colors.pinkAccent,)
        ],
      ),
      onTap: (){Get.toNamed("/animalInfo?id="+animal.id.toString());},
    );
  }
}