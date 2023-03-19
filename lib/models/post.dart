import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/post.g.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/topic.dart';
import 'package:take_it_home/models/like.dart';
import 'dart:convert';

import 'package:take_it_home/models/user_e.dart';

import 'concern.dart';

@JsonSerializable()
class Post {

	int? id;
	String? title;
	String? content;
	dynamic image;
	dynamic video;
	dynamic createDate;
	dynamic updateDate;
	int? uid;
	UserE? user;
	dynamic tid;
	Topic? appTopic;
	dynamic aid;
	Animal? appAnimal;
	dynamic location;
	dynamic city;
	dynamic urgent;
	dynamic typeId;
	int? likeNumber;
	int? collectionNumber;
	int? commentsNumber;
	dynamic url;
	dynamic s1;
	Like? isLike;
	Like? isCollection;
	Concern? isConcern;

  
  Post();

  factory Post.fromJson(Map<String, dynamic> json) => $PostFromJson(json);

  Map<String, dynamic> toJson() => $PostToJson(this);

  Post copyWith({Concern? isConcern,Like? isCollection,Like? isLike,Animal? appAnimal,Topic? appTopic,UserE? user,int? id, String? title, String? content, dynamic image, dynamic video, dynamic createDate, dynamic updateDate, int? uid, dynamic tid, dynamic aid, dynamic location, dynamic city, dynamic urgent, dynamic typeId, int? likeNumber, int? collectionNumber, int? commentsNumber, dynamic url, dynamic s1,}) {
      return Post()..id= id ?? this.id
				..isConcern= isConcern ?? this.isConcern
				..isCollection= isCollection ?? this.isCollection
				..isLike= isLike ?? this.isLike
				..appAnimal= appAnimal ?? this.appAnimal
				..appTopic= appTopic ?? this.appTopic
				..user= user ?? this.user
				..title= title ?? this.title
			..content= content ?? this.content
			..image= image ?? this.image
			..video= video ?? this.video
			..createDate= createDate ?? this.createDate
			..updateDate= updateDate ?? this.updateDate
			..uid= uid ?? this.uid
			..tid= tid ?? this.tid
			..aid= aid ?? this.aid
			..location= location ?? this.location
			..city= city ?? this.city
			..urgent= urgent ?? this.urgent
			..typeId= typeId ?? this.typeId
			..likeNumber= likeNumber ?? this.likeNumber
			..collectionNumber= collectionNumber ?? this.collectionNumber
			..commentsNumber= commentsNumber ?? this.commentsNumber
			..url= url ?? this.url
			..s1= s1 ?? this.s1;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}