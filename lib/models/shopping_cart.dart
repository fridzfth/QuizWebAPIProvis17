import 'items.dart'; // Pastikan untuk mengimpor kelas Item jika diperlukan

class ShoppingCart {
  Map<Item, int> items = {};

  void addToCart(Item item, {int quantity = 1}) {
    if (items.containsKey(item)) {
      items[item] = (items[item] ?? 0) + quantity;
    } else {
      items[item] = quantity;
    }
  }

  void removeItem(Item item) {
    if (items.containsKey(item)) {
      if (items[item]! > 1) {
        items[item] = items[item]! - 1;
      } else {
        items.remove(item);
      }
    }
  }

  double calculateTotalPrice() {
    double totalPrice = 0;
    items.forEach((Item item, int quantity) {
      totalPrice += item.price * quantity;
    });
    return totalPrice;
  }

  int getTotalItems() {
    int total = 0;
    items.values.forEach((quantity) {
      total += quantity;
    });
    return total;
  }

  void clearCart() {
    items.clear();
  }
}
