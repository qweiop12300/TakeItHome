import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/post_type.dart';

PostType $PostTypeFromJson(Map<String, dynamic> json) {
	final PostType postType = PostType();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		postType.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		postType.name = name;
	}
	final String? icon = jsonConvert.convert<String>(json['icon']);
	if (icon != null) {
		postType.icon = icon;
	}
	return postType;
}

Map<String, dynamic> $PostTypeToJson(PostType entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['icon'] = entity.icon;
	return data;
}