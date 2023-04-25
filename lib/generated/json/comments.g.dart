import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/comments.dart';
import 'package:take_it_home/models/user_e.dart';

import 'package:take_it_home/models/animal.dart';


Comments $CommentsFromJson(Map<String, dynamic> json) {
	final Comments comments = Comments();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		comments.id = id;
	}
	final dynamic toId = jsonConvert.convert<dynamic>(json['toId']);
	if (toId != null) {
		comments.toId = toId;
	}
	final int? pid = jsonConvert.convert<int>(json['pid']);
	if (pid != null) {
		comments.pid = pid;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		comments.content = content;
	}
	final dynamic image = jsonConvert.convert<dynamic>(json['image']);
	if (image != null) {
		comments.image = image;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		comments.uid = uid;
	}
	final UserE? user = jsonConvert.convert<UserE>(json['user']);
	if (user != null) {
		comments.user = user;
	}
	final dynamic aid = jsonConvert.convert<dynamic>(json['aid']);
	if (aid != null) {
		comments.aid = aid;
	}
	final Animal? appAnimal = jsonConvert.convert<Animal>(json['appAnimal']);
	if (appAnimal != null) {
		comments.appAnimal = appAnimal;
	}
	final dynamic likeNumber = jsonConvert.convert<dynamic>(json['likeNumber']);
	if (likeNumber != null) {
		comments.likeNumber = likeNumber;
	}
	final dynamic createDate = jsonConvert.convert<dynamic>(json['createDate']);
	if (createDate != null) {
		comments.createDate = createDate;
	}
	return comments;
}

Map<String, dynamic> $CommentsToJson(Comments entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['toId'] = entity.toId;
	data['pid'] = entity.pid;
	data['content'] = entity.content;
	data['image'] = entity.image;
	data['uid'] = entity.uid;
	data['user'] = entity.user?.toJson();
	data['aid'] = entity.aid;
	data['appAnimal'] = entity.appAnimal?.toJson();
	data['likeNumber'] = entity.likeNumber;
	data['createDate'] = entity.createDate;
	return data;
}