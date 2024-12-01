import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../controllers/BorneController.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key,required this.videoUrl});
  final String videoUrl;

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  final BorneController controller = Get.find();
  late VideoPlayerController _videoPlayerController;
  late Future<void> _initializeVideoPlayerFuture;
  late CachedVideoPlayerPlusController cachedVideoPlayerPlusController;

  @override
  void initState() {
    /*_videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _initializeVideoPlayerFuture = _videoPlayerController.initialize().then((value) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(false);
      setState(() {});
    });*/

    cachedVideoPlayerPlusController = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse(widget.videoUrl),
      httpHeaders: {
        'Connection': 'keep-alive',
      },
      invalidateCacheIfOlderThan: const Duration(minutes: 10),
    )..initialize().then((value) async {
      await cachedVideoPlayerPlusController.setLooping(false);
      cachedVideoPlayerPlusController.play();
      setState(() {});
    });
    super.initState();
  }


  @override
  void dispose() {
    //_videoPlayerController.dispose();
    cachedVideoPlayerPlusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    /*return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context,snapshot){

          if(snapshot.connectionState == ConnectionState.done){
            return AspectRatio(
              aspectRatio:  2.0,
              child: CachedVideoPlayerPlus(cachedVideoPlayerPlusController) //VideoPlayer(_videoPlayerController),
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }

        }
    );*/
    return cachedVideoPlayerPlusController.value.isInitialized
          ? AspectRatio(
        aspectRatio: cachedVideoPlayerPlusController.value.aspectRatio,
        child: CachedVideoPlayerPlus(cachedVideoPlayerPlusController),
      )
          : const Center(child: CircularProgressIndicator());
  }
}
