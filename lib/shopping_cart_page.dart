import 'package:flutter/material.dart';

import '../models/items.dart';
import '../models/order.dart';
import '../models/shopping_cart.dart';
import '../order_history_page.dart';

class ShoppingCartPage extends StatefulWidget {
  final ShoppingCart cart;

  ShoppingCartPage(this.cart);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late Item _itemToDelete;

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cart.calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cart.items.length,
              itemBuilder: (context, index) {
                Item item = widget.cart.items.keys.elementAt(index);
                int quantity = widget.cart.items[item]!;
                return ListTile(
                  title: Text(item.title),
                  subtitle: Row(
                    children: [
                      Text('Quantity: $quantity'),
                      Spacer(),
                      IconButton(
                        iconSize: 20, // Ubah ukuran ikon menjadi lebih kecil
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _itemToDelete = item;
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Delete Item'),
                                content: Text(
                                    'Are you sure you want to delete ${item.title}?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.cart.removeItem(_itemToDelete);
                                      });
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            if (widget.cart.items.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Align(
                  alignment:
                      Alignment.centerRight, // Memposisikan tombol ke kanan
                  child: ElevatedButton(
                    onPressed: () {
                      widget.cart.clearCart();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    child: Text(
                      'Delete All',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text('Metode Pembayaran: '),
                  DropdownButton<String>(
                    value: 'Cash',
                    onChanged: (String? newValue) {},
                    items: <String>['Cash', 'BarPay']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        List<Item> orderedItems =
                            widget.cart.items.keys.toList();
                        Order order = Order(
                          id: 1,
                          items: orderedItems,
                          totalPrice: totalPrice,
                          isPaid: true,
                          status: OrderStatus.Checkout,
                          dateTime: DateTime.now(),
                          shippingCost: totalPrice,
                        );
                        return OrderHistoryPage(orders: [order]);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF79BAEC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                ),
                child: Text(
                  'Bayar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
