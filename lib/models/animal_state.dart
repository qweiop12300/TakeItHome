import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/animal_state.g.dart';
import 'dart:convert';

import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/user_e.dart';

@JsonSerializable()
class AnimalState {
	int? id;
	int? aid;
	Animal? appAnimal;
	dynamic uid;
	UserE? usysUser;
	int? bid;
	UserE? bsysUser;
	int? hid;
	UserE? hsysUser;
	dynamic s1;

	AnimalState();

	factory AnimalState.fromJson(Map<String, dynamic> json) => $AnimalStateFromJson(json);

	Map<String, dynamic> toJson() => $AnimalStateToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}