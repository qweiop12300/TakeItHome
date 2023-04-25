import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/setting/my_setting.dart';

import '../../models/VO/user_login.dart';



MySetting $MySettingFromJson(Map<String, dynamic> json) {
	final MySetting mySetting = MySetting();
	final int? theme = jsonConvert.convert<int>(json['theme']);
	if (theme != null) {
		mySetting.theme = theme;
	}
	final UserLogin? userLogin = jsonConvert.convert<UserLogin>(json['user_login']);
	if (userLogin != null) {
		mySetting.userLogin = userLogin;
	}
	final String? cache = jsonConvert.convert<String>(json['cache']);
	if (cache != null) {
		mySetting.cache = cache;
	}
	final bool? isLogin = jsonConvert.convert<bool>(json['isLogin']);
	if (isLogin != null) {
		mySetting.isLogin = isLogin;
	}
	return mySetting;
}

Map<String, dynamic> $MySettingToJson(MySetting entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['theme'] = entity.theme;
	data['user_login'] = entity.userLogin?.toJson();
	data['cache'] = entity.cache;
	data['isLogin'] = entity.isLogin;
	return data;
}