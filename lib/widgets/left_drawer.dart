import 'package:flutter/material.dart';
import 'package:house_of_champions/screens/menu.dart';
import 'package:house_of_champions/screens/newlist_form.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(            
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'House Of Champions 🏆',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  "Toko merchandise football kepercayaan warga Indonesia ⚽!",                
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home Page'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart),
            title: const Text('Add Products'),
            // Bagian redirection ke NewsFormPage
            onTap: () {
              /*             
              setelah halaman NewsFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ProductFormPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('See All Products'),                        
          )
        ],
      ),
    );
  }
}