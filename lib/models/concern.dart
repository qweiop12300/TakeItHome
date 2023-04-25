import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/concern.g.dart';
import 'package:take_it_home/models/topic.dart';
import 'package:take_it_home/models/user_e.dart';
import 'dart:convert';

import 'animal.dart';

@JsonSerializable()
class Concern {

	int? id;
	int? uid;
	int? toUid;
	dynamic toAid;
	dynamic toTid;
	String? createDate;

	Animal? appAnimal;
	UserE? sysUserE;
	UserE? toUserE;
	Topic? appTopic;
  
  Concern();

  factory Concern.fromJson(Map<String, dynamic> json) => $ConcernFromJson(json);

  Map<String, dynamic> toJson() => $ConcernToJson(this);

    
  @override
  String toString() {
    return jsonEncode(this);
  }
}