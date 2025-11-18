// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:house_of_champions/widgets/left_drawer.dart';

// Import modul untuk menerima input form via flutter
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:house_of_champions/screens/menu.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  /// GlobalKey untuk mengelola state form
  final _formKey = GlobalKey<FormState>();

  /// Variabel untuk menyimpan data produk
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "transfer";
  String _thumbnail1 = "";
  String _thumbnail2 = "";
  String _thumbnail3 = "";
  String _brandName = "brand";
  String _brandUrl = "";
  bool _isFeatured = false;
  int _stock = 0;
  double _rating = 0.0;

  /// Daftar kategori yang sesuai dengan model Django
  final List<String> _categories = [
    'transfer',
    'update',
    'exclusive',
    'match',
    'rumor',
    'analysis',
    'training',
    'special',
    'national',
    'classic',
    'derby'
  ];

  /// Base URL configuration untuk environment yang berbeda
  String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000';
    } else {
      return 'http://10.0.2.2:8000'; // Untuk Android emulator
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tambah Produk Baru',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      drawer: const LeftDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Color(0xFFE3F2FD)],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCard(),
                const SizedBox(height: 24),
                _buildProductNameField(),
                const SizedBox(height: 16),
                _buildPriceField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                _buildCategoryField(),
                const SizedBox(height: 16),
                _buildStockField(),
                const SizedBox(height: 16),
                _buildRatingField(),
                const SizedBox(height: 16),
                _buildBrandNameField(),
                const SizedBox(height: 16),
                _buildThumbnailFields(),
                const SizedBox(height: 16),
                _buildFeaturedSwitch(),
                const SizedBox(height: 24),
                _buildSubmitButton(request),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Membuat header card yang informatif
  Widget _buildHeaderCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[700]!, Colors.blue[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.add_business_rounded,
              size: 48,
              color: Colors.amber[400],
            ),
            const SizedBox(height: 12),
            const Text(
              'Tambah Produk Baru',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi informasi produk untuk ditambahkan ke katalog',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk nama produk
  Widget _buildProductNameField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Masukkan nama produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.shopping_bag, color: Colors.blue[600]),
              ),
              onChanged: (value) => setState(() => _name = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Nama produk wajib diisi";
                }
                if (value.length < 3) {
                  return "Nama produk minimal 3 karakter";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk harga produk
  Widget _buildPriceField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Harga Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Masukkan harga produk',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.attach_money, color: Colors.green[600]),
                suffixText: 'IDR',
              ),
              onChanged: (value) {
                setState(() => _price = int.tryParse(value) ?? 0);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Harga produk wajib diisi";
                }
                if (int.tryParse(value) == null) {
                  return "Harga harus berupa angka";
                }
                if (int.tryParse(value)! <= 0) {
                  return "Harga harus lebih dari 0";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk deskripsi produk
  Widget _buildDescriptionField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Deskripsikan produk secara detail...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                alignLabelWithHint: true,
              ),
              onChanged: (value) => setState(() => _description = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Deskripsi produk wajib diisi";
                }
                if (value.length < 10) {
                  return "Deskripsi minimal 10 karakter";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Dropdown untuk kategori produk
  Widget _buildCategoryField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.category, color: Colors.blue[600]),
              ),
              value: _category,
              items: _categories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category[0].toUpperCase() + category.substring(1),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() => _category = newValue!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Pilih kategori produk";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk stok produk
  Widget _buildStockField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Stok Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: '0',
              decoration: InputDecoration(
                hintText: 'Masukkan jumlah stok',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.inventory, color: Colors.orange[600]),
              ),
              onChanged: (value) {
                setState(() => _stock = int.tryParse(value) ?? 0);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Stok produk wajib diisi";
                }
                if (int.tryParse(value) == null) {
                  return "Stok harus berupa angka";
                }
                if (int.tryParse(value)! < 0) {
                  return "Stok tidak boleh negatif";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk rating produk
  Widget _buildRatingField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating Produk *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              keyboardType: TextInputType.number,
              initialValue: '0.0',
              decoration: InputDecoration(
                hintText: 'Masukkan rating (0.0 - 5.0)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.star, color: Colors.amber[600]),
              ),
              onChanged: (value) {
                setState(() => _rating = double.tryParse(value) ?? 0.0);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Rating produk wajib diisi";
                }
                if (double.tryParse(value) == null) {
                  return "Rating harus berupa angka";
                }
                final ratingValue = double.tryParse(value)!;
                if (ratingValue < 0 || ratingValue > 5) {
                  return "Rating harus antara 0.0 - 5.0";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Field untuk nama brand
  Widget _buildBrandNameField() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Brand',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: 'brand',
              decoration: InputDecoration(
                hintText: 'Masukkan nama brand',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.business, color: Colors.purple[600]),
              ),
              onChanged: (value) => setState(() => _brandName = value),
            ),
          ],
        ),
      ),
    );
  }

  /// Fields untuk thumbnail URLs
  Widget _buildThumbnailFields() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gambar Produk (Opsional)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Thumbnail 1',
              'URL gambar utama produk',
              _thumbnail1,
              (value) => setState(() => _thumbnail1 = value),
              1,
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Thumbnail 2',
              'URL gambar tambahan (opsional)',
              _thumbnail2,
              (value) => setState(() => _thumbnail2 = value),
              2,
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Thumbnail 3',
              'URL gambar tambahan (opsional)',
              _thumbnail3,
              (value) => setState(() => _thumbnail3 = value),
              3,
            ),
          ],
        ),
      ),
    );
  }

  /// Helper untuk membuat field thumbnail individual
  Widget _buildThumbnailField(
    String label,
    String hint,
    String value,
    Function(String) onChanged,
    int index,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.blue[400]!),
            ),
            prefixIcon: Icon(Icons.image, color: Colors.green[600]),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  /// Switch untuk menandai produk sebagai featured
  Widget _buildFeaturedSwitch() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.featured_play_list,
              color: _isFeatured ? Colors.amber : Colors.grey,
              size: 28,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Produk Unggulan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _isFeatured
                        ? 'Produk akan ditampilkan sebagai unggulan'
                        : 'Produk akan ditampilkan sebagai biasa',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: _isFeatured,
              onChanged: (value) => setState(() => _isFeatured = value),
              activeColor: Colors.amber,
              activeTrackColor: Colors.amber[100],
            ),
          ],
        ),
      ),
    );
  }

  /// Tombol submit form dengan error handling yang diperbaiki
  Widget _buildSubmitButton(CookieRequest request) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          shadowColor: Colors.blue[200],
        ),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            
            // Tampilkan loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            );

            try {
              // Siapkan data untuk dikirim
              final Map<String, dynamic> productData = {
                "name": _name,
                "price": _price,
                "description": _description,
                "category": _category,
                "thumbnail1": _thumbnail1,
                "thumbnail2": _thumbnail2,
                "thumbnail3": _thumbnail3,
                "is_featured": _isFeatured,
                "stock": _stock,
                "rating": _rating,
                "brandName": _brandName,
                "brand": _brandUrl,
              };

              // Debug: Print data yang akan dikirim
              print('📤 Mengirim data produk: $productData');

              // Kirim data ke endpoint Django dengan URL yang sesuai
              final response = await request.postJson(
                "$_baseUrl/create-product-flutter/",
                jsonEncode(productData),
              );

              // Debug: Print response dari server
              print('📥 Response dari server: $response');
              print('📋 Tipe response: ${response.runtimeType}');

              // Tutup loading indicator
              if (context.mounted) {
                Navigator.of(context).pop();
              }

              // Validasi struktur response
              if (response is! Map<String, dynamic>) {
                throw FormatException('Response tidak dalam format JSON yang valid');
              }

              // Handle response berdasarkan status
              if (response['status'] == 'success') {
                _showSuccessDialog(context);
              } else {
                final errorMessage = response['message'] ?? 'Terjadi kesalahan yang tidak diketahui';
                _showErrorDialog(context, errorMessage);
              }

            } on FormatException catch (e) {
              // Handle JSON format errors
              if (context.mounted) {
                Navigator.of(context).pop();
                _showErrorDialog(
                  context, 
                  'Format data tidak valid: ${e.message}\n\nPastikan server Django berjalan dan endpoint benar.'
                );
              }
              print('❌ FormatException: ${e.message}');
            } on Exception catch (e) {
              // Handle other exceptions
              if (context.mounted) {
                Navigator.of(context).pop();
                _showErrorDialog(
                  context, 
                  'Koneksi gagal: ${e.toString()}\n\nPeriksa:\n1. Koneksi internet\n2. Server Django berjalan\n3. URL endpoint: $_baseUrl'
                );
              }
              print('❌ Exception: $e');
            }
          }
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.save_alt_rounded, size: 24),
            SizedBox(width: 8),
            Text(
              "Simpan Produk",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Menampilkan dialog sukses
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 28),
            SizedBox(width: 8),
            Text('Berhasil!'),
          ],
        ),
        content: const Text('Produk berhasil ditambahkan ke katalog.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: const Text('OK'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Menampilkan dialog error dengan informasi yang lebih detail
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Gagal Menyimpan Produk'),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(message),
              const SizedBox(height: 16),
              const Text(
                'Tips:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Pastikan server Django berjalan'),
              const Text('• Periksa koneksi internet'),
              const Text('• Cek log server untuk detail error'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _buildSubmitButton(context.read<CookieRequest>());
            },
            child: const Text('Coba Lagi'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}