import 'items.dart';

enum OrderStatus {
  Checkout,
  Payment,
  AcceptedByRestaurant,
  RejectedByRestaurant,
  DriverStarted,
  Completed,
}

class Order {
  final int id;
  final List<Item> items;
  final double totalPrice;
  final double shippingCost;
  final bool isPaid;
  OrderStatus status;
  final DateTime dateTime;

  Order({
    required this.id,
    required this.items,
    required this.totalPrice,
    required this.shippingCost,
    this.isPaid = false,
    this.status = OrderStatus.Checkout,
    required this.dateTime,
  });
}
