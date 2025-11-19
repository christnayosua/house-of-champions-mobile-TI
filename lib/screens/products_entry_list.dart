// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:house_of_champions/models/products_entry.dart';
import 'package:house_of_champions/screens/newlist_form.dart';
import 'package:house_of_champions/screens/products_detail.dart';
import 'package:house_of_champions/widgets/left_drawer.dart';
import 'package:house_of_champions/widgets/products_entry_card.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductsEntryListPage extends StatefulWidget {
  const ProductsEntryListPage({super.key});

  @override
  State<ProductsEntryListPage> createState() => _ProductsEntryListPageState();
}

class _ProductsEntryListPageState extends State<ProductsEntryListPage> {
  String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  /// Fetch products dari endpoint user-products-json
  Future<List<ProductsEntry>> fetchUserProducts(CookieRequest request) async {
    try {
      print('🔄 Fetching user products from: $_baseUrl/user-products-json/');

      final response = await request.get('$_baseUrl/user-products-json/');

      print('📥 Response type: ${response.runtimeType}');
      print('📥 Response data: $response');

      // Handle response structure
      if (response is Map<String, dynamic>) {
        if (response['status'] == 'success') {
          var productsData = response['products'] as List;
          print('✅ Found ${productsData.length} products for user: ${response['user']}');

          // Convert json data to ProductsEntry objects dengan error handling
          List<ProductsEntry> listProducts = [];
          for (var productData in productsData) {
            if (productData != null) {
              try {
                // Convert flat structure ke nested structure yang diharapkan model
                final nestedProductData = _convertToNestedStructure(productData);
                listProducts.add(ProductsEntry.fromJson(nestedProductData));
              } catch (e) {
                print('❌ Error parsing product: $e');
                print('❌ Problematic data: $productData');
                continue;
              }
            }
          }
          return listProducts;
        } else {
          throw Exception('Server error: ${response['message']}');
        }
      } else {
        throw FormatException('Invalid response format from server');
      }
    } catch (e) {
      print('❌ Error in fetchUserProducts: $e');
      rethrow;
    }
  }

  /// Convert flat structure dari server ke nested structure yang diharapkan model
  Map<String, dynamic> _convertToNestedStructure(Map<String, dynamic> flatData) {    
    return {
      "model": "main.productsentry",
      "pk": flatData['id'] ?? '',
      "fields": {
        "user": flatData['user'] ?? 0, // Sekarang integer dari Django
        "name": flatData['name'] ?? 'Unknown Product',
        "price": flatData['price'] ?? 0,
        "description": flatData['description'] ?? 'No description available',
        "thumbnail1": flatData['thumbnail1'] ?? '',
        "thumbnail2": flatData['thumbnail2'],
        "thumbnail3": flatData['thumbnail3'],
        "category": flatData['category'] ?? 'general',
        "is_featured": flatData['is_featured'] ?? false,
        "stock": flatData['stock'] ?? 0,
        "rating": flatData['rating'] ?? 0,
        "brand": flatData['brand'], // Biarkan dynamic (bisa null)
        "brandName": flatData['brandName'] ?? 'brand',
        "created_at": flatData['created_at'] ?? DateTime.now().toIso8601String(),
        "visitors": flatData['visitors'] ?? 0,
      }
    };
  }

  Future<void> _refreshData(CookieRequest request) async {
    setState(() {});
  }

  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProductFormPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Katalog Produk Saya',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () => _refreshData(request),
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      drawer: const LeftDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(request),
        child: FutureBuilder(
          future: fetchUserProducts(request),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Memuat produk...',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              print('❌ Snapshot error: ${snapshot.error}');
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 80,
                        color: Colors.red[400],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Gagal Memuat Produk',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        snapshot.error.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: () => _refreshData(request),
                        icon: const Icon(Icons.refresh),
                        label: const Text('Coba Lagi'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 100,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Belum Ada Produk',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Anda belum menambahkan produk apapun.\nMulai dengan menambahkan produk pertama Anda!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () => _navigateToAddProduct(context),
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text('Tambah Produk Pertama'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final products = snapshot.data!;
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!, width: 1),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${products.length} Produk Ditemukan',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Hanya menampilkan produk milik Anda',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.blue[700],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Milik Anda',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return ProductsEntryCard(
                        products: product,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToAddProduct(context),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah Produk'),
        elevation: 4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}