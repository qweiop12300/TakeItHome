import 'package:take_it_home/widgets/VideoPlayer.dart'
if(dart.library.html) 'package:take_it_home/widgets/VideoPlayerAndroid.dart'
if(dart.library.io) 'package:take_it_home/widgets/VideoPlayerWindows.dart';
import '../../../models/post.dart';

class VideoViewState {
  VideoViewState() {
    ///Initialize variables
  }

  late bool isLoading = true;

  late List<Post> postList;

  late String url;
}
