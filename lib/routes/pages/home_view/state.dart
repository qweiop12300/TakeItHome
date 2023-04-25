import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/head.dart';
import 'package:take_it_home/models/topic.dart';

import '../../../models/post.dart';
import '../../../models/post_type.dart';

class HomeViewState {
  HomeViewState() {
    ///Initialize variables
  }

  late List<PostType> postTypeList = [];

  late List<Head> headList = [];

  late List<Post> postList = [];

  late List<Animal> animalList = [];

  late List<Topic> topicList = [];

  bool isLoading = true;
}
