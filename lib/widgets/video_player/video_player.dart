import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerScreen extends StatefulWidget {

  final String title;
  final String url;

  const VideoPlayerScreen({Key key, this.title, this.url}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool isPlaying = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      this.widget.url,
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.only(right: 5,bottom: 15, top: 15),
                      child: RawMaterialButton(
                        onPressed: () {
                          setState(() {
                            if (_controller.value.isPlaying) {
                              _controller.pause();

                            } else {
                              _controller.play();
                            }
                            isPlaying = !isPlaying;
                          });
                        },
                        elevation: 2.0,
                        fillColor: Colors.white,
                        child: Icon(
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 35.0,
                        ),
                        padding: EdgeInsets.all(15.0),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ],
              ),

            ),
          ],
        ),
    );
  }
}