

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/gradient_text.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';
import 'package:post_krakren_dashboard/view/videos_approval/request_card.dart';
import 'package:post_krakren_dashboard/view_model/videos_approval_viewModel.dart';

class VideosApprovalScreen extends StatelessWidget {
  final VideosApprovalViewModel viewModel = Get.put(VideosApprovalViewModel());
  final TextEditingController searchController = TextEditingController();

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
        controller: searchController,
        onChanged: (value) => viewModel.searchText.value = value,
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
    return Obx(() {
      final requests = viewModel.filteredRequests;

      if (requests.isEmpty) {
        return Center(child: Text("No matching videos found."));
      }

      return LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
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

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: requests.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: _getAspectRatio(screenWidth),
            ),
            itemBuilder: (context, index) {
              final request = requests[index];
              return RequestCard(
                request: request,
                onApprove: () => viewModel.approveRequest(request.id),
                onReject: () => viewModel.rejectRequest(request.id),
              );
            },
          );
        },
      );
    });
  }

  double _getAspectRatio(double screenWidth) {
    if (screenWidth < 500) return 1.1;
    if (screenWidth < 800) return 1.0;
    return 0.95;
  }
}