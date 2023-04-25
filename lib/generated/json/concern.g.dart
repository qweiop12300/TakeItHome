import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/concern.dart';
import 'package:take_it_home/models/topic.dart';

import 'package:take_it_home/models/user_e.dart';

import '../../models/animal.dart';




Concern $ConcernFromJson(Map<String, dynamic> json) {
	final Concern concern = Concern();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		concern.id = id;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		concern.uid = uid;
	}
	final int? toUid = jsonConvert.convert<int>(json['toUid']);
	if (toUid != null) {
		concern.toUid = toUid;
	}
	final dynamic toAid = jsonConvert.convert<dynamic>(json['toAid']);
	if (toAid != null) {
		concern.toAid = toAid;
	}
	final dynamic toTid = jsonConvert.convert<dynamic>(json['toTid']);
	if (toTid != null) {
		concern.toTid = toTid;
	}
	final String? createDate = jsonConvert.convert<String>(json['createDate']);
	if (createDate != null) {
		concern.createDate = createDate;
	}
	final Animal? appAnimal = jsonConvert.convert<Animal>(json['appAnimal']);
	if (appAnimal != null) {
		concern.appAnimal = appAnimal;
	}
	final UserE? sysUserE = jsonConvert.convert<UserE>(json['sysUserE']);
	if (sysUserE != null) {
		concern.sysUserE = sysUserE;
	}
	final UserE? toUserE = jsonConvert.convert<UserE>(json['toUserE']);
	if (toUserE != null) {
		concern.toUserE = toUserE;
	}
	final Topic? appTopic = jsonConvert.convert<Topic>(json['appTopic']);
	if (appTopic != null) {
		concern.appTopic = appTopic;
	}
	return concern;
}

Map<String, dynamic> $ConcernToJson(Concern entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['uid'] = entity.uid;
	data['toUid'] = entity.toUid;
	data['toAid'] = entity.toAid;
	data['toTid'] = entity.toTid;
	data['createDate'] = entity.createDate;
	data['appAnimal'] = entity.appAnimal?.toJson();
	data['sysUserE'] = entity.sysUserE?.toJson();
	data['toUserE'] = entity.toUserE?.toJson();
	data['appTopic'] = entity.appTopic?.toJson();
	return data;
}