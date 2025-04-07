import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPopupPlayer extends StatefulWidget {
  final String videoUrl;

  const VideoPopupPlayer({required this.videoUrl});

  @override
  _VideoPopupPlayerState createState() => _VideoPopupPlayerState();
}

class _VideoPopupPlayerState extends State<VideoPopupPlayer> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitializing = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
     _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      await _videoPlayerController.initialize();

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
        placeholder: Container(color: Colors.black),
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.approveButtonColor,
          handleColor: Colors.white,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.grey[300]!,
        ),
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        customControls: const CupertinoControls(
          backgroundColor: Colors.transparent,
          iconColor: Colors.white,
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Text(
              errorMessage,
              style: TextStyle(color: Colors.white),
            ),
          );
        },
      );
    } catch (e) {
      _errorMessage = 'Failed to load video: ${e.toString()}';
    } finally {
      if (mounted) {
        setState(() {
          _isInitializing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.all(20),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.black,
            ),
            padding: EdgeInsets.all(8),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _buildVideoContent(),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoContent() {
    if (_isInitializing) {
      return Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.white, size: 40),
            SizedBox(height: 10),
            Text(
              _errorMessage!,
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _retryInitialization,
              child: Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_chewieController != null && 
        _chewieController!.videoPlayerController.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }

    return Center(child: Text('Video not available', style: TextStyle(color: Colors.white)));
  }

  Future<void> _retryInitialization() async {
    if (mounted) {
      setState(() {
        _isInitializing = true;
        _errorMessage = null;
      });
    }
    await _initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }
}