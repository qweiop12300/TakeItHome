import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:take_it_home/models/animal_state.dart';

import '../../../models/animal.dart';
import '../../../models/post_type.dart';
import '../../../models/topic.dart';

class AddPostState {
  AddPostState() {
    ///Initialize variables
  }

  Animal? animal;

  PostType? postType;

  List<Animal> animalList=[];

  List<PostType> postTypeList=[];

  List<Topic> topicList=[];

  Topic? topic;
}
