import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/common/Global.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/mymessage.dart';
import 'package:take_it_home/models/user_e.dart';

import '../../../common/API.dart';
import 'state.dart';

class MessageViewLogic extends GetxController {
  final MessageViewState state = MessageViewState();


  Future getUserList() async{
    BaseBean<UserE> bean = await Git.getUserList();
    state.userList = bean.rows;
  }


}
