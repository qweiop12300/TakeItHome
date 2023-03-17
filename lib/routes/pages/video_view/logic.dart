import 'package:get/get.dart';
import 'package:take_it_home/models/post.dart';

import '../../../common/API.dart';
import '../../../common/Git.dart';
import '../../../models/base_bean.dart';
import 'state.dart';

class VideoViewLogic extends GetxController {
  final VideoViewState state = VideoViewState();

  Future<List<Post>?> getPostList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,{"video":"/"});
    state.postList = bean.rows!;
  }

}
