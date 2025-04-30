import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:post_krakren_dashboard/models/top_dawg_order.dart';

class OrdersBarChart extends StatefulWidget {
  final List<Order> orders;

  OrdersBarChart({required this.orders});

  @override
  _OrdersBarChartState createState() => _OrdersBarChartState();
}

class _OrdersBarChartState extends State<OrdersBarChart> {
  late Map<String, int> weeklySalesData;

  @override
  void initState() {
    super.initState();
    // Calculate weekly sales data when the widget is initialized
    weeklySalesData = calculateWeeklySales(widget.orders);
  }

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: getBarChartData(weeklySalesData),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Text(days[value.toInt()],
                    style: TextStyle(fontSize: 12));
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 10,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
        ),
      ),
    );
  }

  Map<String, int> calculateWeeklySales(List<Order> orders) {
    final Map<String, int> data = {
      'Mon': 1,
      'Tue': 10,
      'Wed': 20,
      'Thu': 20,
      'Fri': 30,
      'Sat': 80,
      'Sun': 200,
    };

    for (var order in orders) {
      final String day = DateFormat('EEE')
          .format(order.createdAt); // Format to get day of the week
      data[day] = data[day]! +
          1; // Increment the count of orders for the respective day
    }

    return data;
  }

  List<BarChartGroupData> getBarChartData(Map<String, int> data) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return List.generate(days.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[days[index]]!.toDouble(),
            color: Colors.blue,
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}

// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:post_krakren_dashboard/models/top_dawg_order.dart';
// // import 'your_model_file.dart'; // import the file containing Order model

// class WeeklySalesChart extends StatelessWidget {
//   final List<Order> orders;

//   const WeeklySalesChart({Key? key, required this.orders}) : super(key: key);

//   Map<String, double> _calculateWeeklySales(List<Order> orders) {
//     Map<String, double> weeklySales = {};

//     for (var order in orders) {
//       DateTime date = order.createdAt;
//       DateTime weekStart = date.subtract(Duration(days: date.weekday - 1));
//       String weekKey = '${weekStart.year}-${weekStart.month.toString().padLeft(2, '0')}-${weekStart.day.toString().padLeft(2, '0')}';

//       weeklySales[weekKey] = (weeklySales[weekKey] ?? 0) + order.totalPrice;
//     }

//     return Map.fromEntries(weeklySales.entries.toList()
//       ..sort((a, b) => a.key.compareTo(b.key)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final weeklySales = _calculateWeeklySales(orders);
//     final weeks = weeklySales.keys.toList();
//     final values = weeklySales.values.toList();

//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: (values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 0) + 50,
//         barTouchData: BarTouchData(enabled: true),
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(
//             sideTitles: SideTitles(showTitles: true),
//           ),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 int index = value.toInt();
//                 if (index >= 0 && index < weeks.length) {
//                   return  SideTitleWidget(
//                       meta: meta, // ✅ Required!

//   // axisSide: meta.axisSide,
//   space: 8,
//   child: Text(
//     weeks[index].substring(5), // MM-DD
//     style: TextStyle(fontSize: 10),
//   ),
// );

//                 }
//                 return const SizedBox.shrink();
//               },
//               interval: 1,
//             ),
//           ),
//         ),
//         borderData: FlBorderData(show: false),
//         barGroups: List.generate(weeks.length, (index) {
//           return BarChartGroupData(x: index, barRods: [
//             BarChartRodData(
//               toY: values[index],
//               color: Colors.blue,
//               width: 16,
//               borderRadius: BorderRadius.circular(4),
//             )
//           ]);
//         }),
//       ),
//     );
//   }
// }
