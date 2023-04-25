import 'package:take_it_home/models/sys_user.dart';
import 'package:take_it_home/models/user_e.dart';

import '../../models/animal_state.dart';
import '../../models/post.dart';

class ReadUserState {
  ReadUserState() {
    ///Initialize variables
  }

  SysUser? sysUser;

  List<Post> postList=[];

  List<AnimalState> animalState=[];

}
