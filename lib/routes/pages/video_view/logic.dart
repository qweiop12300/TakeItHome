import 'package:get/get.dart';
import 'package:take_it_home/models/concern.dart';
import 'package:take_it_home/models/like.dart';
import 'package:take_it_home/models/post.dart';

import '../../../common/API.dart';
import '../../../common/Git.dart';
import '../../../models/base_bean.dart';
import 'state.dart';

class VideoViewLogic extends GetxController {
  final VideoViewState state = VideoViewState();

  Future<List<Post>?> getPostList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: {"video":"/"});
    state.postList = bean.rows!;
  }

  Future<BaseBean?> add(String url,int pid) async{
    BaseBean bean = await Git.add(url,(Like()..pid=pid).toJson());
    return bean;
  }

  Future<BaseBean?> concern(String url,int to_uid) async{
    BaseBean bean = await Git.add(url,(Concern()..toUid=to_uid).toJson());
    return bean;
  }




}
