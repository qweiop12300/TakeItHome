import 'package:take_it_home/generated/json/base/json_field.dart';
import 'package:take_it_home/generated/json/animal_state_data.g.dart';
import 'dart:convert';

@JsonSerializable()
class AnimalStateData {
	late int id;
	late String title;
	dynamic s1;

	AnimalStateData();

	factory AnimalStateData.fromJson(Map<String, dynamic> json) => $AnimalStateDataFromJson(json);

	Map<String, dynamic> toJson() => $AnimalStateDataToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}