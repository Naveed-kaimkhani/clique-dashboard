
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/gradient_text.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:post_krakren_dashboard/models/Ppopstream_model.dart';
import 'package:post_krakren_dashboard/video_popup_player.dart';
import 'package:post_krakren_dashboard/view_model/popstream_viewmodel.dart';

class DeletePopstream extends StatelessWidget {
  final PopstreamController viewModel = 
  Get.isRegistered<PopstreamController>()
      ? Get.find<PopstreamController>()
      : Get.put(PopstreamController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        if (viewModel.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (viewModel.error.value.isNotEmpty) {
          return Center(child: Text(viewModel.error.value));
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth < 600 ? 12 : 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 24),
                    _buildRequestGrid(context),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 600;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GradientText(
              "Approve or Reject Videos",
              gradient: AppColors.appGradientColors,
              fontSize: isSmallScreen ? 22 : 28,
            ),
            const SizedBox(height: 16),
            _buildSearchBar(isSmallScreen, constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(bool isSmallScreen, double maxWidth) {
    return SizedBox(
      width: isSmallScreen ? double.infinity : maxWidth * 0.5,
      height: 48,
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search videos...",
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildRequestGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

        // Responsive grid configuration
        int crossAxisCount;
        if (screenWidth < 500) {
          crossAxisCount = 1;
        } else if (screenWidth < 800) {
          crossAxisCount = 2;
        } else if (screenWidth < 1200) {
          crossAxisCount = 3;
        } else {
          crossAxisCount = 4;
        }

        if (viewModel.popstreams.isEmpty) {
          return Center(child: Text("No popstream available"));
        } else {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: viewModel.popstreams.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _getAspectRatio(screenWidth),
            ),
            itemBuilder: (context, index) {
              return RequestCard(
                request: viewModel.popstreams[index],
              );
            },
          );
        }
      },
    );
  }

  double _getAspectRatio(double screenWidth) {
    if (screenWidth < 500) return 1.1;
    if (screenWidth < 800) return 1.0;
    return 0.95;
  }
}

class RequestCard extends StatelessWidget {
  final PopstreamModel request;
  // final VoidCallback onApprove;
  // final VoidCallback onReject;

  const RequestCard({
    required this.request,
    // required this.onApprove,
    // required this.onReject,
    Key? key,
  }) : super(key: key);

  Widget _buildNetworkImage(String thumbnailUrl) {
    try {
      return Image(
        image: CachedNetworkImageProvider(
          request.consultantIds,
          headers: {
            'Accept': 'image/*',
            // Add any required headers
          },
        ),
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.grey[200],
            child: Icon(Icons.error),
          );
        },
      );
    } catch (e) {
      return Container(
        color: Colors.grey[200],
        child: Icon(Icons.broken_image),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 200;

        return Card(
          color: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: request.consultantIds != null &&
                                request.consultantIds.isNotEmpty
                            ? _buildNetworkImage(request.consultantIds)
                            : Container(
                                color: Colors.grey[200],
                                child: Icon(Icons.broken_image),
                              ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(16),
                      child: IconButton(
                          icon: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 40,
                          ),
                          // Icons.play_arrow,
                          color: Colors.white,
                          onPressed: () {
                            if (request.videoUrl != null &&
                                request.videoUrl!.isNotEmpty) {
                                  log(request.videoUrl);
                              _showVideoPopup(context, request.videoUrl);
                            } else {
                              // Handle the case when videoUrl is null or empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('No video available')),
                              );
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  request.name ?? "",
                  style: TextStyle(
                    fontSize: isSmallScreen ? 14 : 16,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Created by: ${request.createdBy}',
                  style: TextStyle(
                    fontSize: isSmallScreen ? 12 : 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 18),
                _buildButtonRow(isSmallScreen,request.id),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showVideoPopup(BuildContext context, String videoUrl) {
    // final fullVideoUrl = 'https://cactisocial.com/api-clique$videoUrl';
log("video url");
log(videoUrl);
    showDialog(
      context: context,
      builder: (context) => VideoPlayerScreen(videoUrl: videoUrl),
      barrierColor: Colors.black87,
    );
  }

Widget _buildButtonRow(bool isSmallScreen, String popstreamId) {
  final popstreamController = Get.find<PopstreamController>();

  return SizedBox(
    height: 80,
    child: Column(
      children: [
        Obx(() => _buildActionButton(
              icon: Icons.delete,
              label: popstreamController.isLoading.value ? "Deleting..." : "Delete Popstream",
              color: AppColors.appColor,
              onPressed: popstreamController.isLoading.value
                  ? null
                  : () => popstreamController.deletePopstream(popstreamId),
              isSmallScreen: isSmallScreen,
            )),
        const SizedBox(height: 8),
      ],
    ),
  );
}

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onPressed,
    required bool isSmallScreen,
  }) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: isSmallScreen ? 16 : 18,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: isSmallScreen ? 12 : 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
