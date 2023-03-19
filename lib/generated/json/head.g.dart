import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/head.dart';
import 'package:take_it_home/models/post.dart';


Head $HeadFromJson(Map<String, dynamic> json) {
	final Head head = Head();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		head.id = id;
	}
	final int? pid = jsonConvert.convert<int>(json['pid']);
	if (pid != null) {
		head.pid = pid;
	}
	final Post? post = jsonConvert.convert<Post>(json['post']);
	if (post != null) {
		head.post = post;
	}
	return head;
}

Map<String, dynamic> $HeadToJson(Head entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['pid'] = entity.pid;
	data['post'] = entity.post?.toJson();
	return data;
}