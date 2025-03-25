// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class OrdersVisitorsBarChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final barGroups = _getBarGroups();

//     return AspectRatio(
//       aspectRatio: 2.5,
//       child: BarChart(
//         BarChartData(
//           barGroups: barGroups,
//           titlesData: FlTitlesData(
//             leftTitles: AxisTitles(
//               sideTitles: SideTitles(showTitles: true, reservedSize: 40),
//             ),
//             bottomTitles: AxisTitles(
//               sideTitles: SideTitles(
//                 showTitles: true,
//                 getTitlesWidget: (value, meta) {
//                   final labels = [
//                     'Jan 01', 'Jan 02', 'Jan 03', 'Jan 04', 'Jan 05', 'Jan 06',
//                     'Jan 07', 'Jan 08', 'Jan 09', 'Jan 10', 'Jan 11', 'Jan 12',
//                     'Jan 13', 'Jan 14', 'Jan 15', 'Jan 16', 'Jan 17', 'Jan 18'
//                   ];

//                   if (value.toInt() < 0 || value.toInt() >= labels.length) {
//                     return SizedBox.shrink();
//                   }

//                   return SideTitleWidget(
//                     axisSide: meta.axisSide, // ✅ Fixed issue
//                     child: Text(
//                       labels[value.toInt()], 
//                       style: TextStyle(fontSize: 12),
//                     ),
//                   );
//                 },
//                 reservedSize: 40,
//                 interval: 1, // Ensures labels align with bars
//               ),
//             ),
//           ),
//           borderData: FlBorderData(show: false),
//           gridData: FlGridData(show: false),
//         ),
//       ),
//     );
//   }

//   List<BarChartGroupData> _getBarGroups() {
//     final orders = [30, 65, 45, 55, 42, 22, 66, 20, 45, 30, 65, 44, 55, 40, 22, 66, 20, 35];
//     final visitors = [5, 30, 10, 20, 18, 14, 8, 12, 25, 6, 28, 14, 19, 22, 12, 8, 14, 25];

//     return List.generate(orders.length, (index) {
//       return BarChartGroupData(
//         x: index,
//         barRods: [
//           BarChartRodData(toY: orders[index].toDouble(), color: Colors.blue, width: 10),
//           BarChartRodData(toY: visitors[index].toDouble(), color: Colors.blue.shade200, width: 10),
//         ],
//         barsSpace: 5,
//       );
//     });
//   }
// }



import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';

class _LineChart extends StatelessWidget {
  const _LineChart({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sampleData1 : sampleData2,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
      );

  LineChartData get sampleData2 => LineChartData(
        lineTouchData: lineTouchData2,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0,
        maxX: 14,
        maxY: 6,
        minY: 0,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) =>
              Colors.blueGrey.withValues(alpha: 0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
        lineChartBarData1_3,
      ];

  LineTouchData get lineTouchData2 => const LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartBarData2_1,
        lineChartBarData2_2,
        lineChartBarData2_3,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      meta: meta,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColors.blue.withOpacity(0.2), width: 1.5),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: Colors.blue,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColors.background.withValues(alpha: 0.5),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData1_3 => LineChartBarData(
        isCurved: true,
        color: AppColors.blue,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
      );

  LineChartBarData get lineChartBarData2_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 4),
          FlSpot(5, 1.8),
          FlSpot(7, 5),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
      );

  LineChartBarData get lineChartBarData2_2 => LineChartBarData(
        isCurved: true,
        color: AppColors.blue,
        barWidth: 4,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: AppColors.background.withValues(alpha: 0.2),
        ),
        spots: const [
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
      );

  LineChartBarData get lineChartBarData2_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: AppColors.blue.withValues(alpha: 0.5),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: true),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 3.8),
          FlSpot(3, 1.9),
          FlSpot(6, 5),
          FlSpot(10, 3.3),
          FlSpot(13, 4.5),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  const LineChartSample1({super.key});

  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 37,
              ),
              const Text(
                'Monthly Sales',
                style: TextStyle(
                  color: AppColors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 37,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16, left: 6),
                  child: _LineChart(isShowingMainData: isShowingMainData),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          IconButton(
            icon: Icon(
              Icons.refresh,
              color:
                  Colors.white.withValues(alpha: isShowingMainData ? 1.0 : 0.5),
            ),
            onPressed: () {
              setState(() {
                isShowingMainData = !isShowingMainData;
              });
            },
          )
        ],
      ),
    );
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
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
//         maxX: 24, // 6 months of data
//         maxY: 6,
//         minY: 0,
//       );

