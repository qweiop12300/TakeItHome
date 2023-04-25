import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/animal.dart';

import '../../models/animal_state.dart';
import '../../models/animal_state_data.dart';



Animal $AnimalFromJson(Map<String, dynamic> json) {
	final Animal animal = Animal();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		animal.id = id;
	}
	final dynamic sid = jsonConvert.convert<dynamic>(json['sid']);
	if (sid != null) {
		animal.sid = sid;
	}
	final AnimalStateData? appAnimalStateData = jsonConvert.convert<AnimalStateData>(json['appAnimalStateData']);
	if (appAnimalStateData != null) {
		animal.appAnimalStateData = appAnimalStateData;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		animal.name = name;
	}
	final int? sex = jsonConvert.convert<int>(json['sex']);
	if (sex != null) {
		animal.sex = sex;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		animal.icon = icon;
	}
	final String? createDate = jsonConvert.convert<String>(json['createDate']);
	if (createDate != null) {
		animal.createDate = createDate;
	}
	final dynamic year = jsonConvert.convert<dynamic>(json['year']);
	if (year != null) {
		animal.year = year;
	}
	final dynamic s1 = jsonConvert.convert<dynamic>(json['s1']);
	if (s1 != null) {
		animal.s1 = s1;
	}
	final dynamic s2 = jsonConvert.convert<dynamic>(json['s2']);
	if (s2 != null) {
		animal.s2 = s2;
	}
	final AnimalState? appAnimalState = jsonConvert.convert<AnimalState>(json['appAnimalState']);
	if (appAnimalState != null) {
		animal.appAnimalState = appAnimalState;
	}
	return animal;
}

Map<String, dynamic> $AnimalToJson(Animal entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['sid'] = entity.sid;
	data['appAnimalStateData'] = entity.appAnimalStateData?.toJson();
	data['name'] = entity.name;
	data['sex'] = entity.sex;
	data['icon'] = entity.icon;
	data['createDate'] = entity.createDate;
	data['year'] = entity.year;
	data['s1'] = entity.s1;
	data['s2'] = entity.s2;
	data['appAnimalState'] = entity.appAnimalState?.toJson();
	return data;
}