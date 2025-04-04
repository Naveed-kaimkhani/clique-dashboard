// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:post_krakren_dashboard/components/gradient_text.dart';
// import 'package:post_krakren_dashboard/constants/app_colors.dart';

// class _LineChart extends StatelessWidget {
//   const _LineChart({required this.isShowingMainData});

//   final bool isShowingMainData;

//   @override
//   Widget build(BuildContext context) {
//     return LineChart(
//       isShowingMainData ? sampleData1 : sampleData2,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   LineChartData get sampleData1 => LineChartData(
//         lineTouchData: lineTouchData1,
//         gridData: gridData,
//         titlesData: titlesData1,
//         borderData: borderData,
//         lineBarsData: lineBarsData1,
//         minX: 0,
//         maxX: 14,
//         maxY: 4,
//         minY: 0,
//       );

//   LineChartData get sampleData2 => LineChartData(
//         lineTouchData: lineTouchData2,
//         gridData: gridData,
//         titlesData: titlesData2,
//         borderData: borderData,
//         lineBarsData: lineBarsData2,
//         minX: 0,
//         maxX: 14,
//         maxY: 6,
//         minY: 0,
//       );

//   LineTouchData get lineTouchData1 => LineTouchData(
//         handleBuiltInTouches: true,
//         touchTooltipData: LineTouchTooltipData(
//           getTooltipColor: (touchedSpot) =>
//               Colors.blueGrey.withValues(alpha: 0.8),
//         ),
//       );

//   FlTitlesData get titlesData1 => FlTitlesData(
//         bottomTitles: AxisTitles(
//           sideTitles: bottomTitles,
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: leftTitles(),
//         ),
//       );

//   List<LineChartBarData> get lineBarsData1 => [
//         lineChartBarData1_1,
//         lineChartBarData1_2,
//         lineChartBarData1_3,
//       ];

//   LineTouchData get lineTouchData2 => const LineTouchData(
//         enabled: false,
//       );

//   FlTitlesData get titlesData2 => FlTitlesData(
//         bottomTitles: AxisTitles(
//           sideTitles: bottomTitles,
//         ),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: leftTitles(),
//         ),
//       );

//   List<LineChartBarData> get lineBarsData2 => [
//         lineChartBarData2_1,
//         lineChartBarData2_2,
//         lineChartBarData2_3,
//       ];

//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1m';
//         break;
//       case 2:
//         text = '2m';
//         break;
//       case 3:
//         text = '3m';
//         break;
//       case 4:
//         text = '5m';
//         break;
//       case 5:
//         text = '6m';
//         break;
//       default:
//         return Container();
//     }

//     return SideTitleWidget(
//       meta: meta,
//       child: Text(
//         text,
//         style: style,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   SideTitles leftTitles() => SideTitles(
//         getTitlesWidget: leftTitleWidgets,
//         showTitles: true,
//         interval: 1,
//         reservedSize: 40,
//       );

//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('SEPT', style: style);
//         break;
//       case 7:
//         text = const Text('OCT', style: style);
//         break;
//       case 12:
//         text = const Text('DEC', style: style);
//         break;
//       default:
//         text = const Text('');
//         break;
//     }

//     return SideTitleWidget(
//       meta: meta,
//       space: 10,
//       child: text,
//     );
//   }

//   SideTitles get bottomTitles => SideTitles(
//         showTitles: true,
//         reservedSize: 32,
//         interval: 1,
//         getTitlesWidget: bottomTitleWidgets,
//       );

//   FlGridData get gridData => const FlGridData(show: false);

//   FlBorderData get borderData => FlBorderData(
//         show: true,
//         border: Border(
//           bottom:
//               // BorderSide(color: AppColors.blue.withOpacity(0.2), width: 1.5),
              
//               BorderSide(color: AppColors.appColor, width: 1.5),
//           left: const BorderSide(color: Colors.transparent),
//           right: const BorderSide(color: Colors.transparent),
//           top: const BorderSide(color: Colors.transparent),
//         ),
//       );
      
//   LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//         isCurved: true,
//         color: AppColors.appColor,
//         barWidth: 8,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(1, 1),
//           FlSpot(3, 1.5),
//           FlSpot(5, 1.4),
//           FlSpot(7, 3.4),
//           FlSpot(10, 2),
//           FlSpot(12, 2.2),
//           FlSpot(13, 1.8),
//         ],
//       );

