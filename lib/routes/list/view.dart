import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class ListPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListPageState();
  }
}

class ListPageState extends State<ListPage>{
  final logic = Get.put(ListLogic());
  final state = Get.find<ListLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
