import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/components/index.dart';
import 'package:post_krakren_dashboard/data/model/influencer_model.dart';
import 'package:post_krakren_dashboard/view_model/influencer_viewmodel.dart';

class UsersInfluencersScreen extends StatelessWidget {
  final InfluencerViewmodel _viewModel = Get.put(InfluencerViewmodel());
  final ScrollController _verticalController = ScrollController();

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(isMobile),
              // Expanded(child: _buildUserDataTable(isMobile, _viewModel.influencers)),
              Expanded(
                  child: _buildUserDataTable(
                      isMobile, _viewModel.filteredInfluencers)),
            ],
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
                Text("Users",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                _buildSearchField(double.infinity),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Influencers",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                _buildSearchField(300),
              ],
            ),
    );
  }

  Widget _buildSearchField(double width) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        onChanged: (value) {
          _viewModel.searchQuery.value = value;
        },
        decoration: InputDecoration(
          hintText: "Search users...",
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }

  Widget _buildUserDataTable(bool isMobile, List<InfluencerModel> influencers) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Scrollbar(
        controller: _verticalController,
        child: SingleChildScrollView(
          controller: _verticalController,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(Get.context!).size.width),
              child: DataTable(
                columnSpacing: 24,
                dataRowHeight: 64,
                headingRowHeight: 56,
                horizontalMargin: 66,
                dividerThickness: 1,
                showCheckboxColumn: !isMobile,
                columns: [
                  if (!isMobile) DataColumn(label: _buildHeaderCell("ID")),
                  DataColumn(label: _buildHeaderCell("Name")),
                  if (!isMobile) DataColumn(label: _buildHeaderCell("Email")),
                  DataColumn(label: _buildHeaderCell("Role")),
                  DataColumn(label: _buildHeaderCell("Action")),
                ],
                rows: influencers.map((influencer) {
                  return DataRow(
                    cells: [
                      if (!isMobile)
                        DataCell(_buildDataCell(influencer.id.toString())),
                      DataCell(_buildDataCell(influencer.name ?? 'Unknown')),
                      if (!isMobile)
                        DataCell(_buildDataCell(influencer.email ?? 'N/A')),
                      DataCell(Row(
                        children: [
                          Expanded(child: Text(influencer.role ?? "user")),
                          IconButton(
                            icon: Icon(Icons.edit,
                                size: 20, color: AppColors.black),
                            onPressed: () => _showRoleEditDialog(influencer),
                          ),
                        ],
                      )),
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete, color: AppColors.appColor),
                          onPressed: () => _showDeleteDialog(influencer),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                dataRowColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected))
                      return Colors.blue[100];
                    if (states.contains(WidgetState.hovered))
                      return Colors.grey[100];
                    return null;
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(InfluencerModel influencer) {
    Get.defaultDialog(
      title: 'Delete User',
      content: Text('Are you sure you want to delete ${influencer.name}?'),
      confirm: ElevatedButton(
        onPressed: () {
          _viewModel.deleteUser(influencer.id);
          Get.back();
          Get.snackbar('Success', 'User deleted successfully');
        },
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.appColor),
        child: Text('Delete', style: TextStyle(color: Colors.white)),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: Text('Cancel', style: TextStyle(color: Colors.black)),
      ),
    );
  }

  void _showRoleEditDialog(InfluencerModel influencer) {
    RxString selectedRole = (influencer.role ?? 'user').obs;

    Get.defaultDialog(
      title: 'Edit Role',
      content: Column(
        children: [
          Obx(() => DropdownButton<String>(
                value: selectedRole.value,
                onChanged: (value) {
                  if (value != null) {
                    selectedRole.value = value;
                  }
                },
                items: ['user', 'influencer'].map((role) {
                  return DropdownMenuItem(value: role, child: Text(role));
                }).toList(),
              )),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _viewModel.updateUserRole(influencer.id, selectedRole.value);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.black),
            child: Text('Update', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(text, overflow: TextOverflow.ellipsis),
    );
  }
}
