import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/comments.g.dart';
import 'dart:convert';
import 'package:take_it_home/models/user_e.dart';
import 'package:take_it_home/models/animal.dart';

@JsonSerializable()
class Comments {

	int? id;
	dynamic toId;
	int? pid;
	String? content;
	dynamic image;
	int? uid;
	UserE? user;
	dynamic aid;
	Animal? appAnimal;
	dynamic likeNumber;
	dynamic createDate;
  
  Comments();

  factory Comments.fromJson(Map<String, dynamic> json) => $CommentsFromJson(json);

  Map<String, dynamic> toJson() => $CommentsToJson(this);

  Comments copyWith({int? id, dynamic toId, int? pid, String? content, dynamic image, int? uid, UserE? user, dynamic aid, Animal? appAnimal, dynamic likeNumber, dynamic createDate}) {
      return Comments()..id= id ?? this.id
			..toId= toId ?? this.toId
			..pid= pid ?? this.pid
			..content= content ?? this.content
			..image= image ?? this.image
			..uid= uid ?? this.uid
			..user= user ?? this.user
			..aid= aid ?? this.aid
			..appAnimal= appAnimal ?? this.appAnimal
			..likeNumber= likeNumber ?? this.likeNumber
			..createDate= createDate ?? this.createDate;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}