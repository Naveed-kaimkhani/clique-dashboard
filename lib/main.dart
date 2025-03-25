import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:post_krakren_dashboard/routes/app_routes.dart';
import 'package:post_krakren_dashboard/view/navigation_bar.dart';
import 'package:post_krakren_dashboard/view/videos_approval/videos_approval.dart';
void main() {
  runApp(
      //  DevicePreview(
      //   enabled: !kReleaseMode,
      //   builder: (context) => MyApp(),
      // ),
      MyApp()
    );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
        fontFamily: 'ClashDisplay',  // Apply font globally
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontFamily: 'ClashDisplay'),
          bodySmall: TextStyle(fontFamily: 'ClashDisplay'),
        ),
      ),
      home: DashboardScreen(),
      
      // initialRoute: RouteName.onboardScreen,
      
      getPages: AppRoutes.getAppRoutes(),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void main() {
//   runApp( MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//      theme: ThemeData(
//         fontFamily: 'ClashDisplay',  // Apply font globally
//         textTheme: TextTheme(
//           bodyMedium: TextStyle(fontFamily: 'ClashDisplay'),
//           bodySmall: TextStyle(fontFamily: 'ClashDisplay'),
//         ),
//       ),
//       home: OrdersPage(),
      
//       // initialRoute: RouteName.onboardScreen,
      
//       // getPages: AppRoutes.getAppRoutes(),
//     );
//   }
// }


// class OrdersPage extends StatelessWidget {
//   const OrdersPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         children: [
//           // Sidebar Navigation
//           Container(
//             width: 250,
//             color: Colors.grey[100],
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '# Orders',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 _buildSectionTitle('Components'),
//                 _buildNavItem('UI elements'),
//                 _buildNavItem('Widgets'),
//                 _buildNavItem('Forms'),
//                 _buildNavItem('Tables'),
//                 _buildNavItem('Charts'),
//                 const SizedBox(height: 16),
//                 _buildSectionTitle('Apps'),
//                 _buildNavItem('Calendar'),
//                 _buildNavItem('Contacts'),
//                 _buildNavItem('Profile'),
//                 _buildNavItem('File Manager'),
//                 _buildNavItem('Help Desk'),
//                 const SizedBox(height: 16),
//                 _buildSectionTitle('Exits'),
//                 _buildNavItem('Pages'),
//                 _buildNavItem('Authentication'),
//                 _buildNavItem('Layout'),
//                 const SizedBox(height: 16),
//                 _buildSectionTitle('Documentation'),
//                 _buildNavItem('Getting Start'),
//                 const Spacer(),
//                 const Text('1st Buy now'),
//               ],
//             ),
//           ),
//           // Main Content
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Filter tabs
//                   Row(
//                     children: [
//                       _buildFilterTab('All', isActive: true),
//                       _buildFilterTab('Proving'),
//                       _buildFilterTab('Processing'),
//                       _buildFilterTab('Completed'),
//                       const SizedBox(width: 8),
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 8, vertical: 4),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const Text('3'),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   // Data Table
//                   Expanded(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('10')),
//                           DataColumn(label: Text('Purchase Date')),
//                           DataColumn(label: Text('Name')),
//                           DataColumn(label: Text('Phone')),
//                           DataColumn(label: Text('Store To')),
//                           DataColumn(label: Text('Total')),
//                           DataColumn(label: Text('Payment')),
//                           DataColumn(label: Text('Status')),
//                           DataColumn(label: Text('Action')),
//                         ],
//                         rows: _orderData.map((order) {
//                           return DataRow(cells: [
//                             DataCell(Text(order.id)),
//                             DataCell(Text(order.date)),
//                             DataCell(Text(order.name)),
//                             DataCell(Text(order.phone)),
//                             DataCell(Text(order.storeTo)),
//                             DataCell(Text(order.total)),
//                             DataCell(Text(order.payment)),
//                             DataCell(Text(order.status)),
//                             DataCell(Text(order.action)),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(
//         title,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//           color: Colors.grey,
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(String title) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: TextButton(
//         onPressed: () {},
//         style: TextButton.styleFrom(
//           alignment: Alignment.centerLeft,
//           padding: EdgeInsets.zero,
//         ),
//         child: Text(title),
//       ),
//     );
//   }

//   Widget _buildFilterTab(String title, {bool isActive = false}) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: isActive ? Colors.blue : Colors.transparent,
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: Text(
//         title,
//         style: TextStyle(
//           color: isActive ? Colors.white : Colors.black,
//         ),
//       ),
//     );
//   }
// }

// // Order data model
// class Order {
//   final String id;
//   final String date;
//   final String name;
//   final String phone;
//   final String storeTo;
//   final String total;
//   final String payment;
//   final String status;
//   final String action;

//   Order({
//     required this.id,
//     required this.date,
//     required this.name,
//     required this.phone,
//     required this.storeTo,
//     required this.total,
//     required this.payment,
//     required this.status,
//     required this.action,
//   });
// }

// // Sample order data
// final List<Order> _orderData = [
//   Order(
//     id: '1331',
//     date: '2020-12-26 03:22:21',
//     name: 'Radiant Lindsay',
//     phone: '(697) 486-2101',
//     storeTo: '996-3523 E1 Ave',
//     total: '\$3.64',
//     payment: 'Paypal',
//     status: '-',
//     action: '1',
//   ),
//   Order(
//     id: '1156',
//     date: '2020-04-21 00:38:38',
//     name: 'Melinda Levy',
//     phone: '(748) 927-4423',
//     storeTo: 'Ao #506-8821 Vista Street',
//     total: '\$4.18',
//     payment: 'Paypal',
//     status: '-',
//     action: '1',
//   ),
//   // Add all other orders from your screenshot here
//   // ...
// ];