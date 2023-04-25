import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/animal_state_data.dart';

AnimalStateData $AnimalStateDataFromJson(Map<String, dynamic> json) {
	final AnimalStateData animalStateData = AnimalStateData();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		animalStateData.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		animalStateData.title = title;
	}
	final dynamic s1 = jsonConvert.convert<dynamic>(json['s1']);
	if (s1 != null) {
		animalStateData.s1 = s1;
	}
	return animalStateData;
}

Map<String, dynamic> $AnimalStateDataToJson(AnimalStateData entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['s1'] = entity.s1;
	return data;
}