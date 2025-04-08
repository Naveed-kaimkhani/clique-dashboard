
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/constants/app_routes.dart';
import 'package:post_krakren_dashboard/view_model/create_group_viewModel.dart';

class CreateGroupPage extends StatelessWidget {
  final CreateGroupViewModel viewModel = Get.put(CreateGroupViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:   AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Get.toNamed(RouteName.dashboardScreen),
      ),
      title: const Text(
        'Create Group',
        style: TextStyle(color: Colors.black),
      ),
    ),
      backgroundColor: Colors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🛠️ Create Group',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Group GUID', viewModel.guidController),
                  _buildTextField('Group Name', viewModel.nameController),
                  // _buildTextField('Group Type', viewModel.groupTypeController),
                  // _buildTextField('Password (optional)', viewModel.passwordController, obscureText: true),
                  const SizedBox(height: 20),
                  const Text('Group Members', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  _buildMemberSelector(viewModel),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300),
                        onPressed: () => viewModel.clearAll(),
                        child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        onPressed: () {
                          viewModel.createGroupAPI();
                        },
                        child: const Text('Save', style: TextStyle(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black, width: 2),
          ),
          labelText: label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

Widget _buildMemberSelector(CreateGroupViewModel viewModel) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonFormField<String>(
        
        isExpanded: true,
        decoration: const InputDecoration(
          labelText: 'Select Member',
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
        items: viewModel.allMembers.map((member) {
          return DropdownMenuItem<String>(
            
            value: member,
            child: Text(member),
          );
        }).toList(),
        onChanged: (selected) {
          if (selected != null && !viewModel.selectedMembers.contains(selected)) {
            viewModel.selectedMembers.add(selected);
          }
        },
      ),
      const SizedBox(height: 10),
      Obx(() => Wrap(
            spacing: 8,
            children: viewModel.selectedMembers.map((member) {
              return Chip(
                label: Text(member),
                onDeleted: () => viewModel.selectedMembers.remove(member),
              );
            }).toList(),
          )),
    ],
  );
}

}
