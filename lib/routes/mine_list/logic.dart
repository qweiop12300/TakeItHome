import 'package:get/get.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../models/base_bean.dart';
import '../../models/post.dart';
import 'state.dart';

class MineListLogic extends GetxController {
  final MineListState state = MineListState();

  Future<List<Post>?> getPostList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: {"typeId":1,"urgent":0});
    return bean.rows!;
  }
}
