import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/mymessage.g.dart';
import 'dart:convert';

import 'package:take_it_home/models/user_e.dart';

@JsonSerializable()
class Mymessage {
	String? content;
	int? id;
	int? isShow;
	int? pid;
	int? toUid;
	int? uid;
	UserE? userE;
	UserE? toUserE;
	String? createDate;
	int? typeId;



	Mymessage();

	factory Mymessage.fromJson(Map<String, dynamic> json) => $MymessageFromJson(json);

	Map<String, dynamic> toJson() => $MymessageToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}