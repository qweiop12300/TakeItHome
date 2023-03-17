import 'package:get/get.dart';
import 'package:take_it_home/routes/home/state.dart';
import 'package:take_it_home/routes/pages/message_view/view.dart';
import 'package:take_it_home/routes/pages/video_view/view.dart';

import '../pages/mine_view/view.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  change(int index){
    if(state.page[index]==null){
      switch(index){
        case 1:state.page[1] = VideoViewPage();break;
        case 2:state.page[2] = MessageViewPage();break;
        case 3:state.page[3] = MineViewPage();break;
      }
    }
    state.index.value=index;
  }
}
