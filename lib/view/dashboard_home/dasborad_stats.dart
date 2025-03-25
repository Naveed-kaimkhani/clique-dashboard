import 'package:flutter/material.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
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
      ],
    );
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
      width: 250,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: textColor, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (percentage != null)
            Text(
              percentage!,
              style: const TextStyle(color: Colors.green, fontSize: 14),
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
