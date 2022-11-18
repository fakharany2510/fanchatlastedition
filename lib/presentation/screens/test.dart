import 'package:fanchat/business_logic/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class TestViedo extends StatefulWidget {
  const TestViedo({super.key});

  @override
  State<TestViedo> createState() => _TestViedoState();
}

class _TestViedoState extends State<TestViedo> {
  VideoPlayerController? videoPlayerController;
  Future<void>? intilize;
  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(
        AppCubit.get(context).posts.first.postVideo!);
    intilize = videoPlayerController!.initialize();
    videoPlayerController!.setLooping(true);
    videoPlayerController!.setVolume(1.0);

    super.initState();
    // print(videoPlayerController);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: Column(
          children: [
            FutureBuilder(
              future: intilize,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: videoPlayerController!.value.aspectRatio,
                    child: VideoPlayer(videoPlayerController!),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (videoPlayerController!.value.isPlaying) {
                      videoPlayerController!.pause();
                    } else {
                      videoPlayerController!.play();
                    }
                  });
                },
                icon: const Icon(Icons.add))
          ],
        ));
      },
    );
  }
}
