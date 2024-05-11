class Cart {
  final int id;
  final int userId;
  final int itemId;
  final int quantity;

  Cart({
    required this.id,
    required this.userId,
    required this.itemId,
    required this.quantity,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['user_id'],
      itemId: json['item_id'],
      quantity: json['quantity'],
    );
  }
}
