import 'dart:convert';
import 'package:flutter_oru_phones/models/Product.dart';
import 'package:http/http.dart' as http;

class Api {
  // Base URL for your API
  static final String baseUrl = 'http://40.90.224.241:5000';

  // Method to fetch products with the provided filter
  static Future<List<Product>> fetchProducts(Map<String, dynamic>? filterData) async {
    final url = Uri.parse('$baseUrl/filter');

    // Sending POST request with filter data in the body
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"filter": filterData}),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the JSON
      List<dynamic> products = jsonDecode(response.body)['data']['data'];
      return products.map((product) => Product.fromMap(product)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load products');
    }
  }
}
