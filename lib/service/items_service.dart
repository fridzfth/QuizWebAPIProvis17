import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/items.dart';

class ItemService {
  static const String _baseUrl =
      "http://146.190.109.66:8000/items/?skip=0&limit=100";
  static const String _imageUrlBase = "http://146.190.109.66:8000/items_image/";

  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$_baseUrl'), headers: {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imx5c2FSUlJhIiwiZXhwIjoxNzE1NDc5MjExfQ.niyCfQSweJMfUxIDmWOQ-Fy_pDqAlGH5x88DiXN1FRA', // Gunakan token yang diberikan
      'accept': 'application/json',
    });
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((itemJson) => Item.fromJson(itemJson)).toList();
    } else {
      throw Exception("Failed to load items ${response.statusCode}");
    }
  }

  Future<String> fetchItemImageUrl(String id) async {
    final String imageUrl = "http://146.190.109.66:8000/items_image/$id";
    final response = await http.get(
      Uri.parse(imageUrl),
      headers: {
        'accept': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imx5c2FSUlJhIiwiZXhwIjoxNzE1NDc5MjExfQ.niyCfQSweJMfUxIDmWOQ-Fy_pDqAlGH5x88DiXN1FRA', // Gunakan token yang diberikan
      },
    );
    if (response.statusCode == 200) {
      return imageUrl;
    } else {
      throw Exception("Failed to load item image ${response.statusCode}");
    }
  }
}