//   LineChartBarData get lineChartBarData1_2 => LineChartBarData(
//         isCurved: true,
//         color: Colors.green,
//         barWidth: 8,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(
//           show: false,
//           color: AppColors.background.withValues(alpha: 0.5),
//         ),
//         spots: const [
//           FlSpot(1, 1),
//           FlSpot(3, 2.8),
//           FlSpot(7, 1.2),
//           FlSpot(10, 2.8),
//           FlSpot(12, 2.6),
//           FlSpot(13, 3.9),
//         ],
//       );

//   LineChartBarData get lineChartBarData1_3 => LineChartBarData(
//         isCurved: true,
//         color: AppColors.blue,
//         barWidth: 8,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(1, 2.8),
//           FlSpot(3, 1.9),
//           FlSpot(6, 3),
//           FlSpot(10, 1.3),
//           FlSpot(13, 2.5),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_1 => LineChartBarData(
//         isCurved: true,
//         curveSmoothness: 0,
//         color: AppColors.blue,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(1, 1),
//           FlSpot(3, 4),
//           FlSpot(5, 1.8),
//           FlSpot(7, 5),
//           FlSpot(10, 2),
//           FlSpot(12, 2.2),
//           FlSpot(13, 1.8),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_2 => LineChartBarData(
//         isCurved: true,
//         color: AppColors.blue,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(
//           show: true,
//           color: AppColors.background.withValues(alpha: 0.2),
//         ),
//         spots: const [
//           FlSpot(1, 1),
//           FlSpot(3, 2.8),
//           FlSpot(7, 1.2),
//           FlSpot(10, 2.8),
//           FlSpot(12, 2.6),
//           FlSpot(13, 3.9),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//         isCurved: true,
//         curveSmoothness: 0,
//         color: AppColors.blue.withValues(alpha: 0.5),
//         barWidth: 2,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: true),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(1, 3.8),
//           FlSpot(3, 1.9),
//           FlSpot(6, 5),
//           FlSpot(10, 3.3),
//           FlSpot(13, 4.5),
//         ],
//       );
// }

// class LineChartSample1 extends StatefulWidget {
//   const LineChartSample1({super.key});

//   @override
//   State<StatefulWidget> createState() => LineChartSample1State();
// }

// class LineChartSample1State extends State<LineChartSample1> {
//   late bool isShowingMainData;

//   @override
//   void initState() {
//     super.initState();
//     isShowingMainData = true;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.23,
//       child: Stack(
//         children: <Widget>[
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               const SizedBox(
//                 height: 37,
//               ),
//               // GradientText("Monthly Sales",
//               //     gradient: AppColors.appGradientColors, fontSize: 22),
//               const Text(
//                 'Monthly Sales',
//                 style: TextStyle(
//                   color: AppColors.appColor,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 37,
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 6),
//                   child: _LineChart(isShowingMainData: isShowingMainData),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//             ],
//           ),
//           IconButton(
//             icon: Icon(
//               Icons.refresh,
//               color:
//                   Colors.white.withValues(alpha: isShowingMainData ? 1.0 : 0.5),
//             ),
//             onPressed: () {
//               setState(() {
//                 isShowingMainData = !isShowingMainData;
//               });
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';

class EnhancedBarChart extends StatelessWidget {
  final bool isShowingMainData;

