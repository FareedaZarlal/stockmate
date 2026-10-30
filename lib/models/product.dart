import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final int quantity;
  final String category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    this.category = 'General',
  });

  // Convert Product → Map (for saving as JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }

  // Create Product from Map (when loading from storage)
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      category: json['category'] as String? ?? 'General',
    );
  }

  // Stock status text
  String get stockStatus {
    if (quantity <= 0) return 'Out of Stock';
    if (quantity <= 5) return 'Low Stock';
    return 'In Stock';
  }

  // Color for the status badge
  Color get statusColor {
    if (quantity <= 0) return Colors.red.shade600;
    if (quantity <= 5) return Colors.orange.shade600;
    return Colors.green.shade600;
  }
}
