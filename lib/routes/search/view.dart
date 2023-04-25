import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/post_list_view.dart';
import 'logic.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SearchPageState();
  }

}

class SearchPageState extends State<SearchPage>{

  final logic = Get.put(SearchLogic());
  final state = Get.find<SearchLogic>().state;

  TextEditingController _titleController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          focusNode: focusNode,
          autofocus: true,
          controller: _titleController, //设置controller
          decoration: InputDecoration(
              hintText: "请输入搜索内容",
          ),
        ),
      ),
      body:state.postList==null?SizedBox():
      CustomScrollView(
        slivers: <Widget>[
          PostListViewBuilder(posts: state.postList!, withShadow: false,isComplete: false),
        ],
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  void initState() {
    focusNode.addListener(() {
      if(focusNode.hasFocus==false){
        logic.getPostList(data: {"title":_titleController.text}).then((value){
          setState(() {

          });
        });
      }
    });
  }
}
