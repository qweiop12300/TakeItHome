import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/sys_user.dart';

class MineViewState {
  MineViewState() {
    ///Initialize variables
  }

  bool isLoading = true;

  late SysUser sysUser;

  List<AnimalState> animalStatelist = [];

  int num1=0;
  int num2=0;
  int num3=0;
}
