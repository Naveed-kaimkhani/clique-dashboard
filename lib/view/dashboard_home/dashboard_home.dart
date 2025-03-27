


import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/components/index.dart';
import 'package:post_krakren_dashboard/components/order_chart.dart';
import 'package:post_krakren_dashboard/view/dashboard_home/dasborad_stats.dart';

class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  final PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true);

  Widget _buildEarningCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("EARNING", style: TextStyle(color: Colors.grey, fontSize: 14)),
            SizedBox(height: 24),
            Text("\$2,562",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 24),
            CircularPercentIndicator(value: 0.86, percentage: "86"),
            Divider(),
            _buildStatRow("Cost", "108", "+37.7%"),
            _buildStatRow("Revenue", "1168", "-18.9%"),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 24),
            CircularPercentIndicator(value: 0.70, percentage: "70%"),
            SizedBox(height: 24),
            Divider(),
            _buildStatRow("Cost", "\$1,823", "+12%"),
            _buildStatRow("Revenue", "\$6,830", "+8%"),
            _buildStatRow("Earning", "\$4,830", "+8%"),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : screenWidth * 0.05,
                vertical: isMobile ? 12 : 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DashboardStats(),
                    SizedBox(height: isMobile ? 12 : 24),
                    Container(
                      height: isMobile ? 300 : 400,
                      width: double.infinity, // Changed from fixed 1300
                      constraints: BoxConstraints(
                        minHeight: 300,
                        maxHeight: 500,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: LineChartSample1(),
                    ),
                    SizedBox(height: isMobile ? 12 : 24),
                    // Responsive card row
                    if (isMobile) ...[
                      _buildEarningCard(),
                      SizedBox(height: 12),
                      _buildProgressCard(),
                      SizedBox(height: 12),
                      _buildBarChartCard(),
                    ] else ...[
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              SizedBox(
                                width: isTablet 
                                    ? constraints.maxWidth / 2 - 24 
                                    : constraints.maxWidth / 3 - 24,
                                child: _buildEarningCard(),
                              ),
                              SizedBox(
                                width: isTablet 
                                    ? constraints.maxWidth / 2 - 24 
                                    : constraints.maxWidth / 3 - 24,
                                child: _buildProgressCard(),
                              ),
                              if (!isTablet) SizedBox(
                                width: constraints.maxWidth / 3 - 24,
                                child: _buildBarChartCard(),
                              ),
                            ],
                          );
                        },
                      ),
                      if (isTablet) ...[
                        SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: _buildBarChartCard(),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Rest of your code remains the same...
Widget _buildStatRow(String title, String value, String change) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.grey)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
            Text(change,
                style: TextStyle(
                    color: change.contains('-') ? Colors.red : Colors.green)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildBarChart() {
  return BarChart(
    BarChartData(
      barGroups: List.generate(
          6,
          (index) => BarChartGroupData(x: index, barRods: [
                BarChartRodData(
                    toY: (index + 1) * 2.0, color: Colors.blue, width: 10),
                BarChartRodData(
                    toY: (index + 1) * 1.5, color: Colors.green, width: 10),
                BarChartRodData(
                    toY: (index + 1) * 1.2, color: Colors.purple, width: 10),
              ])),
      titlesData: FlTitlesData(show: false),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(show: false),
    ),
  );
}

Widget _buildBarChartCard() {
  return Card(
    color: Colors.white,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 24),
          Text("108",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text("+37.7%", style: TextStyle(color: Colors.green)),
          SizedBox(height: 10),
          SizedBox(
            height: 60, 
            child: _buildBarChart(),
          ),
          Divider(),
          _buildStatRow("Cost", "108", "+37.7%"),
          _buildStatRow("Revenue", "1168", "-18.9%"),
        ],
      ),
    ),
  );
}

class CircularPercentIndicator extends StatelessWidget {
  final double value;
  final String percentage;

  const CircularPercentIndicator(
      {required this.value, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: value,
            strokeWidth: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation(AppColors.appColor),
          ),
          Center(
              child: Text(percentage,
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}