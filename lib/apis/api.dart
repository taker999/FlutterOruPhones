import 'dart:convert';
import 'dart:developer';
import 'package:flutter_oru_phones/models/Product.dart';
import 'package:http/http.dart' as http;

import '../models/brand.dart';

class Api {
  // Base URL for your API
  static final String baseUrl = 'http://40.90.224.241:5000';

  // Method to fetch products with the provided filter
  static Future<List<Product>> fetchProducts(Map<String, dynamic> filterData) async {
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
      log(products[0].toString());
      return products.map((product) => Product.fromMap(product)).toList();
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load products');
    }
  }

  static Future<List<Brand>> fetchBrands() async {
    final url = Uri.parse('$baseUrl/makeWithImages');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> brands = jsonDecode(response.body)['dataObject'];
      return brands.map((brand) => Brand.fromMap(brand)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }
}
