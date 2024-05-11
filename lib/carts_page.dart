import 'package:flutter/material.dart';
import '../service/cart_service.dart';

class CartItemsPage extends StatefulWidget {
  final String userId;

  CartItemsPage({required this.userId});

  @override
  _CartItemsPageState createState() => _CartItemsPageState();
}

class _CartItemsPageState extends State<CartItemsPage> {
  List<dynamic> _cartItems = []; // Initialize _cartItems list

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      List<dynamic> response = await CartService().getCarts(widget.userId);
      setState(() {
        _cartItems = response;
      });
    } catch (e) {
      print('Error fetching cart items: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Items'),
      ),
      body: _cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: _cartItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item ID: ${_cartItems[index]['item_id']}'),
                  subtitle: Text('Quantity: ${_cartItems[index]['quantity']}'),
                  // Add more details if needed
                );
              },
            )
          : Center(
              child: Text('Kosong'),
            ),
    );
  }
}
