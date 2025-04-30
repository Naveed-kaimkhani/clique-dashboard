import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_krakren_dashboard/models/top_dawg_order.dart';
import 'package:intl/intl.dart';

class OrdersTableScreen extends StatelessWidget {
  final List<Order> orders;

  const OrdersTableScreen({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Orders Dashboard'),
        centerTitle: true,
        elevation: 4,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return _buildMobileList();
          } else {
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: constraints.maxWidth > 1200
                      ? 1200
                      : constraints.maxWidth * 0.95,
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildSummaryCards(context),
                    const SizedBox(height: 16),

                    Expanded(
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columnSpacing: 24,
                                horizontalMargin: 16,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                ),
                                headingRowColor: MaterialStateColor.resolveWith(
                                  (states) => Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                ),
                                columns: const [
                                  DataColumn(
                                      label: Text('Order ID',
                                          style: _headerStyle)),
                                  DataColumn(
                                      label: Text('Customer',
                                          style: _headerStyle)),
                                  DataColumn(
                                      label:
                                          Text('Total', style: _headerStyle)),
                                  DataColumn(
                                      label:
                                          Text('Items', style: _headerStyle)),
                                  DataColumn(
                                      label:
                                          Text('Status', style: _headerStyle)),
                                  DataColumn(
                                      label:
                                          Text('Created', style: _headerStyle)),
                                  DataColumn(
                                      label:
                                          Text('Details', style: _headerStyle)),
                                ],
                                rows: orders.map((order) {
                                  return DataRow(
                                    cells: [
                                      DataCell(Text(order.orderId,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500))),
                                      DataCell(Text(order.customerId,
                                          overflow: TextOverflow.ellipsis)),
                                      DataCell(Text(
                                          '\$${order.totalPrice.toStringAsFixed(2)}',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontWeight: FontWeight.bold))),
                                      DataCell(Text(
                                          '${order.topDawgOrders.length}')),
                                      DataCell(_buildStatusBadge(order.status)),
                                      DataCell(
                                          Text(_formatDate(order.createdAt))),
                                      DataCell(
                                        IconButton(
                                          icon: const Icon(Icons.info_outline),
                                          onPressed: () =>
                                              _showOrderDetails(context, order),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                 
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildSummaryCards(BuildContext context) {
    final totalOrders = orders.length;
    final totalRevenue =
        orders.fold(0.0, (sum, order) => sum + order.totalPrice);
    final totalItems =
        orders.fold(0, (sum, order) => sum + order.topDawgOrders.length);

    return Row(
      children: [
        _buildSummaryCard(
          context,
          title: 'Total Orders',
          value: totalOrders.toString(),
          icon: Icons.shopping_cart,
          color: Colors.blue,
        ),
        const SizedBox(width: 8),
        _buildSummaryCard(
          context,
          title: 'Total Revenue',
          value: '\$${totalRevenue.toStringAsFixed(2)}',
          icon: Icons.attach_money,
          color: Colors.green,
        ),
        const SizedBox(width: 8),
        // _buildSummaryCard(
        //   context,
        //   title: 'Total Items',
        //   value: totalItems.toString(),
        //   icon: Icons.list,
        //   color: Colors.orange,
        // ),
      ],
    );
  }

  Widget _buildSummaryCard(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: InkWell(
            onTap: () => _showOrderDetails(context, order),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.orderId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      _buildStatusBadge(order.status),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Customer: ${order.customerId}'),
                  const SizedBox(height: 4),
                  Text(
                    'Total: \$${order.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text('Items: ${order.topDawgOrders.length}'),
                  const SizedBox(height: 4),
                  Text('Date: ${_formatDate(order.createdAt)}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatusBadge(int status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _statusText(status),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      ),
    );
  }

  void _showOrderDetails(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.orderId}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Customer ID:', order.customerId),
              _buildDetailRow(
                  'Total Price:', '\$${order.totalPrice.toStringAsFixed(2)}'),
              _buildDetailRow('Status:', _statusText(order.status)),
              _buildDetailRow('Created:', _formatDateTime(order.createdAt)),
              _buildDetailRow('Updated:', _formatDateTime(order.updatedAt)),
              const SizedBox(height: 16),
              const Text(
                'Items:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ...order.topDawgOrders.map((item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Product: ${item.productCode}'),
                        GestureDetector(
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: item.tdid));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Copied TDID: ${item.tdid}'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              Text(
                                'TDID: ${item.tdid}',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.copy, size: 16, color: Colors.blue),
                            ],
                          ),
                        ),
                        Text('Quantity: ${item.quantity}'),
                        Text('Price: \$${item.price.toStringAsFixed(2)}'),
                        const Divider(),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  static String _formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String _formatDateTime(DateTime date) {
    return DateFormat('yyyy-MM-dd HH:mm').format(date);
  }

  static String _statusText(int statusCode) {
    switch (statusCode) {
      case 1:
        return 'Pending';
      case 2:
        return 'Processing';
      case 3:
        return 'Shipped';
      case 4:
        return 'Delivered';
      default:
        return 'Unknown';
    }
  }

  static Color _getStatusColor(int statusCode) {
    switch (statusCode) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.blue;
      case 3:
        return Colors.purple;
      case 4:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
