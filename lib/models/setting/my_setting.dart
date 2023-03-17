import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/my_setting.g.dart';
import 'dart:convert';

import '../VO/user_login.dart';

@JsonSerializable()
class MySetting {

	int theme=0;
	@JSONField(name: "user_login")
	UserLogin? userLogin;
	String? cache;
  bool? isLogin;
  
  MySetting();

  factory MySetting.fromJson(Map<String, dynamic> json) => $MySettingFromJson(json);

  Map<String, dynamic> toJson() => $MySettingToJson(this);

  MySetting copyWith({int? theme, UserLogin? userLogin, String? cache,bool? isLogin}) {
      return MySetting()..theme= theme ?? this.theme
			..userLogin= userLogin ?? this.userLogin
			..cache= cache ?? this.cache
      ..isLogin= isLogin ?? this.isLogin;
  }
    
  @override
  String toString() {
    return jsonEncode(this);
  }
}