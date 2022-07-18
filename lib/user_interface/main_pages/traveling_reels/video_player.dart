/* import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String url;
  const VideoPlayerItem({Key key, @required this.url}) : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController vcontroller;

  @override
  void initState() {
    super.initState();
    vcontroller = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        vcontroller.play();
        vcontroller.setVolume(1);
      });
  }

  @override
  void dispose() {
    super.dispose();
    vcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 100.h,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: VideoPlayer(vcontroller),
    );
  }
}
 */