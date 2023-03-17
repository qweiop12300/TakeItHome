import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/post.g.dart';
import 'dart:convert';

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
	dynamic tid;
	dynamic aid;
	dynamic location;
	dynamic city;
	dynamic urgent;
	dynamic typeId;
	int? likeNumber;
	int? collectionNumber;
	int? commentsNumber;
	dynamic url;
	dynamic s1;
  
  Post();

  factory Post.fromJson(Map<String, dynamic> json) => $PostFromJson(json);

  Map<String, dynamic> toJson() => $PostToJson(this);

  Post copyWith({int? id, String? title, String? content, dynamic image, dynamic video, dynamic createDate, dynamic updateDate, int? uid, dynamic tid, dynamic aid, dynamic location, dynamic city, dynamic urgent, dynamic typeId, int? likeNumber, int? collectionNumber, int? commentsNumber, dynamic url, dynamic s1}) {
      return Post()..id= id ?? this.id
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