//   LineChartData get sampleData2 => LineChartData(
//         lineTouchData: lineTouchData2,
//         gridData: gridData,
//         titlesData: titlesData2,
//         borderData: borderData,
//         lineBarsData: lineBarsData2,
//         minX: 0,
//         maxX: 24,
//         maxY: 6,
//         minY: 0,
//       );

//   LineTouchData get lineTouchData1 => LineTouchData(
//         handleBuiltInTouches: true,
//         touchTooltipData: LineTouchTooltipData(
//           getTooltipColor: (touchedSpot) =>
//               Colors.blueGrey.withOpacity(0.8),
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
//       fontSize: 12,
//     );
    
//     final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
//     if (value % 4 == 0 && value.toInt() <= 24) {
//       return SideTitleWidget(
//         // axisSide: meta.axisSide,
//         meta: meta,
//         child: Text(
//           months[value.toInt() ~/ 4],
//           style: style,
//         ),
//       );
//     }
//     return const SizedBox();
//   }

//   SideTitles get bottomTitles => SideTitles(
//         showTitles: true,
//         reservedSize: 32,
//         interval: 1,
//         getTitlesWidget: bottomTitleWidgets,
//       );

//   FlGridData get gridData => FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         drawHorizontalLine: true,
//         horizontalInterval: 1,
//         verticalInterval: 4,
//         getDrawingHorizontalLine: (value) => FlLine(
//           color: Colors.grey.withOpacity(0.1),
//           strokeWidth: 1,
//         ),
//         getDrawingVerticalLine: (value) => FlLine(
//           color: Colors.grey.withOpacity(0.1),
//           strokeWidth: 1,
//         ),
//       );

//   FlBorderData get borderData => FlBorderData(
//         show: true,
//         border: Border(
//           bottom: BorderSide(
//               color: AppColors.blue.withOpacity(0.2), width: 1.5),
//           left: const BorderSide(color: Colors.transparent),
//           right: const BorderSide(color: Colors.transparent),
//           top: const BorderSide(color: Colors.transparent),
//         ),
//       );

//   LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//         isCurved: true,
//         color: Colors.blue,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 1), FlSpot(4, 2), FlSpot(8, 1.5), FlSpot(12, 3),
//           FlSpot(16, 2.5), FlSpot(20, 4), FlSpot(24, 3),
//         ],
//       );

//   LineChartBarData get lineChartBarData1_2 => LineChartBarData(
//         isCurved: true,
//         color: Colors.blue.withOpacity(0.5),
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 0.5), FlSpot(4, 1.5), FlSpot(8, 1), FlSpot(12, 2.5),
//           FlSpot(16, 2), FlSpot(20, 3.5), FlSpot(24, 2.5),
//         ],
//       );

//   LineChartBarData get lineChartBarData1_3 => LineChartBarData(
//         isCurved: true,
//         color: Colors.green,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 0.3), FlSpot(4, 1), FlSpot(8, 0.7), FlSpot(12, 2),
//           FlSpot(16, 1.5), FlSpot(20, 3), FlSpot(24, 2),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_1 => LineChartBarData(
//         isCurved: true,
//         color: Colors.blue,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 1.5), FlSpot(4, 2.5), FlSpot(8, 2), FlSpot(12, 3.5),
//           FlSpot(16, 3), FlSpot(20, 4.5), FlSpot(24, 3.5),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_2 => LineChartBarData(
//         isCurved: true,
//         color: Colors.blue.withOpacity(0.5),
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 1), FlSpot(4, 2), FlSpot(8, 1.5), FlSpot(12, 3),
//           FlSpot(16, 2.5), FlSpot(20, 4), FlSpot(24, 3),
//         ],
//       );

//   LineChartBarData get lineChartBarData2_3 => LineChartBarData(
//         isCurved: true,
//         color: Colors.green,
//         barWidth: 4,
//         isStrokeCapRound: true,
//         dotData: const FlDotData(show: false),
//         belowBarData: BarAreaData(show: false),
//         spots: const [
//           FlSpot(0, 0.8), FlSpot(4, 1.8), FlSpot(8, 1.3), FlSpot(12, 2.8),
//           FlSpot(16, 2.3), FlSpot(20, 3.8), FlSpot(24, 2.8),
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
//               const SizedBox(height: 37),
//               const Text(
//                 'Monthly Sales',
//                 style: TextStyle(
//                   color: AppColors.blue,
//                   fontSize: 32,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 2,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 37),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 6),
//                   child: _LineChart(isShowingMainData: isShowingMainData),
//                 ),
//               ),
//               const SizedBox(height: 10),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               icon: Icon(
//                 Icons.refresh,
//                 color: Colors.white.withOpacity(isShowingMainData ? 1.0 : 0.5),
//               ),
//               onPressed: () {
//                 setState(() {
//                   isShowingMainData = !isShowingMainData;
//                 });
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }