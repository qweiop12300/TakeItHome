import 'package:get/get.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../models/base_bean.dart';
import '../../models/like.dart';
import '../../models/post.dart';
import '../../models/post_type.dart';
import 'state.dart';

class ListLogic extends GetxController {
  final ListState state = ListState();

  Future<List<PostType>?> getPostTypeList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<PostType> bean = await Git.getList<PostType>(API.postType);
    state.postTypeList = bean.rows!;
  }

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data,pageNum: pageNum,pageSize: pageSize);
    state.postList = bean.rows!;
  }

  Future<BaseBean?> add(String url,int pid) async{
    BaseBean bean = await Git.add(url,(Like()..pid=pid).toJson());
    update();
    return bean;
  }
}
