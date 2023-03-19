import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/user_e.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserE {

	int? userId;
	String? nickName;
	String? sex;
	String? avatar;
	String? remark;
  
  UserE();

  factory UserE.fromJson(Map<String, dynamic> json) => $UserEFromJson(json);

  Map<String, dynamic> toJson() => $UserEToJson(this);

  UserE copyWith({int? userId, String? nickName, String? sex, String? avatar, String? remark}) {
      return UserE()..userId= userId ?? this.userId
			..nickName= nickName ?? this.nickName
			..sex= sex ?? this.sex
			..avatar= avatar ?? this.avatar
			..remark= remark ?? this.remark;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}