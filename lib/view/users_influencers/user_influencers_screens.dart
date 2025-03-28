

import 'package:flutter/material.dart';

class UsersInfluencersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildFilters(),
            Expanded(
              child: _buildUserDataTable(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Users", 
            style: TextStyle(
              fontSize: 22, 
              fontWeight: FontWeight.bold
            ),
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
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 10,
        children: [
          Chip(label: Text("Role: All")),
          Chip(label: Text("Active Users")),
          Chip(label: Text("Verified")),
        ],
      ),
    );
  }

  Widget _buildUserDataTable() {
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
                    minWidth: constraints.maxWidth - 32, // Account for padding
                  ),
                  child: DataTable(
                    columnSpacing: 24,
                    dataRowHeight: 64,
                    headingRowHeight: 56,
                    horizontalMargin: 16,
                    dividerThickness: 1,
                    showCheckboxColumn: true,
                    columns: [
                      DataColumn(label: _buildHeaderCell("ID")),
                      DataColumn(label: _buildHeaderCell("Name")),
                      DataColumn(label: _buildHeaderCell("Email")),
                      DataColumn(label: _buildHeaderCell("Role")),
                      DataColumn(label: _buildHeaderCell("Status")),
                      DataColumn(label: _buildHeaderCell("Action")),
                    ],
                    rows: List.generate(
                      10,
                      (index) => DataRow(
                        cells: [
                          DataCell(_buildDataCell("${1000 + index}")),
                          DataCell(_buildDataCell("User $index")),
                          DataCell(_buildDataCell("user$index@example.com")),
                          DataCell(_buildDataCell(index % 2 == 0 ? "Admin" : "User")),
                          DataCell(
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: index % 3 == 0 
                                  ? Colors.green[100] 
                                  : Colors.blue[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                index % 3 == 0 ? "Active" : "Pending",
                                style: TextStyle(
                                  color: index % 3 == 0 
                                    ? Colors.green[800] 
                                    : Colors.blue[800],
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                        ],
                        onSelectChanged: (selected) {
                          // Handle row selection
                        },
                      ),
                    ),
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

  Widget _buildHeaderCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildDataCell(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Text(text),
    );
  }
}