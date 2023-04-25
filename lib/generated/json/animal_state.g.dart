import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/animal.dart';

import 'package:take_it_home/models/user_e.dart';


AnimalState $AnimalStateFromJson(Map<String, dynamic> json) {
	final AnimalState animalState = AnimalState();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		animalState.id = id;
	}
	final int? aid = jsonConvert.convert<int>(json['aid']);
	if (aid != null) {
		animalState.aid = aid;
	}
	final Animal? appAnimal = jsonConvert.convert<Animal>(json['appAnimal']);
	if (appAnimal != null) {
		animalState.appAnimal = appAnimal;
	}
	final dynamic uid = jsonConvert.convert<dynamic>(json['uid']);
	if (uid != null) {
		animalState.uid = uid;
	}
	final UserE? usysUser = jsonConvert.convert<UserE>(json['usysUser']);
	if (usysUser != null) {
		animalState.usysUser = usysUser;
	}
	final int? bid = jsonConvert.convert<int>(json['bid']);
	if (bid != null) {
		animalState.bid = bid;
	}
	final UserE? bsysUser = jsonConvert.convert<UserE>(json['bsysUser']);
	if (bsysUser != null) {
		animalState.bsysUser = bsysUser;
	}
	final int? hid = jsonConvert.convert<int>(json['hid']);
	if (hid != null) {
		animalState.hid = hid;
	}
	final UserE? hsysUser = jsonConvert.convert<UserE>(json['hsysUser']);
	if (hsysUser != null) {
		animalState.hsysUser = hsysUser;
	}
	final dynamic s1 = jsonConvert.convert<dynamic>(json['s1']);
	if (s1 != null) {
		animalState.s1 = s1;
	}
	return animalState;
}

Map<String, dynamic> $AnimalStateToJson(AnimalState entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['aid'] = entity.aid;
	data['appAnimal'] = entity.appAnimal?.toJson();
	data['uid'] = entity.uid;
	data['usysUser'] = entity.usysUser?.toJson();
	data['bid'] = entity.bid;
	data['bsysUser'] = entity.bsysUser?.toJson();
	data['hid'] = entity.hid;
	data['hsysUser'] = entity.hsysUser?.toJson();
	data['s1'] = entity.s1;
	return data;
}