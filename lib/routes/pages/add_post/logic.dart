import 'package:get/get.dart';
import 'package:take_it_home/models/concern.dart';
import 'package:take_it_home/models/post.dart';
import 'package:take_it_home/models/topic.dart';

import '../../../common/API.dart';
import '../../../common/Git.dart';
import '../../../models/animal.dart';
import '../../../models/animal_state.dart';
import '../../../models/base_bean.dart';
import '../../../models/post_type.dart';
import 'state.dart';

class AddPostLogic extends GetxController {
  final AddPostState state = AddPostState();

  Future<List<PostType>?> getPostTypeList([Map<String,dynamic>? data,int? pageSize,int? pageNum]) async{
    BaseBean<PostType> bean = await Git.getList<PostType>(API.postType);
    state.postTypeList = bean.rows!;
  }

  Future<List<Topic>?> getTopicList(String title) async{
    BaseBean<Topic> bean = await Git.getList<Topic>(API.topic,data: {"title":title});
    state.topicList = bean.rows!;
  }

  Future<List<AnimalState>?> getAnimalState({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<AnimalState> bean = await Git.getList<AnimalState>(API.animal_state,data: data,pageNum: pageNum,pageSize: pageSize);
    if(bean.rows!=null){
      bean.rows!.forEach((element) {
        if(element.appAnimal!=null){
          state.animalList.add(element.appAnimal!);
        }
      });
    }
  }
  Future<List<Concern>?> getConcernList({Map<String,dynamic>? data,int? pageSize,int? pageNum}) async{
    BaseBean<Concern> bean = await Git.getList<Concern>(API.concern,data:data,pageSize: 100,pageNum: 0);
    bean.rows!.forEach((element) {
      if(element.toAid!=null){
        state.animalList.add(element.appAnimal!);
      }
    });
  }

  Future<BaseBean> addPost(Post post) async{
    BaseBean bean = await Git.add(API.post,post.toJson());
    return bean;
  }


  Future getAllAnimalList(int id) async{
    return await getConcernList(data: {"uid":id}).then((value){
      Future.wait([
        getAnimalState(data: {"uid":id}),
        getAnimalState(data: {"hid":id}),
        getAnimalState(data: {"bid":id}),
      ]).then((value){
        final ids = state.animalList.map((e) => e.id).toSet();
        state.animalList.retainWhere((x) => ids.remove(x.id));
      });
    });
  }

}
