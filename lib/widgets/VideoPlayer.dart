import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget{

  const VideoPlayer({Key? key,required this.url}) : super(key: key);

  final String url;

  static void init() {
  }

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState();
  }

}

class VideoPlayerState extends State<VideoPlayer>{


  checkVideo(int index){

  }

  updataList(List<String> list){

  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Text("?");
  }

}