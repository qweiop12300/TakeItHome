import 'package:take_it_home/models/head.dart';

import '../../../models/post.dart';
import '../../../models/post_type.dart';

class HomeViewState {
  HomeViewState() {
    ///Initialize variables
  }

  late List<PostType> postTypeList;

  late List<Head> headList;

  late List<Post> postList;

  bool isLoading = true;
}
