import 'package:flutter/material.dart';
import 'package:post_krakren_dashboard/constants/app_colors.dart';

class EarningsStatsCard extends StatelessWidget {
  const EarningsStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Earning title and amount
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'EARNING',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '\$2,562',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),

          // Main stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left column (Cost and Revenue)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatItem('Cost', '108', '+37%', Colors.red),
                  const SizedBox(height: 16),
                  _buildStatItem('Revenue', '1,168', '-18.9%', Colors.green),
                ],
              ),

              // Middle percentage circle
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:AppColors.appColor,
                    width: 8,
                  ),
                ),
                child: Center(
                  child: Text(
                    '70%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.appColor,
                    ),
                  ),
                ),
              ),

              // Right column (Cost, Revenue, Earning)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildStatItemWithDollar('Cost', '4,823', '+12%'),
                  const SizedBox(height: 16),
                  _buildStatItemWithDollar('Revenue', '6,830', '+8%'),
                  const SizedBox(height: 16),
                  _buildStatItemWithDollar('Earning', '4,430', '+8%'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Bottom total row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBottomStat('108', '+37%', 'Cost'),
              _buildBottomStat('1,168', '-18.9%', 'Revenue'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String title, String value, String percentage, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatItemWithDollar(String title, String value, String percentage) {
    Color color = percentage.startsWith('-') ? Colors.red : Colors.green;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$$value',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBottomStat(String value, String percentage, String label) {
    Color color = percentage.startsWith('-') ? Colors.red : Colors.green;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              percentage,
              style: TextStyle(
                fontSize: 12,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}