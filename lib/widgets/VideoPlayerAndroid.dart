import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as Player;

import 'loading.dart';

class VideoPlayer extends StatefulWidget{

  const VideoPlayer({Key? key,required this.url}) : super(key: key);

  final String url;

  static void init() {
  }

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerState(url);
  }
}

class VideoPlayerState extends State<VideoPlayer>{

  VideoPlayerState(this.url);
  final String url;

  late Player.VideoPlayerController _controller;
  bool isLoading = true;


  @override
  void initState() {
    _controller = Player.VideoPlayerController.network(url);

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

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
            return
              AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child:Player.VideoPlayer(_controller)
              );
          })
      ),
      onTap: (){
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
    );
  }


}