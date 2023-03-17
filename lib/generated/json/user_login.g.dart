import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/VO/user_login.dart';

UserLogin $UserLoginFromJson(Map<String, dynamic> json) {
	final UserLogin userLogin = UserLogin();
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userLogin.username = username;
	}
	final String? password = jsonConvert.convert<String>(json['password']);
	if (password != null) {
		userLogin.password = password;
	}
	final String? uuid = jsonConvert.convert<String>(json['uuid']);
	if (uuid != null) {
		userLogin.uuid = uuid;
	}
	final String? code = jsonConvert.convert<String>(json['code']);
	if (code != null) {
		userLogin.code = code;
	}
	final String? phone = jsonConvert.convert<String>(json['phone']);
	if (phone != null) {
		userLogin.phone = phone;
	}
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		userLogin.token = token;
	}
	return userLogin;
}

Map<String, dynamic> $UserLoginToJson(UserLogin entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['username'] = entity.username;
	data['password'] = entity.password;
	data['uuid'] = entity.uuid;
	data['code'] = entity.code;
	data['phone'] = entity.phone;
	data['token'] = entity.token;
	return data;
}