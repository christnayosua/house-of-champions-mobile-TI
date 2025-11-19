// ignore_for_file: deprecated_member_use, unused_import, use_build_context_synchronously, prefer_final_fields, avoid_print

import 'package:flutter/material.dart';
import 'package:house_of_champions/widgets/left_drawer.dart';

// Import modul untuk menerima input form via flutter
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:house_of_champions/screens/menu.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// [ProductFormPage] - Halaman untuk membuat produk baru
/// 
/// Fitur:
/// - Form input produk dengan validasi
/// - Integrasi dengan endpoint Django create_product_flutter
/// - Support multiple environment (Web & Android)
/// - Error handling yang komprehensif
class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  /// GlobalKey untuk mengelola state form
  final _formKey = GlobalKey<FormState>();

  /// Variabel untuk menyimpan data produk
  /// Sesuai dengan model Products di Django
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

  /// Daftar kategori yang sesuai dengan CATEGORY_CHOICES di model Django
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

  /// Mendapatkan base URL berdasarkan platform
  /// 
  /// Returns:
  /// - 'http://localhost:8000' untuk web
  /// - 'http://10.0.2.2:8000' untuk Android emulator
  String get _baseUrl {
    if (kIsWeb) {
      return 'http://localhost:8000';
    } else {
      return 'http://10.0.2.2:8000';
    }
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Tambah Berita Baru',
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
              Icons.article_rounded,
              size: 48,
              color: Colors.amber[400],
            ),
            const SizedBox(height: 12),
            const Text(
              'Tambah Berita Baru',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lengkapi informasi berita untuk ditambahkan ke katalog',
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

  /// Field untuk nama produk/berita
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
              'Judul Berita *',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Masukkan judul berita',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.title, color: Colors.blue[600]),
              ),
              onChanged: (value) => setState(() => _name = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Judul berita wajib diisi";
                }
                if (value.length < 3) {
                  return "Judul berita minimal 3 karakter";
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
              'Harga *',
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
                hintText: 'Masukkan harga',
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
                  return "Harga wajib diisi";
                }
                if (int.tryParse(value) == null) {
                  return "Harga harus berupa angka";
                }
                final priceValue = int.tryParse(value)!;
                if (priceValue <= 0) {
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

  /// Field untuk deskripsi produk/berita
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
              'Konten Berita *',
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
                hintText: 'Tulis konten berita secara detail...',
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
                  return "Konten berita wajib diisi";
                }
                if (value.length < 10) {
                  return "Konten berita minimal 10 karakter";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Dropdown untuk kategori berita
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
              'Kategori Berita *',
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
                          _getCategoryDisplayName(category),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                setState(() => _category = newValue!);
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Pilih kategori berita";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Helper method untuk mendapatkan display name kategori
  String _getCategoryDisplayName(String category) {
    final displayNames = {
      'transfer': 'Transfer',
      'update': 'Update',
      'exclusive': 'Exclusive',
      'match': 'Pertandingan',
      'rumor': 'Rumor',
      'analysis': 'Analisis',
      'training': 'Training',
      'special': 'Spesial',
      'national': 'Nasional',
      'classic': 'Klasik',
      'derby': 'Derby',
    };
    return displayNames[category] ?? category[0].toUpperCase() + category.substring(1);
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
              'Stok *',
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
                  return "Stok wajib diisi";
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
              'Rating *',
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
                  return "Rating wajib diisi";
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
              'Nama Sumber Berita',
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
                hintText: 'Masukkan nama sumber berita',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.blue[400]!),
                ),
                prefixIcon: Icon(Icons.source, color: Colors.purple[600]),
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
              'Gambar Berita (Opsional)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Gambar Utama',
              'URL gambar utama berita',
              _thumbnail1,
              (value) => setState(() => _thumbnail1 = value),
              1,
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Gambar Tambahan 1',
              'URL gambar tambahan (opsional)',
              _thumbnail2,
              (value) => setState(() => _thumbnail2 = value),
              2,
            ),
            const SizedBox(height: 12),
            _buildThumbnailField(
              'Gambar Tambahan 2',
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

  /// Switch untuk menandai berita sebagai featured
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
                    'Berita Unggulan',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    _isFeatured
                        ? 'Berita akan ditampilkan sebagai unggulan'
                        : 'Berita akan ditampilkan sebagai biasa',
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

  /// Tombol submit form dengan integrasi ke Django endpoint
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
          // Validasi form sebelum submit
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
              // Siapkan data sesuai dengan struktur yang diharapkan Django view
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
              print('📤 Mengirim data ke Django: $productData');

              // Kirim data ke endpoint create_product_flutter di Django
              final response = await request.postJson(
                "$_baseUrl/create-product-flutter/", // Sesuai dengan URL di urls.py
                jsonEncode(productData),
              );

              // Debug: Print response dari server
              print('📥 Response dari Django: $response');

              // Tutup loading indicator
              if (context.mounted) {
                Navigator.of(context).pop();
              }

              // Handle response berdasarkan status dari Django
              if (response['status'] == 'success') {
                _showSuccessDialog(context, response);
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
                  'Format data tidak valid: ${e.message}'
                );
              }
              print('❌ FormatException: ${e.message}');
            } on Exception catch (e) {
              // Handle other exceptions (network, server error, dll)
              if (context.mounted) {
                Navigator.of(context).pop();
                _showErrorDialog(
                  context, 
                  'Koneksi gagal: ${e.toString()}'
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
              "Simpan Berita",
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

  /// Menampilkan dialog sukses dengan data dari response Django
  void _showSuccessDialog(BuildContext context, Map<String, dynamic> response) {
    final productData = response['product_data'] ?? {};
    
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
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Berita berhasil ditambahkan ke katalog.'),
            const SizedBox(height: 12),
            if (productData.isNotEmpty) ...[
              const Text(
                'Detail:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text('Judul: ${productData['name'] ?? '-'}'),
              Text('Kategori: ${_getCategoryDisplayName(productData['category'] ?? '')}'),
              Text('Harga: ${productData['formatted_price'] ?? '-'}'),
              Text('ID: ${productData['id'] ?? response['product_id'] ?? '-'}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
            child: const Text('Kembali ke Menu'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Menampilkan dialog error dengan informasi yang detail
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 28),
            SizedBox(width: 8),
            Text('Gagal Menyimpan Berita'),
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
                'Tips Pemecahan Masalah:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text('• Pastikan server Django berjalan'),
              const Text('• Periksa koneksi internet Anda'),
              const Text('• Pastikan Anda sudah login'),
              const Text('• Cek URL endpoint: /create-product-flutter/'),
              const Text('• Verifikasi data yang diinput sudah valid'),
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
              // Coba submit lagi
              if (_formKey.currentState!.validate()) {
                _buildSubmitButton(context.read<CookieRequest>());
              }
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