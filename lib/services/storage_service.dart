import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class StorageService {
  static const String _key = 'stockmate_products';

  // Load all products from local storage
  static Future<List<Product>> loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_key);

    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded.map((item) => Product.fromJson(item)).toList();
  }

  // Save the full list of products
  static Future<void> saveProducts(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(
      products.map((product) => product.toJson()).toList(),
    );
    await prefs.setString(_key, encoded);
  }
}
