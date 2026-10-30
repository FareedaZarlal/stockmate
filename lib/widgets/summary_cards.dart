import 'package:flutter/material.dart';

import '../models/product.dart';

class SummaryCards extends StatelessWidget {
  final List<Product> products;

  const SummaryCards({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final int totalProducts = products.length;
    final int lowStockCount = products
        .where((p) => p.quantity > 0 && p.quantity <= 5)
        .length;
    final double totalValue = products.fold(
      0,
      (sum, p) => sum + (p.price * p.quantity),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          Expanded(
            child: _SummaryCard(
              title: 'Products',
              value: totalProducts.toString(),
              icon: Icons.inventory_2_outlined,
              color: const Color(0xFF0D9488),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SummaryCard(
              title: 'Low Stock',
              value: lowStockCount.toString(),
              icon: Icons.warning_amber_rounded,
              color: Colors.orange.shade600,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _SummaryCard(
              title: 'Value',
              value: 'Rs ${totalValue.toStringAsFixed(0)}',
              icon: Icons.payments_outlined,
              color: Colors.blue.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
