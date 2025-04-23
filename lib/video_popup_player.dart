import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:video_player/video_player.dart';

// class VideoPopupPlayer extends StatefulWidget {
//   final String videoUrl;

//   const VideoPopupPlayer({required this.videoUrl});

//   @override
//   _VideoPopupPlayerState createState() => _VideoPopupPlayerState();
// }

// class _VideoPopupPlayerState extends State<VideoPopupPlayer> {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   bool _isInitializing = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _initializePlayer();
//   }

//   Future<void> _initializePlayer() async {
//     try {
//      _videoPlayerController = VideoPlayerController.networkUrl(
//         Uri.parse(widget.videoUrl),
//       );
//       await _videoPlayerController.initialize();

//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController,
//         autoPlay: true,
//         looping: false,
//         aspectRatio: 16 / 9,
//         placeholder: Container(color: Colors.black),
//         materialProgressColors: ChewieProgressColors(
//           playedColor: AppColors.approveButtonColor,
//           handleColor: Colors.white,
//           backgroundColor: Colors.grey,
//           bufferedColor: Colors.grey[300]!,
//         ),
//         allowFullScreen: true,
//         allowMuting: true,
//         showControls: true,
//         customControls: const CupertinoControls(
//           backgroundColor: Colors.transparent,
//           iconColor: Colors.white,
//         ),
//         errorBuilder: (context, errorMessage) {
//           return Center(
//             child: Text(
//               errorMessage,
//               style: TextStyle(color: Colors.white),
//             ),
//           );
//         },
//       );
//     } catch (e) {
//       _errorMessage = 'Failed to load video: ${e.toString()}';
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isInitializing = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.all(20),
//       child: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(16),
//               color: Colors.black,
//             ),
//             padding: EdgeInsets.all(8),
//             child: AspectRatio(
//               aspectRatio: 16 / 9,
//               child: _buildVideoContent(),
//             ),
//           ),
//           Positioned(
//             top: 8,
//             right: 8,
//             child: IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVideoContent() {
//     if (_isInitializing) {
//       return Center(child: CircularProgressIndicator());
//     }

//     if (_errorMessage != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error_outline, color: Colors.white, size: 40),
//             SizedBox(height: 10),
//             Text(
//               _errorMessage!,
//               style: TextStyle(color: Colors.white),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: _retryInitialization,
//               child: Text('Retry'),
//             ),
//           ],
//         ),
//       );
//     }

//     if (_chewieController != null && 
//         _chewieController!.videoPlayerController.value.isInitialized) {
//       return Chewie(controller: _chewieController!);
//     }

//     return Center(child: Text('Video not available', style: TextStyle(color: Colors.white)));
//   }

//   Future<void> _retryInitialization() async {
//     if (mounted) {
//       setState(() {
//         _isInitializing = true;
//         _errorMessage = null;
//       });
//     }
//     await _initializePlayer();
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPopup extends StatefulWidget {
  final String videoUrl;

  const VideoPopup({super.key, required this.videoUrl});

  @override
  _VideoPopupState createState() => _VideoPopupState();
}

class _VideoPopupState extends State<VideoPopup> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.7),
      child: Center(
        child: _controller.value.isInitialized
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    if (isPlaying) {
                      _controller.pause();
                    } else {
                      _controller.play();
                    }
                    isPlaying = !isPlaying;
                  });
                },
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class VideoView extends StatelessWidget {
  final List<String> videoUrls;

  const VideoView({super.key, required this.videoUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Show video popup on tap
              showDialog(
                context: context,
                builder: (context) => VideoPopup(videoUrl: videoUrls[index]),
              );
            },
            child: Container(
              margin: const EdgeInsets.all(10),
              color: Colors.grey,
              height: 200,
              child: Center(child: Text("Tap to play video")),
            ),
          );
        },
      ),
    );
  }
}
