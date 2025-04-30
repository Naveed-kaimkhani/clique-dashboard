// models/order_model.dart

class TopDawgOrder {
  final String tdid;
  final double price;
  final int quantity;
  final String productCode;

  TopDawgOrder({
    required this.tdid,
    required this.price,
    required this.quantity,
    required this.productCode,
  });

  factory TopDawgOrder.fromJson(Map<String, dynamic> json) {
    return TopDawgOrder(
      tdid: json['tdid'],
      price: json['price'].toDouble(),
      quantity: json['quantity'],
      productCode: json['product_code'],
    );
  }
}

class Order {
  final int id;
  final String orderId;
  final String customerId;
  final double totalPrice;
  final List<TopDawgOrder> topDawgOrders;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Order({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.totalPrice,
    required this.topDawgOrders,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderId: json['order_id'],
      customerId: json['customer_id'],
      totalPrice: double.parse(json['total_price']),
      topDawgOrders: (json['topdawg_order'] as List)
          .map((e) => TopDawgOrder.fromJson(e))
          .toList(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class RevenueResponse {
  final double totalRevenue;
  final double totalProfit;
  final List<Order> orders;

  RevenueResponse({
    required this.totalRevenue,
    required this.totalProfit,
    required this.orders,
  });

  factory RevenueResponse.fromJson(Map<String, dynamic> json) {
    return RevenueResponse(
      totalRevenue: double.parse(json['total_revenue']),
      totalProfit: double.parse(json['total_profit']),
      orders: (json['orders'] as List).map((e) => Order.fromJson(e)).toList(),
    );
  }
}
