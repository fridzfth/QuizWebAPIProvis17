import 'package:flutter/material.dart';
import '../models/order.dart';
import 'order_status_page.dart'; // Import halaman status pesanan

class OrderDetailPage extends StatelessWidget {
  final Order order;

  OrderDetailPage({required this.order});

  @override
  Widget build(BuildContext context) {
    double shippingCost =
        order.totalPrice * 0.2; // 20% dari total harga makanan
    double total = order.totalPrice + shippingCost;

    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/maps_icon.jpg', // Ganti dengan path gambar Anda
                fit: BoxFit.cover, // Atur gambar agar sesuai dengan lebar layar
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Order ID: ${order.id}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${order.dateTime}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Order Items:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: order.items.map((item) {
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('Price: \$${item.price.toStringAsFixed(2)}'),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Text(
              'Payment Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Subtotal: \$${order.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Shipping Cost: \$${shippingCost.toStringAsFixed(2)}', // Perbarui biaya pengiriman
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Text(
              'Total: \$${total.toStringAsFixed(2)}', // Perbarui total biaya
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // Widget Center untuk membuat tombol berada di tengah
            Center(
              child: Container(
                width:
                    MediaQuery.of(context).size.width * 0.8, // Lebar kontainer
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderStatusPage(order: order),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF79BAEC), // Warna background tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Text(
                    'Lacak Pesanan',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white, // Warna teks putih
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
}
