import 'package:take_it_home/models/post.dart';

import '../../models/comments.dart';

class ReadState {
  ReadState() {
    ///Initialize variables
  }

  bool isLoading = true;

  late Post post;

  late List<Comments> commentsList;


}
