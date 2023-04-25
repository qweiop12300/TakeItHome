
import 'package:flutter/widgets.dart';

import '../models/post.dart';
import '../models/comments.dart';

class MyNotification extends Notification {
  final NotificationType type;
  final int? index;
  final String? content;
  final Post? post;
  final Comments? comments;
  MyNotification(this.type,
  {this.index, this.content,this.post,this.comments});
}

enum NotificationType {
  postLike,
  postComments,
  postCollection,
  concern,
  pickImage
}