import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/like.g.dart';
import 'dart:convert';

import 'package:take_it_home/models/post.dart';

@JsonSerializable()
class Like {

	int? id;
	int? uid;
	int? pid;
	String? createDate;

  Post? appPost;
  
  Like();

  factory Like.fromJson(Map<String, dynamic> json) => $LikeFromJson(json);

  Map<String, dynamic> toJson() => $LikeToJson(this);

  Like copyWith({int? id, int? uid, int? pid, String? createDate,Post? appPost}) {
      return Like()..id= id ?? this.id
			..uid= uid ?? this.uid
			..pid= pid ?? this.pid
        ..appPost= appPost ?? this.appPost
			..createDate= createDate ?? this.createDate;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}