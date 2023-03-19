import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/like.dart';

Like $LikeFromJson(Map<String, dynamic> json) {
	final Like like = Like();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		like.id = id;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		like.uid = uid;
	}
	final int? pid = jsonConvert.convert<int>(json['pid']);
	if (pid != null) {
		like.pid = pid;
	}
	final String? createDate = jsonConvert.convert<String>(json['createDate']);
	if (createDate != null) {
		like.createDate = createDate;
	}
	return like;
}

Map<String, dynamic> $LikeToJson(Like entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['uid'] = entity.uid;
	data['pid'] = entity.pid;
	data['createDate'] = entity.createDate;
	return data;
}