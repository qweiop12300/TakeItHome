import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

import '../../../models/post.dart';

class VideoViewState {
  VideoViewState() {
    ///Initialize variables
  }

  late int index=0;

  late bool isLoading = true;

  late List<Post> postList;

  late ScrollController scrollController;
}
