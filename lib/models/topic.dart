import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/topic.g.dart';
import 'dart:convert';

@JsonSerializable()
class Topic {

	int? id;
	String? title;
  
  Topic();

  factory Topic.fromJson(Map<String, dynamic> json) => $TopicFromJson(json);

  Map<String, dynamic> toJson() => $TopicToJson(this);

  Topic copyWith({int? id, String? title}) {
      return Topic()..id= id ?? this.id
			..title= title ?? this.title;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}