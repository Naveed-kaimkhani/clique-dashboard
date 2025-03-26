


// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:post_krakren_dashboard/view/products_screen/products_screen.dart';

// class VideoWidget extends StatelessWidget {
//   final Product product;

//   const VideoWidget({Key? key, required this.product}) : super(key: key);

//   void _showVideoPopup(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//           child: VideoPlayerScreen(videoUrl: product.videoUrl),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 200,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 5,
//             spreadRadius: 1,
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.all(6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: () => _showVideoPopup(context),
//             child: Image.asset(
//               product.image,
//               fit: BoxFit.cover,
//             ),
//           ),
//           SizedBox(height: 6),
//           Text(
//             product.title,
//             style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
//             maxLines: 2,
//           ),
//           SizedBox(height: 4),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               TextButton.icon(
//                 icon: Icon(Icons.check_circle, color: Colors.green, size: 18),
//                 label: Text("Approve", style: TextStyle(fontSize: 12)),
//                 onPressed: () => print("Approved: ${product.title}"),
//               ),
//               TextButton.icon(
//                 icon: Icon(Icons.cancel, color: Colors.red, size: 18),
//                 label: Text("Reject", style: TextStyle(fontSize: 12)),
//                 onPressed: () => print("Rejected: ${product.title}"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class VideoPlayerScreen extends StatefulWidget {
//   final String videoUrl;

//   const VideoPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

//   @override
//   _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
// }

// class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       width: 300,
//       height: 250,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : CircularProgressIndicator(),
//           SizedBox(height: 10),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               IconButton(
//                 icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
//                 onPressed: () {
//                   setState(() {
//                     _controller.value.isPlaying ? _controller.pause() : _controller.play();
//                   });
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
