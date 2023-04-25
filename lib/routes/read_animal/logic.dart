import 'package:get/get.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/animal_state.dart';

import '../../common/API.dart';
import '../../common/Git.dart';
import '../../models/base_bean.dart';
import '../../models/concern.dart';
import '../../models/like.dart';
import '../../models/post.dart';
import 'state.dart';

class ReadAnimalLogic extends GetxController {
  final ReadAnimalState state = ReadAnimalState();

  Future<void> getInfo(String id) async{
    BaseBean<AnimalState> bean = await Git.getInfo<AnimalState>(API.animal_state, int.parse(id));
    state.animalState = bean.data!;
  }

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data,pageNum: pageNum,pageSize: pageSize);
    state.postList = bean.rows!;
  }

  Future<BaseBean?> concern(String url,int to_uid) async{
    BaseBean bean = await Git.add(url,(Concern()..toAid=to_uid).toJson());
    return bean;
  }
}
