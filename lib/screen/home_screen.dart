import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: video != null
          ? _VideoPlayer(
              video: video!,
            )
          : _VideoSelector(
              onLogoTap: onLogoTap,
            ),
    );
  }

  onLogoTap() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    setState(() {
      this.video = video;
    });
  }
}

class _VideoSelector extends StatelessWidget {
  final VoidCallback onLogoTap;

  const _VideoSelector({
    required this.onLogoTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2A3A7C),
              Color(0xFF000118),
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _Logo(
            onTap: onLogoTap,
          ),
          const SizedBox(
            height: 28,
          ),
          const _Title(),
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  final VoidCallback onTap;

  const _Logo({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        'asset/img/logo.png',
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w300,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          style: textStyle,
          'VIDEO',
        ),
        Text(
          style: textStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
          'PLAYER',
        ),
      ],
    );
  }
}

class _VideoPlayer extends StatefulWidget {
  final XFile video;

  const _VideoPlayer({
    required this.video,
    super.key,
  });

  @override
  State<_VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<_VideoPlayer> {
  late final VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    initializeController();
  }

  initializeController() async {
    videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );

    await videoPlayerController.initialize();

    videoPlayerController.addListener(() {
      setState(() {});
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
          aspectRatio: videoPlayerController.value.aspectRatio,
          child: Stack(
            children: [
              VideoPlayer(videoPlayerController),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          final currentPosition =
                              videoPlayerController.value.position;
                          Duration position = const Duration();

                          if (currentPosition.inSeconds > 3) {
                            position =
                                currentPosition - const Duration(seconds: 3);
                          }

                          videoPlayerController.seekTo(position);
                        },
                        icon: const Icon(Icons.rotate_left)),
                    IconButton(
                      color: Colors.white,
                      onPressed: () {
                        setState(() {
                          if (videoPlayerController.value.isPlaying) {
                            videoPlayerController.pause();
                          } else {
                            videoPlayerController.play();
                          }
                        });
                      },
                      icon: Icon(videoPlayerController.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow),
                    ),
                    IconButton(
                        color: Colors.white,
                        onPressed: () {
                          final maxPosition =
                              videoPlayerController.value.duration;
                          final currentPosition =
                              videoPlayerController.value.position;
                          Duration position = maxPosition;

                          if ((maxPosition - const Duration(seconds: 3))
                                  .inSeconds >
                              currentPosition.inSeconds) {
                            position =
                                currentPosition + const Duration(seconds: 3);
                          }

                          videoPlayerController.seekTo(position);
                        },
                        icon: const Icon(Icons.rotate_right)),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Slider(
                  max:
                      videoPlayerController.value.duration.inSeconds.toDouble(),
                  value:
                      videoPlayerController.value.position.inSeconds.toDouble(),
                  onChanged: (double val) {},
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  color: Colors.white,
                  onPressed: () {},
                  icon: const Icon(Icons.photo_camera_back),
                ),
              ),
            ],
          )),
    );
  }
}
