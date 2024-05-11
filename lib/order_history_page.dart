import 'package:flutter/material.dart';
import '../models/order.dart';
import 'order_detail_page.dart'; // Import OrderDetailPage

class OrderHistoryPage extends StatelessWidget {
  final List<Order> orders;

  OrderHistoryPage({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          if (orders[index].isPaid) {
            return ListTile(
              title: Text('Order ID: ${orders[index].id}'),
              subtitle: Text(
                  'Total Price: \$${orders[index].totalPrice.toStringAsFixed(2)}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderDetailPage(order: orders[index]),
                  ),
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Pesanan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Status Pesanan',
          ),
        ],
        onTap: (index) {
          // Navigasi ke halaman detail pesanan hanya jika indeks adalah 1 (Pesanan)
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailPage(order: orders[index]),
              ),
            );
          }
        },
      ),
    );
  }
}
