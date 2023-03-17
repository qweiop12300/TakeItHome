
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:take_it_home/routes/home/view.dart';
import 'package:take_it_home/routes/pages/home_view/view.dart';
import 'package:take_it_home/routes/pages/mine_view/view.dart';

class HomeState {
  HomeState() {
    ///Initialize variables
  }

  var index = 0.obs;

  late List<Widget?> page = [HomeViewPage(),null,null,null];
}
