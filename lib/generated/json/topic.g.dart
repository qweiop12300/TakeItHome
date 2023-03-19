import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/topic.dart';

Topic $TopicFromJson(Map<String, dynamic> json) {
	final Topic topic = Topic();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		topic.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		topic.title = title;
	}
	return topic;
}

Map<String, dynamic> $TopicToJson(Topic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	return data;
}