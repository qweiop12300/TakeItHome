import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/user_e.dart';

UserE $UserEFromJson(Map<String, dynamic> json) {
	final UserE userE = UserE();
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		userE.userId = userId;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		userE.nickName = nickName;
	}
	final String? sex = jsonConvert.convert<String>(json['sex']);
	if (sex != null) {
		userE.sex = sex;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		userE.avatar = avatar;
	}
	final String? remark = jsonConvert.convert<String>(json['remark']);
	if (remark != null) {
		userE.remark = remark;
	}
	return userE;
}

Map<String, dynamic> $UserEToJson(UserE entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['userId'] = entity.userId;
	data['nickName'] = entity.nickName;
	data['sex'] = entity.sex;
	data['avatar'] = entity.avatar;
	data['remark'] = entity.remark;
	return data;
}