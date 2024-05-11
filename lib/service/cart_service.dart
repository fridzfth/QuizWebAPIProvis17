import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart.dart';

class CartService {
  static const String baseUrl = 'http://146.190.109.66:8000/carts/';

  Future<Cart> createCart(int userId, int itemId, int quantity) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imx5c2FSUlJhIiwiZXhwIjoxNzE1NDc5MjExfQ.niyCfQSweJMfUxIDmWOQ-Fy_pDqAlGH5x88DiXN1FRA',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'user_id': userId,
        'item_id': itemId,
        'quantity': quantity,
      }),
    );
    if (response.statusCode == 200) {
      return Cart.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create cart: ${response.statusCode}');
    }
  }

  Future<List<dynamic>> getCarts(String userId,
      {int skip = 0, int limit = 100}) async {
    final response = await http.get(
      Uri.parse('$baseUrl$userId?skip=$skip&limit=$limit'),
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imx5c2FSUlJhIiwiZXhwIjoxNzE1NDc5MjExfQ.niyCfQSweJMfUxIDmWOQ-Fy_pDqAlGH5x88DiXN1FRA',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get carts: ${response.statusCode}');
    }
  }
}
