import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class MessageViewPage extends StatelessWidget {
  final logic = Get.put(MessageViewLogic());
  final state = Get.find<MessageViewLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
