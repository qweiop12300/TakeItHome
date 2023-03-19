import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/like.g.dart';
import 'dart:convert';

@JsonSerializable()
class Like {

	int? id;
	int? uid;
	int? pid;
	String? createDate;
  
  Like();

  factory Like.fromJson(Map<String, dynamic> json) => $LikeFromJson(json);

  Map<String, dynamic> toJson() => $LikeToJson(this);

  Like copyWith({int? id, int? uid, int? pid, String? createDate}) {
      return Like()..id= id ?? this.id
			..uid= uid ?? this.uid
			..pid= pid ?? this.pid
			..createDate= createDate ?? this.createDate;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}