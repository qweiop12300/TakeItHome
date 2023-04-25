import 'package:take_it_home/models/post_type.dart';

import '../../models/post.dart';

class ListState {
  ListState() {
    ///Initialize variables
  }

  bool isLoading = true;

  List<PostType>? postTypeList;

  List<Post>? postList;
}
