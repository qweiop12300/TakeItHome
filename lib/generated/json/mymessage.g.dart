import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:take_it_home/models/user_e.dart';

Mymessage $MymessageFromJson(Map<String, dynamic> json) {
	final Mymessage mymessage = Mymessage();
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		mymessage.content = content;
	}
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		mymessage.id = id;
	}
	final int? isShow = jsonConvert.convert<int>(json['isShow']);
	if (isShow != null) {
		mymessage.isShow = isShow;
	}

	final int? typeId = jsonConvert.convert<int>(json['typeId']);
	if (typeId != null) {
		mymessage.typeId = typeId;
	}

	final int? pid = jsonConvert.convert<int>(json['pid']);
	if (pid != null) {
		mymessage.pid = pid;
	}
	final int? toUid = jsonConvert.convert<int>(json['toUid']);
	if (toUid != null) {
		mymessage.toUid = toUid;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		mymessage.uid = uid;
	}

	final UserE? userE = jsonConvert.convert<UserE>(json['userE']);
	if (userE != null) {
		mymessage.userE = userE;
	}

	final UserE? toUserE = jsonConvert.convert<UserE>(json['toUserE']);
	if (toUserE != null) {
		mymessage.toUserE = toUserE;
	}

	final String? createDate = jsonConvert.convert<String>(json['createDate']);
	if (createDate != null) {
		mymessage.createDate = createDate;
	}

	return mymessage;


}

Map<String, dynamic> $MymessageToJson(Mymessage entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['content'] = entity.content;
	data['id'] = entity.id;
	data['isShow'] = entity.isShow;
	data['pid'] = entity.pid;
	data['toUid'] = entity.toUid;
	data['uid'] = entity.uid;
	data['typeId'] = entity.typeId;
	data['toUserE'] = entity.toUserE;
	data['userE'] = entity.userE;
	data['createDate'] = entity.createDate;
	return data;
}