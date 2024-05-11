import 'package:flutter/material.dart';
import 'dart:async';

import '../models/items.dart';
import '../models/shopping_cart.dart';
import '../models/order.dart' as my_order; // Menamai Order dengan nama lain
import '../service/items_service.dart';
import '../order_history_page.dart';
import '../shopping_cart_page.dart';
import 'order_status_page.dart';

class HomePage extends StatefulWidget {
  final List<my_order.Order> orders; // Menggunakan my_order.Order

  HomePage({required this.orders});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Item> _items;
  late List<Item> _displayedItems;
  late TextEditingController _searchController;
  late ShoppingCart cart;
  String userId = ''; // Declare userId variable
  String userToken = ''; // Declare userToken variable

  // Slideshow
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _items = [];
    _displayedItems = [];
    _fetchItems();
    cart = ShoppingCart();
    // Slideshow
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _pageController.dispose();
    _timer?.cancel(); // Cancel timer to prevent memory leaks
    super.dispose();
  }

  Future<void> _fetchItems() async {
    List<Item> items = await ItemService().fetchItems();
    setState(() {
      _items = items;
      _displayedItems = items;
    });
  }

  void _search(String query) {
    List<Item> matchedItems = _items.where((item) {
      return item.title.toLowerCase().contains(query.toLowerCase()) ||
          item.description.toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      _displayedItems = matchedItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Accessing arguments
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userId = args['userId'] as String;
    userToken = args['userToken'] as String;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          leading: Container(),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartPage(
                      cart,
                    ),
                  ), // Hapus widget.orders dari sini
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
            // Slideshow
            SizedBox(
              height: 200,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  // Your slideshow items here
                  Image.network(
                    'https://lelogama.go-jek.com/post_featured_image/promo_makan_murah.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://lelogama.go-jek.com/post_featured_image/promo-ramadhan-go-food-extension.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://lelogama.go-jek.com/post_featured_image/promo-linkaja-gofood.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),

            // List Makanan
            Expanded(
              child: ListView.builder(
                itemCount: _displayedItems.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/item_detail',
                        arguments: {
                          'item': _displayedItems[index],
                          'cart': cart,
                        },
                      );
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _displayedItems[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _displayedItems[index].description,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Price: \$${_displayedItems[index].price.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 150, // Ukuran tombol diperkecil
                              height: 40, // Ukuran tombol diperkecil
                              child: ElevatedButton(
                                onPressed: () {
                                  cart.addToCart(_displayedItems[index]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Added to cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(
                                      0xFF79BAEC), // Warna background tombol
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(
                                  'Add to Cart',
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
                },
              ),
            ),
          ],
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
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderHistoryPage(orders: widget.orders),
                ),
              );
            } else if (index == 2) {
              my_order.Order firstOrder = widget.orders.isNotEmpty
                  ? widget.orders.first
                  : my_order.Order(
                      id: 1, // Atur id sesuai kebutuhan Anda
                      items: [], // Atur items sesuai kebutuhan Anda
                      totalPrice: 0, // Atur totalPrice sesuai kebutuhan Anda
                      shippingCost:
                          0, // Atur shippingCost sesuai kebutuhan Anda
                      dateTime:
                          DateTime.now(), // Atur dateTime sesuai kebutuhan Anda
                    );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderStatusPage(order: firstOrder),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
