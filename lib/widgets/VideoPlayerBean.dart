import 'package:flutter/cupertino.dart';

class VideoPlayerBean extends InheritedWidget {
  VideoPlayerBean({
    Key? key,
    required this.url,
    required Widget child,
  }) : super(key: key, child: child);

  final String url;


  //定义一个便捷方法，方便子树中的widget获取共享数据
  static VideoPlayerBean? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoPlayerBean>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget重新build
  @override
  bool updateShouldNotify(VideoPlayerBean old) {
    return true;
  }

}