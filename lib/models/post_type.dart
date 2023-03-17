import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/post_type.g.dart';
import 'dart:convert';

@JsonSerializable()
class PostType {

	int? id;
	String? name;
  String? icon;
  
  PostType();

  factory PostType.fromJson(Map<String, dynamic> json) => $PostTypeFromJson(json);

  Map<String, dynamic> toJson() => $PostTypeToJson(this);

  PostType copyWith({int? id, String? name,String? icon}) {
      return PostType()..id= id ?? this.id
			..name= name ?? this.name..icon= icon ?? this.icon;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}