  const EnhancedBarChart({required this.isShowingMainData});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      isShowingMainData ? mainBarData() : secondaryBarData(),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            final month = getMonthName(group.x.toInt());
            return BarTooltipItem(
              '$month\n${rod.toY.toStringAsFixed(1)}m',
              const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.appColor, width: 1.5),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      barGroups: List.generate(12, (index) {
        return BarChartGroupData(
          x: index,
          groupVertically: true,
          barRods: [
            BarChartRodData(
              toY: _getMainData(index, 0),
              color: AppColors.appColor,
              width: 6,
            ),
            BarChartRodData(
              toY: _getMainData(index, 1),
              color: Colors.green,
              width: 6,
            ),
            BarChartRodData(
              toY: _getMainData(index, 2),
              color: AppColors.blue,
              width: 6,
            ),
            BarChartRodData(
              toY: _getMainData(index, 3),
              color: Colors.orange,
              width: 6,
            ),
          ],
        );
      }),
      alignment: BarChartAlignment.spaceBetween,
      maxY: 6,
      groupsSpace: 4,
    );
  }

  BarChartData secondaryBarData() {
    return BarChartData(
      barTouchData:  BarTouchData(enabled: false),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 28,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: AppColors.appColor, width: 1.5),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      ),
      barGroups: List.generate(12, (index) {
        return BarChartGroupData(
          x: index,
          groupVertically: true,
          barRods: [
            BarChartRodData(
              toY: _getSecondaryData(index, 0),
              color: AppColors.blue,
              width: 4,
            ),
            BarChartRodData(
              toY: _getSecondaryData(index, 1),
              color: AppColors.blue.withOpacity(0.7),
              width: 4,
            ),
            BarChartRodData(
              toY: _getSecondaryData(index, 2),
              color: AppColors.blue.withOpacity(0.5),
              width: 4,
            ),
          ],
        );
      }),
      alignment: BarChartAlignment.spaceBetween,
      maxY: 8,
      groupsSpace: 4,
    );
  }

  double _getMainData(int monthIndex, int seriesIndex) {
    // Sample data for 4 series across 12 months
    final data = [
      [3.4, 2.8, 3.0, 2.5], // Jan
      [2.8, 3.2, 2.5, 2.0], // Feb
      [3.0, 3.5, 2.8, 2.2], // Mar
      [3.5, 3.0, 3.2, 2.8], // Apr
      [4.0, 3.8, 3.5, 3.0], // May
      [4.5, 4.2, 4.0, 3.5], // Jun
      [5.0, 4.5, 4.2, 3.8], // Jul
      [4.8, 4.0, 4.5, 4.0], // Aug
      [4.2, 3.8, 4.0, 3.5], // Sep
      [3.8, 3.5, 3.8, 3.2], // Oct
      [3.5, 3.2, 3.5, 3.0], // Nov
      [3.2, 2.8, 3.0, 2.5], // Dec
    ];
    return data[monthIndex % 12][seriesIndex % 4];
  }

  double _getSecondaryData(int monthIndex, int seriesIndex) {
    // Sample secondary data for 3 series across 12 months
    final data = [
      [5.0, 4.5, 4.0], // Jan
      [4.8, 4.3, 3.8], // Feb
      [5.2, 4.7, 4.2], // Mar
      [5.5, 5.0, 4.5], // Apr
      [6.0, 5.5, 5.0], // May
      [6.5, 6.0, 5.5], // Jun
      [7.0, 6.5, 6.0], // Jul
      [6.8, 6.3, 5.8], // Aug
      [6.2, 5.7, 5.2], // Sep
      [5.8, 5.3, 4.8], // Oct
      [5.5, 5.0, 4.5], // Nov
      [5.2, 4.7, 4.2], // Dec
    ];
    return data[monthIndex % 12][seriesIndex % 3];
  }

  String getMonthName(int monthIndex) {
    const months = [
      'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
      'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'
    ];
    return months[monthIndex % 12];
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    final monthIndex = value.toInt();
    
    // Show every other month to prevent crowding
    if (monthIndex % 2 == 0) {
      return SideTitleWidget(
        meta: meta,
        child: Text(getMonthName(monthIndex), style: style),
      );
    }
    return Container();
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    return SideTitleWidget(
      meta: meta,
      child: Text('${value.toInt()}m', style: style),
    );
  }
}

class EnhancedBarChartSample extends StatefulWidget {
  const EnhancedBarChartSample({super.key});

  @override
  State<EnhancedBarChartSample> createState() => _EnhancedBarChartSampleState();
}

class _EnhancedBarChartSampleState extends State<EnhancedBarChartSample> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5, // Slightly wider to accommodate more months
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                'Monthly Sales Performance',
                style: TextStyle(
                  color: AppColors.appColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Comparison of multiple product lines across 12 months',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: EnhancedBarChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegend(AppColors.appColor, 'Product A'),
                  const SizedBox(width: 16),
                  _buildLegend(Colors.green, 'Product B'),
                  const SizedBox(width: 16),
                  _buildLegend(AppColors.blue, 'Product C'),
                  if (isShowingMainData) ...[
                    const SizedBox(width: 16),
                    _buildLegend(Colors.orange, 'Product D'),
                  ],
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend(Color color, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}