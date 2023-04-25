import 'package:get/get.dart';
import 'package:take_it_home/models/post.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../models/base_bean.dart';
import '../../models/like.dart';
import '../../models/topic.dart';
import 'state.dart';

class TopicLogic extends GetxController {
  final TopicState state = TopicState();

  Future<void> getInfo(String id) async{
    BaseBean<Topic> bean = await Git.getInfo<Topic>(API.topic, int.parse(id));
    state.topic = bean.data!;
  }

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data);
    state.postList = bean.rows!;
  }

  Future<BaseBean?> add(String url,int pid) async{
    BaseBean bean = await Git.add(url,(Like()..pid=pid).toJson());
    update();
    return bean;
  }
}
