import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/head.g.dart';
import 'dart:convert';

import 'package:take_it_home/models/post.dart';

@JsonSerializable()
class Head {

	int? id;
	int? pid;
	Post? post;
  
  Head();

  factory Head.fromJson(Map<String, dynamic> json) => $HeadFromJson(json);

  Map<String, dynamic> toJson() => $HeadToJson(this);

  Head copyWith({int? id, int? pid, Post? post}) {
      return Head()..id= id ?? this.id
			..pid= pid ?? this.pid
			..post= post ?? this.post;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}