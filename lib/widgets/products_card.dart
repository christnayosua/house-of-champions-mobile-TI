// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:house_of_champions/screens/menu.dart';
import 'package:house_of_champions/screens/newlist_form.dart';
import 'package:house_of_champions/screens/products_entry_list.dart';

// Membuat fitur logout
import 'package:house_of_champions/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              item.color.withOpacity(0.9),
              item.color.withOpacity(0.7),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: () => _handleCardTap(context, request),
            borderRadius: BorderRadius.circular(16),
            splashColor: Colors.white.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.1),
            
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item.icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  
                  const SizedBox(height: 12),
                  
                  Text(
                    item.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 4),
                  
                  _buildSubtitle(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    String subtitle = '';
    Color subtitleColor = Colors.white.withOpacity(0.8);
    
    switch (item.name) {
      case "Create Product":
        subtitle = 'Tambah produk baru';
        break;
      case "See House Of Champions Products":
        subtitle = 'Lihat semua produk';
        break;
      case "Logout":
        subtitle = 'Keluar dari akun';
        break;
      default:
        subtitle = 'Tap untuk melihat';
    }
    
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: subtitleColor,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Future<void> _handleCardTap(BuildContext context, CookieRequest request) async {
    _showSnackBar(context, "Kamu telah menekan tombol ${item.name}!");
    
    switch (item.name) {
      case "Create Product":
        _navigateToCreateProduct(context);
        break;
      case "My Products":
        _navigateToProductsList(context);
        break;
      case "Logout":
        await _showLogoutConfirmation(context, request);
        break;
      default:
        break;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: item.color,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  void _navigateToCreateProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductFormPage()),
    );
  }

  void _navigateToProductsList(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProductsEntryListPage()),
    );
  }

  // TAMBAHKAN: Dialog konfirmasi logout
  Future<void> _showLogoutConfirmation(BuildContext context, CookieRequest request) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.blue),
            SizedBox(width: 8),
            Text('Konfirmasi Logout'),
          ],
        ),
        content: const Text('Apakah Anda yakin ingin logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );

    if (result == true) {
      await _performLogout(context, request);
    }
  }

  Future<void> _performLogout(BuildContext context, CookieRequest request) async {
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
      final response = await request.logout("http://10.0.2.2:8000/auth/logout/");
      
      if (context.mounted) {
        Navigator.of(context).pop(); // Tutup loading indicator
        
        if (response['status']) {
          String message = response["message"];
          String uname = response["username"];
          
          // Tampilkan snackbar sukses
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("$message Sampai jumpa lagi, $uname! 👋"),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 3),
            ),
          );
                    
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (Route<dynamic> route) => false,
          );
        } else {
          String message = response["message"];
          _showErrorDialog(context, message);
        }
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        _showErrorDialog(context, 'Logout gagal: Periksa koneksi internet Anda');
      }
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('Logout Gagal'),
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}