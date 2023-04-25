import 'dart:io';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:take_it_home/widgets/VideoPlayerAndroid.dart' as VPA;
import 'loading.dart';

class VideoPlayer extends StatefulWidget{

  static bool isWindows = Platform.isWindows||Platform.isLinux||Platform.isMacOS;

  const VideoPlayer({Key? key,required this.url}) : super(key: key);

  final String url;

  static void init() {
    if(isWindows){
      DartVLC.initialize();
    }
  }

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState(url);
  }
}

class VideoPlayerState extends State<VideoPlayer>{

  VideoPlayerState(this.url);
  final String url;

  bool isLoading = true;

  late Player player;


  @override
  void initState() {
    if(VideoPlayer.isWindows){
      player = Player(id:6940);
      setState((){
        isLoading = false;
      });
      player.open(
          Media.network(url),
          autoStart: true// default
      );
    }
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   print("dis");
  //   print(player);
  //   if(VideoPlayer.isWindows){
  //     if(player!=null){
  //       player.dispose();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return VideoPlayer.isWindows?GestureDetector(
      child:Container(
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.only(bottomLeft: Radius.circular(10.0)),
            color:  Colors.black,
          ),
          alignment: Alignment.center,
          child: isLoading?Loading():
          LayoutBuilder(builder: (context,par){
            return Video(
              player: player,
              scale: 1.0, // default
              showControls: false, // default
            );
          })
      ),
      onTap: (){
        player.playOrPause();
      },
    )
    :VPA.VideoPlayer(url: url);
  }

}