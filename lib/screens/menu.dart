import 'package:flutter/material.dart';
import 'package:house_of_champions/widgets/left_drawer.dart';
import 'package:house_of_champions/widgets/products_card.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  // Membuat card sederhana yang berisi NPM, Nama, dan Kelas
  final String nama = "Christna Yosua Rotinsulu";
  final String npm = "2406495691";
  final String kelas = "A";

  // Menambahkan class ItemHomePage yang berisi tombol-tombol tertentu
  // Implementasi tombol-tombol yang sudah dibuat tadi
  final List<ItemHomepage> items = [
    ItemHomepage("All Products", Icons.list, Colors.blue),
    ItemHomepage("My Products", Icons.shopping_bag, Colors.green),
    ItemHomepage("Create Product", Icons.add_circle, Colors.red),
  ];

  // Mengintegrasikan infocard dan itemcard untuk ditampilkan di MyHomePage
  @override
  Widget build(BuildContext context) {
    // Scaffold menyediakan struktur dasar halaman dengan AppBar dan body.
    return Scaffold(     
      backgroundColor: Colors.grey[900], 
      // AppBar adalah bagian atas halaman yang menampilkan judul.
      appBar: AppBar(
        // Judul aplikasi "House Of Champions" dengan teks putih dan tebal.
        title: const Text(
          'House Of Champions 🏆',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Warna latar belakang AppBar diambil dari skema warna tema aplikasi.
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: LeftDrawer(),
      // Body halaman dengan padding di sekelilingnya.
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        // Menyusun widget secara vertikal dalam sebuah kolom.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Row untuk menampilkan 3 InfoCard secara horizontal.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(title: 'NPM', content: npm),
                InfoCard(title: 'Name', content: nama),
                InfoCard(title: 'Class', content: kelas),
              ],
            ),

            // Memberikan jarak vertikal 16 unit.
            const SizedBox(height: 16.0),

            // Menempatkan widget berikutnya di tengah halaman.
            Center(
              child: Column(
                // Menyusun teks dan grid item secara vertikal.
                children: [
                  // Menampilkan teks sambutan dengan gaya tebal dan ukuran 18.
                  Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Column(
                      children: [
                        const Text(
                          'WELCOME TO',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            letterSpacing: 2.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "🏆House Of Champions🏆",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            color: Colors.amber,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Your Ultimate Football Store",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.grey,                            
                          ),
                        )
                      ],
                    ),
                  ),

                  // Grid untuk menampilkan ItemCard dalam bentuk grid 3 kolom.
                  GridView.count(
                    primary: true,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 3,
                    // Agar grid menyesuaikan tinggi kontennya.
                    shrinkWrap: true,

                    // Menampilkan ItemCard untuk setiap item dalam list items.
                    children: items.map((ItemHomepage item) {
                      return ItemCard(item);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Penambahan class InfoCard untuk membuat card sederhana yang sudah didefinisikan tadi
class InfoCard extends StatelessWidget {
  // Kartu informasi yang menampilkan title dan content.

  final String title; // Judul kartu.
  final String content; // Isi kartu.

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Membuat kotak kartu dengan bayangan dibawahnya.
      elevation: 2.0,
      child: Container(
        // Mengatur ukuran dan jarak di dalam kartu.
        width:
            MediaQuery.of(context).size.width /
            3.5, // menyesuaikan dengan lebar device yang digunakan.
        padding: const EdgeInsets.all(16.0),
        // Menyusun title dan content secara vertikal.
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

// Membuat button card sederhana dengan icon
class ItemHomepage {
  final String name;
  final IconData icon;

  // Menambahkan attribute warna untuk itemHomePage
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}