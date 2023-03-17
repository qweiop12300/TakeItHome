import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MineViewPage extends StatelessWidget {
  final logic = Get.put(MineViewLogic());
  final state = Get.find<MineViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
