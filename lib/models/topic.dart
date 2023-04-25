import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/topic.g.dart';
import 'dart:convert';

@JsonSerializable()
class Topic {

	int? id;
	String? title;
  String? image;
  
  Topic();

  factory Topic.fromJson(Map<String, dynamic> json) => $TopicFromJson(json);

  Map<String, dynamic> toJson() => $TopicToJson(this);

    
  @override
  String toString() {
    return jsonEncode(this);
  }
}