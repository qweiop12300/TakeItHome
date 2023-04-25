import 'package:take_it_home/generated/json/base/json_convert_content.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/models/animal.dart';

import 'package:take_it_home/models/topic.dart';

import 'package:take_it_home/models/like.dart';

import 'package:take_it_home/models/user_e.dart';

import '../../models/concern.dart';



Post $PostFromJson(Map<String, dynamic> json) {
	final Post post = Post();
	final int? id = jsonConvert.convert<int>(json['id']);
	if (id != null) {
		post.id = id;
	}
	final String? title = jsonConvert.convert<String>(json['title']);
	if (title != null) {
		post.title = title;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		post.content = content;
	}
	final dynamic image = jsonConvert.convert<dynamic>(json['image']);
	if (image != null) {
		post.image = image;
	}
	final dynamic video = jsonConvert.convert<dynamic>(json['video']);
	if (video != null) {
		post.video = video;
	}
	final dynamic createDate = jsonConvert.convert<dynamic>(json['createDate']);
	if (createDate != null) {
		post.createDate = createDate;
	}
	final dynamic updateDate = jsonConvert.convert<dynamic>(json['updateDate']);
	if (updateDate != null) {
		post.updateDate = updateDate;
	}
	final int? uid = jsonConvert.convert<int>(json['uid']);
	if (uid != null) {
		post.uid = uid;
	}
	final UserE? user = jsonConvert.convert<UserE>(json['user']);
	if (user != null) {
		post.user = user;
	}
	final dynamic tid = jsonConvert.convert<dynamic>(json['tid']);
	if (tid != null) {
		post.tid = tid;
	}
	final Topic? appTopic = jsonConvert.convert<Topic>(json['appTopic']);
	if (appTopic != null) {
		post.appTopic = appTopic;
	}
	final dynamic aid = jsonConvert.convert<dynamic>(json['aid']);
	if (aid != null) {
		post.aid = aid;
	}
	final Animal? appAnimal = jsonConvert.convert<Animal>(json['appAnimal']);
	if (appAnimal != null) {
		post.appAnimal = appAnimal;
	}
	final dynamic location = jsonConvert.convert<dynamic>(json['location']);
	if (location != null) {
		post.location = location;
	}
	final dynamic city = jsonConvert.convert<dynamic>(json['city']);
	if (city != null) {
		post.city = city;
	}
	final dynamic urgent = jsonConvert.convert<dynamic>(json['urgent']);
	if (urgent != null) {
		post.urgent = urgent;
	}
	final dynamic typeId = jsonConvert.convert<dynamic>(json['typeId']);
	if (typeId != null) {
		post.typeId = typeId;
	}
	final int? likeNumber = jsonConvert.convert<int>(json['likeNumber']);
	if (likeNumber != null) {
		post.likeNumber = likeNumber;
	}
	final int? collectionNumber = jsonConvert.convert<int>(json['collectionNumber']);
	if (collectionNumber != null) {
		post.collectionNumber = collectionNumber;
	}
	final int? commentsNumber = jsonConvert.convert<int>(json['commentsNumber']);
	if (commentsNumber != null) {
		post.commentsNumber = commentsNumber;
	}
	final dynamic url = jsonConvert.convert<dynamic>(json['url']);
	if (url != null) {
		post.url = url;
	}
	final dynamic s1 = jsonConvert.convert<dynamic>(json['s1']);
	if (s1 != null) {
		post.s1 = s1;
	}
	final Like? isLike = jsonConvert.convert<Like>(json['isLike']);
	if (isLike != null) {
		post.isLike = isLike;
	}
	final Like? isCollection = jsonConvert.convert<Like>(json['isCollection']);
	if (isCollection != null) {
		post.isCollection = isCollection;
	}
	final Concern? isConcern = jsonConvert.convert<Concern>(json['isConcern']);
	if (isConcern != null) {
		post.isConcern = isConcern;
	}
	return post;
}

Map<String, dynamic> $PostToJson(Post entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['title'] = entity.title;
	data['content'] = entity.content;
	data['image'] = entity.image;
	data['video'] = entity.video;
	data['createDate'] = entity.createDate;
	data['updateDate'] = entity.updateDate;
	data['uid'] = entity.uid;
	data['user'] = entity.user?.toJson();
	data['tid'] = entity.tid;
	data['appTopic'] = entity.appTopic?.toJson();
	data['aid'] = entity.aid;
	data['appAnimal'] = entity.appAnimal?.toJson();
	data['location'] = entity.location;
	data['city'] = entity.city;
	data['urgent'] = entity.urgent;
	data['typeId'] = entity.typeId;
	data['likeNumber'] = entity.likeNumber;
	data['collectionNumber'] = entity.collectionNumber;
	data['commentsNumber'] = entity.commentsNumber;
	data['url'] = entity.url;
	data['s1'] = entity.s1;
	data['isLike'] = entity.isLike?.toJson();
	data['isCollection'] = entity.isCollection?.toJson();
	data['isConcern'] = entity.isConcern?.toJson();
	return data;
}