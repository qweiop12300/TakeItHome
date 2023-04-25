import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/sys_user.dart';

import '../../common/API.dart';
import '../../models/concern.dart';
import '../../models/post.dart';
import 'state.dart';

class ReadUserLogic extends GetxController {
  final ReadUserState state = ReadUserState();

  Future<void> getUserInfo(String id) async{
    BaseBean<SysUser> bean =await Git.getUserInfoV2(id);
    state.sysUser = bean.data;
  }

  Future<List<Post>?> getPostList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Post> bean = await Git.getList<Post>(API.post,data: data,pageNum: pageNum,pageSize: pageSize);
    state.postList = bean.rows!;

  }

  Future<List<AnimalState>?> getAnimalState({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<AnimalState> bean = await Git.getList<AnimalState>(API.animal_state,data: data,pageNum: pageNum,pageSize: pageSize);
    if(bean.rows!=null){
      state.animalState.addAll(bean.rows!);
    }
  }

  Future<BaseBean?> concern(String url,int to_uid) async{
    BaseBean bean = await Git.add(url,(Concern()..toUid=to_uid).toJson());
    return bean;
  }
}
