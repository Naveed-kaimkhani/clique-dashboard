// import 'package:flutter/material.dart';

// class DashboardStats extends StatelessWidget {
//   const DashboardStats({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 600;
//     final isTablet = screenWidth >= 600 && screenWidth < 1200;

//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (isMobile) {
//           return Column(
//             children: const [
//               StatCard(
//                 title: "Monthly Sales",
//                 value: "\$1250",
//                 percentage: "+5.5%",
//                 icon: Icons.email,
//                 backgroundColor: Colors.blue,
//                 textColor: Colors.white,
//               ),
//               SizedBox(height: 16),
//               StatCard(
//                 title: "Orders",
//                 value: "1,869",
//                 percentage: "+16.5%",
//                 icon: Icons.shopping_cart,
//               ),
//               SizedBox(height: 16),
//               StatCard(
//                 title: "Conversion",
//                 value: "86.6%",
//                 icon: Icons.filter_alt,
//                 showProgress: true,
//               ),
//               SizedBox(height: 16),
//               StatCard(
//                 title: "AVG Orders",
//                 value: "\$80",
//                 icon: Icons.analytics,
//               ),
//             ],
//           );
//         } else if (isTablet) {
//           return Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Expanded(
//                     child: StatCard(
//                         title: "Monthly Sales",
//                         value: "\$1250",
//                         percentage: "+5.5%",
//                         icon: Icons.email,
//                         backgroundColor: Colors.blue,
//                         textColor: Colors.white),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: StatCard(
//                       title: "Orders",
//                       value: "1,869",
//                       percentage: "+16.5%",
//                       icon: Icons.shopping_cart,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: const [
//                   Expanded(
//                     child: StatCard(
//                       title: "Conversion",
//                       value: "86.6%",
//                       icon: Icons.filter_alt,
//                       showProgress: true,
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: StatCard(
//                       title: "AVG Orders",
//                       value: "\$80",
//                       icon: Icons.analytics,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           );
//         } else {
//           return Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: const [
//               StatCard(
//                 title: "Monthly Sales",
//                 value: "\$1250",
//                 percentage: "+5.5%",
//                 icon: Icons.email,
//                 backgroundColor: Colors.blue,
//                 textColor: Colors.white,
//               ),
//               StatCard(
//                 title: "Orders",
//                 value: "1,869",
//                 percentage: "+16.5%",
//                 icon: Icons.shopping_cart,
//               ),
//               StatCard(
//                 title: "Conversion",
//                 value: "86.6%",
//                 icon: Icons.filter_alt,
//                 showProgress: true,
//               ),
//               StatCard(
//                 title: "AVG Orders",
//                 value: "\$80",
//                 icon: Icons.analytics,
//               ),
//             ],
//           );
//         }
//       },
//     );
//   }
// }

// class StatCard extends StatelessWidget {
//   final String title;
//   final String value;
//   final String? percentage;
//   final IconData icon;
//   final Color backgroundColor;
//   final Color textColor;
//   final bool showProgress;

//   const StatCard({
//     super.key,
//     required this.title,
//     required this.value,
//     this.percentage,
//     required this.icon,
//     this.backgroundColor = Colors.white,
//     this.textColor = Colors.black,
//     this.showProgress = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 600;

//     return Container(
//       width: isMobile ? double.infinity : null,
//       constraints: BoxConstraints(
//         minWidth: isMobile ? double.infinity : 200,
//         maxWidth: 300,
//       ),
//       padding: const EdgeInsets.all(16.0),
//       margin: isMobile ? null : const EdgeInsets.symmetric(horizontal: 4),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.1),
//             blurRadius: 10,
//             spreadRadius: 2,
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.blue,
//                 child: Icon(icon, color: Colors.white),
//               ),
//               const SizedBox(width: 10),
//               Flexible(
//                 child: Text(
//                   title,
//                   style: TextStyle(color: textColor, fontSize: 16),
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Text(
//             value,
//             style: TextStyle(
//               color: textColor,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (percentage != null)
//             Text(
//               percentage!,
//               style: const TextStyle(color: Colors.green, fontSize: 14),
//             ),
//           if (showProgress)
//             const Padding(
//               padding: EdgeInsets.only(top: 8.0),
//               child: LinearProgressIndicator(
//                 value: 0.86,
//                 color: Colors.green,
//                 backgroundColor: Colors.grey,
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1000;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (isMobile) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _buildCards(context).map((card) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: SizedBox(
                    width: constraints.maxWidth * 0.8,
                    child: card,
                  ),
                );
              }).toList(),
            ),
          );
        } else if (isTablet) {
          return Column(
            children: [
              Row(
                children: _buildCards(context).sublist(0, 2).map((card) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: card,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              Row(
                children: _buildCards(context).sublist(2).map((card) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: card,
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        } else {
          return Row(
            children: _buildCards(context).map((card) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: card,
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  List<StatCard> _buildCards(BuildContext context) {
    return const [
      StatCard(
        title: "Monthly Sales",
        value: "\$1250",
        percentage: "+5.5%",
        icon: Icons.email,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      ),
      StatCard(
        title: "Orders",
        value: "1,869",
        percentage: "+16.5%",
        icon: Icons.shopping_cart,
      ),
      StatCard(
        title: "Conversion",
        value: "86.6%",
        icon: Icons.filter_alt,
        showProgress: true,
      ),
      StatCard(
        title: "AVG Orders",
        value: "\$80",
        icon: Icons.analytics,
      ),
    ];
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? percentage;
  final IconData icon;
  final Color backgroundColor;
  final Color textColor;
  final bool showProgress;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    this.percentage,
    required this.icon,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.blue,
                child: Icon(icon, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (percentage != null)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                percentage!,
                style: const TextStyle(
                  color: Colors.green,
                  fontSize: 12,
                ),
              ),
            ),
          if (showProgress)
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: LinearProgressIndicator(
                value: 0.86,
                color: Colors.green,
                backgroundColor: Colors.grey,
              ),
            ),
        ],
      ),
    );
  }
}
