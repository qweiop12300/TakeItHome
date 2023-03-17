import 'package:get/get.dart';
import 'package:take_it_home/models/head.dart';

import '../../../common/API.dart';
import '../../../common/Git.dart';
import '../../../models/base_bean.dart';
import '../../../models/post.dart';
import '../../../models/post_type.dart';
import 'state.dart';

class HomeViewLogic extends GetxController {
  final HomeViewState state = HomeViewState();

  Future<List<PostType>?> getPostTypeList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<PostType> bean = await Git.getList<PostType>(API.postType);
    state.postTypeList = bean.rows!;
  }

  Future<List<Head>?> getHeadList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<Head> bean = await Git.getList<Head>(API.head);
    state.headList = bean.rows!;
  }

  Future<List<Post>?> getPostList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,{"typeId":1,"urgent":0});
    state.postList = bean.rows!;
  }

}
