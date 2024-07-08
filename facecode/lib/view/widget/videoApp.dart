// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';

// import 'package:video_player/video_player.dart';

// class SamplePlayer extends StatefulWidget {
//   final String video;

//   SamplePlayer({Key? key, required this.video}) : super(key: key);

//   @override
//   _SamplePlayerState createState() => _SamplePlayerState();
// }

// class _SamplePlayerState extends State<SamplePlayer> {
//   late VideoPlayerController vpc;

//   @override
//   void initState() {
//     super.initState();
//     Uri videoUri = Uri.parse(widget.video); // Parse string URL to Uri object
//     vpc = VideoPlayerController.networkUrl(videoUri);
//     vpc.initialize().then((_) {
//       // Ensure the first frame is shown after the video is initialized
//       setState(() {});
//     });
//   }

//   @override
//   void dispose() {
//     vpc.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: AspectRatio(
//         aspectRatio: vpc.value.aspectRatio,
//         child: VideoPlayer(vpc),
//       ),
//     );
//   }
// }
