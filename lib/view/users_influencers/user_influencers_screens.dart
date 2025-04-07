

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/data/model/influencer_model.dart';
import 'package:post_krakren_dashboard/view_model/influencer_viewmodel.dart';

class UsersInfluencersScreen extends StatelessWidget {
  final InfluencerViewmodel _viewModel = Get.put(InfluencerViewmodel());

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (_viewModel.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (_viewModel.error.value.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${_viewModel.error.value}'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _viewModel.fetchUsers,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(isMobile),
                Expanded(
                  child: _buildUserDataTable(isMobile, _viewModel.influencers),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildHeader(bool isMobile) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Users",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      // Implement search functionality if needed
                    },
                  ),
                )
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Influencers",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search users...",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      // Implement search functionality if needed
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildUserDataTable(bool isMobile, List<InfluencerModel> influencers) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Container(
            width: constraints.maxWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: isMobile
                        ? constraints.maxWidth
                        : constraints.maxWidth - 32,
                  ),
                  child: DataTable(
                    columnSpacing: 16,
                    dataRowHeight: 64,
                    headingRowHeight: 56,
                    horizontalMargin: 16,
                    dividerThickness: 1,
                    showCheckboxColumn: !isMobile,
                    columns: [
                      if (!isMobile) DataColumn(label: _buildHeaderCell("ID")),
                      DataColumn(label: _buildHeaderCell("Name")),
                      if (!isMobile)
                        DataColumn(label: _buildHeaderCell("Email")),
                      DataColumn(label: _buildHeaderCell("Role")),
                      // DataColumn(label: _buildHeaderCell("Followers")),
                      DataColumn(label: _buildHeaderCell("Action")),
                    ],
                    rows: influencers.map((influencer) => DataRow(
                      cells: [
                        if (!isMobile)
                          DataCell(_buildDataCell(influencer.id.toString() ?? 'N/A')),
                        DataCell(_buildDataCell(influencer.name ?? 'Unknown')),
                        if (!isMobile)
                          DataCell(_buildDataCell(influencer.email ?? 'N/A')),
                        DataCell(_buildDataCell(
                            influencer.role??"user" )),
                        // DataCell(_buildDataCell(
                        //     influencer.followers?.toString() ?? '0')),
                        DataCell(
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _showDeleteDialog(influencer);
                            },
                          ),
                        ),
                      ],
                    )).toList(),
                    dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue[100];
                        }
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.grey[100];
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteDialog(InfluencerModel influencer) {
    Get.defaultDialog(
      title: 'Delete User',
      content: Text('Are you sure you want to delete ${influencer.name}?'),
      confirm: ElevatedButton(
        onPressed: () {
          // Call delete API here
          
          Get.back();
          Get.snackbar('Success', 'User deleted successfully');
        },
        child: Text('Delete'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('Cancel'),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}