import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/storage_service.dart';
import '../widgets/product_card.dart';
import '../widgets/summary_cards.dart';
import '../widgets/empty_state.dart';
import 'product_form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await StorageService.loadProducts();
    setState(() {
      _products = products;
      _filteredProducts = products;
      _isLoading = false;
    });
  }

  Future<void> _saveAndRefresh() async {
    await StorageService.saveProducts(_products);
    setState(() {
      _filteredProducts = _applySearch(_searchController.text);
    });
  }

  List<Product> _applySearch(String query) {
    if (query.trim().isEmpty) return _products;
    return _products
        .where(
          (p) =>
              p.name.toLowerCase().contains(query.toLowerCase()) ||
              p.category.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  void _onSearchChanged(String value) {
    setState(() {
      _filteredProducts = _applySearch(value);
    });
  }

  Future<void> _addProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ProductFormScreen()),
    );

    if (result != null && result is Product) {
      setState(() {
        _products.add(result);
      });
      await _saveAndRefresh();
      _showSnackBar('Product added successfully');
    }
  }

  Future<void> _editProduct(Product product) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ProductFormScreen(product: product)),
    );

    if (result != null && result is Product) {
      final index = _products.indexWhere((p) => p.id == product.id);
      if (index != -1) {
        setState(() {
          _products[index] = result;
        });
        await _saveAndRefresh();
        _showSnackBar('Product updated');
      }
    }
  }

  Future<void> _deleteProduct(Product product) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Product'),
        content: Text('Are you sure you want to delete "${product.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        _products.removeWhere((p) => p.id == product.id);
      });
      await _saveAndRefresh();
      _showSnackBar('Product deleted');
    }
  }

  void _increaseQuantity(Product product) {
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      setState(() {
        _products[index] = Product(
          id: product.id,
          name: product.name,
          price: product.price,
          quantity: product.quantity + 1,
          category: product.category,
        );
      });
      _saveAndRefresh();
    }
  }

  void _decreaseQuantity(Product product) {
    if (product.quantity <= 0) return;

    final index = _products.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      setState(() {
        _products[index] = Product(
          id: product.id,
          name: product.name,
          price: product.price,
          quantity: product.quantity - 1,
          category: product.category,
        );
      });
      _saveAndRefresh();
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'StockMate',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Summary Cards
                if (_products.isNotEmpty) SummaryCards(products: _products),

                // Search Bar
                if (_products.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                    ),
                  ),

                // Product List or Empty State
                Expanded(
                  child: _filteredProducts.isEmpty
                      ? EmptyState(onAddPressed: _addProduct)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                          itemCount: _filteredProducts.length,
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onEdit: () => _editProduct(product),
                              onDelete: () => _deleteProduct(product),
                              onIncrease: () => _increaseQuantity(product),
                              onDecrease: () => _decreaseQuantity(product),
                            );
                          },
                        ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addProduct,
        backgroundColor: const Color(0xFF0D9488),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Product'),
      ),
    );
  }
}
