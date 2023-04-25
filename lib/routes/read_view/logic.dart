
import 'package:get/get.dart';
import 'package:take_it_home/common/API.dart';
import 'package:take_it_home/common/Git.dart';
import 'package:take_it_home/models/base_bean.dart';
import 'package:take_it_home/models/comments.dart';
import 'package:take_it_home/models/post.dart';

import 'state.dart';

class ReadLogic extends GetxController {
  final ReadState state = ReadState();

  getInfo(String id) async{
    BaseBean<Post> bean = await Git.getInfo<Post>(API.post, int.parse(id));
    state.post = bean.data!;
  }

  Future<BaseBean> likeComments(int id) async{
    BaseBean bean = await Git.add(API.likeComments, {"cid":id});
    return bean;
  }

  getComments(String id) async{
    BaseBean<Comments> bean = await Git.getList(API.comments,data: {"pid":int.parse(id)});
    List<Comments> list = [];
    bean.rows?.forEach((element) {
      if(element.toId==null){
        list.add(element);
      }
    });
    bean.rows?.forEach((element) {
      if(element.toId!=null){
        for(int i=0;i<list.length;i++){
          if(list[i].id == element.toId){
            element.content="@"+list[i].user!.nickName!+" "+element.content!;
            list.insert(i+1, element);
            break;
          }
        }
      }
    });

    state.commentsList = list;
  }
}
