import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Util.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/models/sys_user.dart';

import '../../../common/Global.dart';
import '../../../models/concern.dart';
import 'state.dart';

class MineViewLogic extends GetxController {
  final MineViewState state = MineViewState();


  Future<void> getUserInfo() async{
    if(Global.profile.value.userLogin!.sysUser!=null){
      state.sysUser = Global.profile.value.userLogin!.sysUser!;
    }else{
      BaseBean<SysUser> baseBean = await Git.getUserInfo();
      state.sysUser = baseBean.data!;
    }
  }

  Future<List<AnimalState>?> getAnimalState({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<AnimalState> bean = await Git.getList<AnimalState>(API.animal_state,data: data,pageNum: pageNum,pageSize: pageSize);
    if(bean.rows!=null){
      state.animalStatelist.addAll(bean.rows!);
    }
  }

  Future getNum(Function fun) async{
    Git.getList<Concern>(API.concern,data: {"uid":state.sysUser.userId}).then((value){
      state.num2=value.total!;
      Git.getList<Concern>(API.concern,data: {"toUid":state.sysUser.userId}).then((value){
        state.num3=value.total!;
        Git.getList<Post>(API.post,data: {"uid":state.sysUser.userId}).then((value){
          state.num1=value.total!;
          fun();
        });
      });
    });
  }

}

