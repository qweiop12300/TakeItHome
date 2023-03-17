import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/user_login.g.dart';
import 'dart:convert';

@JsonSerializable()
class UserLogin {

	String? username;
	String? password;
	String? uuid;
	String? code;
	String? phone;
  String? token;

  UserLogin();


  factory UserLogin.fromJson(Map<String, dynamic> json) => $UserLoginFromJson(json);

  Map<String, dynamic> toJson() => $UserLoginToJson(this);

  UserLogin copyWith({String? username, String? password, String? uuid, String? code, String? phone,String? token}) {
      return UserLogin()..username= username ?? this.username
			..password= password ?? this.password
			..uuid= uuid ?? this.uuid
			..code= code ?? this.code
			..phone= phone ?? this.phone
      ..token= token ?? this.token;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}