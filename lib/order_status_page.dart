import 'dart:async';
import 'package:flutter/material.dart';
import '../models/order.dart';

class OrderStatusPage extends StatefulWidget {
  final Order order;

  OrderStatusPage({required this.order});

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  late Timer _timer;
  late String _status;

  @override
  void initState() {
    super.initState();
    _status = 'Sedang Diproses';
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        // Ubah status pesanan di sini berdasarkan logika Anda
        // Misalnya: Pesanan diproses -> Pesanan dimasak -> Pesanan diantar -> Pesanan sampai
        // Anda bisa menggunakan indeks atau variabel untuk melacak status saat ini
        // Misalnya:
        if (_status == 'Sedang Diproses') {
          _status = 'Sedang Dimasak';
        } else if (_status == 'Sedang Dimasak') {
          _status = 'Sedang Diantar (4KM dari tujuan)';
        } else if (_status == 'Sedang Diantar (4KM dari tujuan)') {
          _status = 'Sedang Diantar (1KM dari tujuan)';
        } else if (_status == 'Sedang Diantar (1KM dari tujuan)') {
          _status = 'Pesanan Sampai';
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status Pesanan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Status Pesanan untuk Order ID ${widget.order.id}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Status: $_status',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
