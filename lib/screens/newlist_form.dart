// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:house_of_champions/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  // Menambahkan variable baru
  final _formKey = GlobalKey<FormState>();

  // default variable
  String _name = "";
  int _price = 0;
  String _description = "";
  String _category = "jersey";
  String _specification = "match";
  String _thumbnail = "";
  bool _isFeatured = false;

  final List<String> _categories = [
    'jersey',
    'shoes',
    'ball',
    'accessories',
    'equipment',
  ];

  final List<String> _specifications = [
    'transfer',
    'derby',
    'match',
    'exclusive',
    'rumor',
    'legends',
    'epic',
    'new',
    'nostalgia',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background gradient yang menarik
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Center(child: Text('Tambah Produk Baru')),
        backgroundColor: Colors.blue[800], // Warna biru football
        foregroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      drawer: LeftDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey[850]!,
              Colors.grey[900]!,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dengan gradient
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue[800]!,
                        Colors.green[700]!,
                      ],
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.sports_soccer,
                        size: 50,
                        color: Colors.amber[400],
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'House of Champions',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        'Tambah Produk Merchandise',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // === Nama Produk ===
                _buildFormField(
                  hintText: "Nama Produk",
                  labelText: "Nama Produk",
                  icon: Icons.shopping_bag,
                  onChanged: (value) => setState(() => _name = value!),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Product Anda harus mempunyai nama!";
                    }
                    return null;
                  },
                ),

                // === Harga Produk ===
                _buildFormField(
                  hintText: "Harga Produk",
                  labelText: "Harga Produk",
                  icon: Icons.attach_money,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() => _price = int.tryParse(value!) ?? 0);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Harga tidak boleh kosong!";
                    }
                    if (int.tryParse(value) == null) {
                      return "Harga harus berupa angka!";
                    }
                    if (int.tryParse(value)! < 0) {
                      return "Harga tidak boleh negatif";
                    }
                    return null;
                  },
                ),

                // === Description ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Deskripsi Produk",
                      labelText: "Deskripsi Produk",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      labelStyle: const TextStyle(color: Colors.amber),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blue[400]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.grey[600]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        borderSide: BorderSide(color: Colors.blue[400]!),
                      ),
                      filled: true,
                      fillColor: Colors.grey[800],
                      prefixIcon: Icon(Icons.description, color: Colors.blue[300]),
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        _description = value!;
                      });
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Anda wajib memberikan deskripsi singkat untuk product Anda!";
                      }
                      return null;
                    },
                  ),
                ),

                // === Kategori ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!),
                    ),
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Kategori Produk",
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.category, color: Colors.blue[300]),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      value: _category,
                      items: _categories
                          .map(
                            (cat) => DropdownMenuItem(
                              value: cat,
                              child: Text(
                                cat[0].toUpperCase() + cat.substring(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _category = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                // === Spesifikasi ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!),
                    ),
                    child: DropdownButtonFormField<String>(
                      dropdownColor: Colors.grey[800],
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "Spesifikasi Produk",
                        labelStyle: const TextStyle(color: Colors.amber),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.star, color: Colors.blue[300]),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      ),
                      value: _specification,
                      items: _specifications
                          .map(
                            (spec) => DropdownMenuItem(
                              value: spec,
                              child: Text(
                                spec[0].toUpperCase() + spec.substring(1),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _specification = newValue!;
                        });
                      },
                    ),
                  ),
                ),

                // === Thumbnail ===
                _buildFormField(
                  hintText: "URL Thumbnail (opsional)",
                  labelText: "URL Thumbnail",
                  icon: Icons.image,
                  onChanged: (value) => setState(() => _thumbnail = value!),
                ),

                // === Is Featured ===
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[600]!),
                    ),
                    child: SwitchListTile(
                      title: const Text(
                        "Tandai sebagai Produk Unggulan",
                        style: TextStyle(color: Colors.white),
                      ),
                      secondary: Icon(
                        Icons.featured_play_list,
                        color: _isFeatured ? Colors.amber : Colors.grey[400],
                      ),
                      value: _isFeatured,
                      onChanged: (bool value) {
                        setState(() {
                          _isFeatured = value;
                        });
                      },
                      activeColor: Colors.amber,
                    ),
                  ),
                ),

                // === Tombol Simpan ===
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.pressed)) {
                              return Colors.green[700]!;
                            }
                            return Colors.blue[700]!;
                          },
                        ),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        elevation: MaterialStateProperty.all(8),
                        shadowColor: MaterialStateProperty.all(Colors.blue[200]),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.grey[800],
                                title: const Text(
                                  'Produk Berhasil Disimpan! 🎉',
                                  style: TextStyle(
                                    color: Colors.amber,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildDialogItem('Nama Produk', _name),
                                      _buildDialogItem('Harga', 'Rp $_price'),
                                      _buildDialogItem('Kategori', _category),
                                      _buildDialogItem('Spesifikasi', _specification),
                                      _buildDialogItem('Thumbnail', _thumbnail.isEmpty ? 'Tidak ada' : _thumbnail),
                                      _buildDialogItem('Unggulan', _isFeatured ? "Ya" : "Tidak"),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text(
                                      'OK',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _formKey.currentState!.reset();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.save, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Simpan Produk",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method untuk membuat form field yang konsisten
  Widget _buildFormField({
    required String hintText,
    required String labelText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText,
          hintStyle: TextStyle(color: Colors.grey[400]),
          labelStyle: const TextStyle(color: Colors.amber),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[600]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue[400]!),
          ),
          filled: true,
          fillColor: Colors.grey[800],
          prefixIcon: Icon(icon, color: Colors.blue[300]),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  // Helper method untuk item dialog
  Widget _buildDialogItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}