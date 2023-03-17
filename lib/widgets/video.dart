import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:take_it_home/widgets/loading.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
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


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        child:Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.only(bottomLeft: Radius.circular(10.0)),
              color:  Colors.black,
            ),
              alignment: Alignment.center,
              child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child:isLoading?Loading():VideoPlayer(_controller)
              ),
            ),
        onTap: (){
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        },
      )
      ;
  }

}