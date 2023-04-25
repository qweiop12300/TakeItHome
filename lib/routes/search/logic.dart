import 'package:get/get.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../models/base_bean.dart';
import '../../models/post.dart';
import 'state.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data,pageNum: pageNum,pageSize: pageSize);
    state.postList = bean.rows!;
  }
}
