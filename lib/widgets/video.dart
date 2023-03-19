import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:video_player/video_player.dart';
import "dart:io";

class VideoView extends StatefulWidget{

  String url;
  VideoView(this.url);

  @override
  State<StatefulWidget> createState() {
    return VideoViewState(url);
  }

}

class VideoViewState extends State<VideoView>{
  String url;

  VideoViewState(this.url);

  late VideoPlayerController _controller;
  late bool isLoading = true;
  late bool isWindows = Platform.isWindows||Platform.isLinux;

  final player = Player(id: 69420);

  @override
  void initState() {
    if(isWindows){
      player.open(
        Media.network(url),
        autoStart: true, // default
      );
      setState((){
        isLoading = false;
      });

    }else{
      _controller = VideoPlayerController.network(
        url,
      );

      _controller.addListener(() {

      });
      _controller.setLooping(true);
      _controller.initialize().then((value) => {
        _controller.play()
      }).then((value) => {
        setState((){
          isLoading = false;
        })
      });
    }
  }


  @override
  void dispose() {
    super.dispose();
    if(isWindows){
      player.dispose();
    }else{
      _controller.dispose();
    }

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child:Container(
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.only(bottomLeft: Radius.circular(10.0)),
          color:  Colors.black,
        ),
        alignment: Alignment.center,
        child: isLoading?Loading():
            LayoutBuilder(builder: (context,par){
              if(isWindows){
                return Video(
                  player: player,
                  scale: 1.0, // default
                  showControls: false, // default
                );
              }else{
                return
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child:VideoPlayer(_controller)
                  );
              }
            })
        ),
      onTap: (){
        if(isWindows){
          player.playOrPause();
        }else{
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        }
      },
    );
  }

}