import 'package:get/get.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/animal.dart';
import 'package:take_it_home/models/animal_state.dart';
import 'package:take_it_home/models/animal_state_data.dart';
import 'package:take_it_home/models/base_bean.dart';

import '../../common/API.dart';
import 'state.dart';

class AddAnimalLogic extends GetxController {
  final AddAnimalState state = AddAnimalState();

  Future<BaseBean> addAnimal(Animal animal) async{
    return await Git.add(API.animal,animal.toJson());
  }

  Future<BaseBean> addAnimalState(AnimalState animal) async{
    return await Git.add(API.animal_state,animal.toJson());
  }

  Future getAnimalStateList() async{
    state.animalStateList = (await Git.getList<AnimalStateData>(API.animal_state_data)).rows!;
    state.animalStateData = state.animalStateList![0];
  }



}
