import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:take_it_home/models/sys_user.dart';
import 'package:take_it_home/models/user_e.dart';

import 'state.dart';

class ChatLogic extends GetxController {
  final ChatState state = ChatState();

  Future getMyMessageList(int id) async{
    BaseBean<Mymessage> bean = await Git.getList<Mymessage>(API.message,data: {"uid":Global.profile.value.userLogin!.sysUser!.userId,"toUid":id});
    if(bean.rows!=null){
      state.myMessage.addAll(bean.rows!);
    }
  }

  Future getToMessageList(int id) async{
    BaseBean<Mymessage> bean = await Git.getList<Mymessage>(API.message,data: {"toUid":Global.profile.value.userLogin!.sysUser!.userId,"uid":id});
    if(bean.rows!=null){
      state.myMessage.addAll(bean.rows!);
    }
  }

  Future getUser(String id)async{
    BaseBean<SysUser> bean = await Git.getUserInfoV2(id);
    state.sysUser = bean.data;
  }

  Future<BaseBean> addMessage(Mymessage mymessage) async{
    BaseBean baseBean = await Git.add(API.message,mymessage.toJson()) ;
    return baseBean;
  }

  sort(){
    state.myMessage.sort((a,b){
      var d1 = DateTime.parse(a.createDate!);
      var d2 = DateTime.parse(b.createDate!);
      return d1.millisecondsSinceEpoch-d2.millisecondsSinceEpoch;
    });
  }

}
