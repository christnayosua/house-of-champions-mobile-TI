import 'package:flutter/material.dart';
import 'package:house_of_champions/screens/menu.dart';
import 'package:house_of_champions/screens/newlist_form.dart';
import 'package:house_of_champions/screens/products_entry_list.dart';

// Membuat fitur logout
import 'package:house_of_champions/screens/login.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  /// Menampilkan kartu dengan ikon dan nama menu.
  /// [item] berisi data menu yang akan ditampilkan
  /// [key] untuk identifikasi widget (opsional)

  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    
    return Card(
      // Menentukan elevation dan bentuk kartu
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        // Gradient background untuk efek visual yang lebih menarik
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
            // Efek ripple ketika kartu ditekan
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
                  // Container untuk ikon dengan background circle
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
                  
                  // Nama menu
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
                  
                  // Deskripsi tambahan (opsional) berdasarkan jenis menu
                  _buildSubtitle(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Membangun subtitle berdasarkan jenis menu
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

  /// Menangani aksi ketika kartu ditekan
  Future<void> _handleCardTap(BuildContext context, CookieRequest request) async {
    // Tampilkan snackbar feedback
    _showSnackBar(context, "Kamu telah menekan tombol ${item.name}!");
    
    // Handle navigasi berdasarkan jenis menu
    switch (item.name) {
      case "Create Product":
        _navigateToCreateProduct(context);
        break;
      case "See House Of Champions Products":
        _navigateToProductsList(context);
        break;
      case "Logout":
        await _performLogout(context, request);
        break;
      default:
        // Untuk menu lainnya, hanya tampilkan snackbar
        break;
    }
  }

  /// Menampilkan snackbar dengan styling yang konsisten
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

  /// Navigasi ke halaman buat produk
  void _navigateToCreateProduct(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ProductFormPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  /// Navigasi ke halaman daftar produk
  void _navigateToProductsList(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const ProductsEntryListPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  /// Melakukan proses logout
  Future<void> _performLogout(BuildContext context, CookieRequest request) async {
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
      // TODO: Replace the URL with your app's URL and don't forget to add a trailing slash (/)!
      // To connect Android emulator with Django on localhost, use URL http://10.0.2.2/
      // If you using chrome, use URL http://localhost:8000
      
      final response = await request.logout("http://localhost:8000/auth/logout/");
      
      // Tutup loading indicator
      if (context.mounted) {
        Navigator.of(context).pop();
        
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
            ),
          );
          
          // Navigasi ke halaman login
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const LoginPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, -1.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                
                var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                
                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 400),
            ),
          );
        } else {
          // Tampilkan error message
          String message = response["message"];
          _showErrorDialog(context, message);
        }
      }
    } catch (e) {
      // Handle network errors
      if (context.mounted) {
        Navigator.of(context).pop();
        _showErrorDialog(context, 'Logout gagal: Periksa koneksi internet Anda');
      }
    }
  }

  /// Menampilkan dialog error
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