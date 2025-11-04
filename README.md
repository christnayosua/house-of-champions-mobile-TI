## Tugas Individu 7
***by Christna Yosua Rotinsulu - 2406495691***

<h3 id="soal1">Widget Tree dan Hubungan Parent-Child 🌲[1]</h3>
<hr>

**Widget Tree** adalah hierarki struktur widget dalam Flutter di mana setiap widget dapat memliki induk (*parent*) dan/atau widget anak (*child*). Berdasarkan definisi tersebut, setiap aplikasi Flutter dimulai dengan sebuah widget root yang kemudian bercabang menjadi widget-widget anak sehingga, apabila diilustrasikan, hubungan tersebut akan membentuk sebuah pohon yang kompleks (*tergantung seberapa banyak percabangan yang dilakukan*).

**Lalu, bagaimana dengan praktiknya dalam Flutter?** Dalam praktiknya sendiri di Flutter, hal ini dapat saya jelaskan melalui contoh kode berikut:

```dart
MaterialApp( // 🎯 ROOT PARENT  home: Scaffold( // 🏠 Child dari MaterialApp, Parent untuk AppBar & Body
    appBar: AppBar( // 📱 Child dari Scaffold
      title: Text('Aplikasi Saya'), // 👶 Child dari AppBar
    ),
    body: Container( // 📦 Child dari Scaffold, Parent untuk Column
      child: Column( // 📑 Child dari Container, Parent untuk berbagai widget
        children: [
          Text('Data 1'), // 👶 Child dari Column
          Text('Data 2'), // 👶 Child dari Column
        ],
      ),
    ),
  ),
)
```

Berdasarkan kode di atas, mekanisme hubungan yang dapat saya jelaskan adalah sebagai berikut:

- **Constraints Flow**: *Parent* memberikan batasan ukuran ke child atau anaknya.
- **Layout Process**: *Child* akan menentukan ukurannya sendiri dalam batasan yang diberikan oleh *parent*. 
- **Painting**: Widget yang terdapat di aplikasi akan di-*render* berdasarkan posisi dalam tree.

<h3>Arsenal Widget dalam Proyek Stunting Prevention [2] ⚙️</h3>
<hr>

Dalam proyek kali ini, beberapa widget yang saya gunakan untuk aplikasi *mobile* saya beserta fungsinya adalah sebagai berikut:

1. `Scaffold`: widget yang berfungsi sebagai kerangka dasar untuk *material design*, seperti appBar, body, dll.
2. `AppBar`: widget yang berfungsi untuk memberikan ruang pada bagian atas aplikasi dengan judul dan aksi. 
3. `Text`: widget yang berfungsi untuk menampilkan teks dengan berbagai gaya. 
4. `Padding`: widget yang berfungsi memberikan jarak di sekitar widget *children*.
5. `Column`: widget yang berfungsi menyusun widget lainnya secara vertikal. 
6. `Row`: widget yang berfungsi menyusun widget lainny secara horizontal.
7. `GridView`: widget yang berfungsi menampilkan widget lainnya dalam format grid. 
8. `Card`: widget yang berfungsi sebagai *container* dengan *shadow* dan *rounded corners*.
9. `Material`: widget *material design* dengan *ink effect*.
10. `InkWell`: widget yang berfungsi sebagai area yang responsif terhadap sentuhan. 
11. `Container`: widget yang serba guna untuk *layout* dan *styling*. 
12. `Icon`: widget yang berfungsi menampilkan ikon *material*.
13. `Center`: widget yang berfungsi memusatkan widget *children*.
14. `SizedBox`: widget dengan ukuran tetap atau *spacer*.

<h3>MaterialApp: Jantung Aplikasi Flutter 🎯[3]</h3>
<hr> 

**MaterialApp** sendiri adalah sebuah widget yang mengemas seluruh aplikasi dengan desain *Material Design*. Fungsi **MaterialApp** sendiri dalam aplikasi adalah sebagai berikut: 
- Mengatur **rute navigasi**, seperti halaman aplikasi.
- Menyediakan **theme** global, seperti warna dan tipografi. 
- Mengintegrasikan **localization**, seperti dukungan bahasa (*dalam tutorial belum digunakan*). 
- Menyediakan akses **InheritedWidget**, seperti *MediaQuery*. 

**Mengapa sering menjadi root widget?** Alasannya sebab MaterialApp menyediakan **infrastruktur dasar** yang diperlukan oleh sebuah aplikasi Flutter, seperti Navigator untuk melakukan perpindahan halaman. Berkat hal tersebut, MaterialApp membentuk fondasi yang efisien bagi aplikasi. Sebagai contoh implementasinya, dapa dilihat dari potongan code berikut:

```dart
MaterialApp(
  title: 'Stunting Prevention App',      // Judul aplikasi
  theme: ThemeData(                      // Tema global
    primarySwatch: Colors.blue,
    fontFamily: 'Roboto',
  ),
  home: HomeScreen(),                    // Halaman awal
  routes: {                              // Daftar rute
    '/detail': (context) => DetailScreen(),
  },
  debugShowCheckedModeBanner: false,     // Hide debug banner
)
```

<h3>Stateless vs Stateful: Dua Sisi Widget Flutter ⚡[4]</h3>
<hr>

Berikut adalah perbedaan antara stateless dan stateful di Flutter:
1. **State**: dari segi *state*, *StatelessWidget* bersifat *immutable*, sedangkan *StatefulWidget* bersifat *mutable* atau dapat diubah-ubah (*dalam hal ini menyimpan state dari user di dalam aplikasi*). 
2. **Rebuild**: dari segi *rebuild*, *StatelessWidget* hanya dibuat sekali saja saat dibuat, sedangkan *StatefulWidget* dapat dibuild ulang saat state berubah. 
3. **Performance**: dari segi *performance*, *StatelessWidget* lebih ringan sebab tidak perlu menyimpan state dari user, sedangkan *StatefulWidget* sedikit lebih berat sebab sifat dan fungsinya adalah menyimpan *state* dari *user* di dalam aplikasi. 
4. **Use Case**: sebab *StatelessWidget* tidak menyimpan *state* dari *user* di dalam aplikasi sehingga tampilannya bersifat statis, berbeda dengan *StatefulWidget* yang tampilannya bersifat dinamis. 
5. **Contoh Widget**: untuk *StatelessWidget*, contohnya adalah Text, Icon, dan Button. Di sisi lain, contoh widget dari *StatefulWidget* adalah Checkbox, Form, dan Input Field yang dapat menyimpan *state* dari *user*.

**Lalu, bagaimana implementasinya dalam Flutter?** Implementasi untuk kedua widget tersebut dapat dilihat potongan kode berikut dan salah satu cara mengetahui apakah sebuah widget *Stateless* atau *Stateful* adalah dengan melihat *parent* atau *superclass* yang di-*extends*. Dalam praktik kali ini, penerapan yang dilakukan hanya *StatelessWidget* dengan contoh kode sebagai berikut:

```dart
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title),
            Text(content),
          ],
        ),
      ),
    );
  }
}
```

Di sisi lain, untuk *StatefulWidget* dapat dilihat melalui contoh potongan berikut dari dokumentasi Flutter: 

```dart
class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Counter: $_counter'),
        ElevatedButton(
          onPressed: _incrementCounter,
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

Berdasarkan hal tersebut, saya dapat menyimpulkan bahwa *StatelessWidget* dapat digunakan ketika tujuannya hanya menampilkan data dan tidak ada perubahan di bagian internal. Di sisi lain, *StatefulWidget* digunakan ketika ada interaksi yang terjadi dengan *user* dan data yang dapat berubah seiring berjalannya waktu. 

<h3>BuildContext: GPS Widget yang Ada di Flutter 🧭[5]</h3>
<hr>

**BuildContext** adalah objek yang berisi informasi tentang posisi widget dalam widget tree. Berdasarkan hal tersebut, saya dapat menganalogikan bahwa *BuildContext* seperti alamat rumah dalam sebuah kota/kabupaten. *BuildContext* sendiri mempunyai peran penting, yakni sebagai berikut:

1. **Akses Layanan**: mengambil data dari *parent* widget, seperti `Theme.of(context).`
2. **Navigasi**: berpindah halaman dengan menggunakan `Navigator.of(context).`
3. **Ukuran dan Posisi**: mendapatkan *constraints* layout dari *parent*, seperti **Screen Info** melalui `MediaQuery.of(context)`. 

Contoh penerapan lebih lanjut dapat dilihat dari implementasi kode berikut: 

```dart
Widget build(BuildContext context) {
  // 🎯 Akses Theme data
  final theme = Theme.of(context);
  
  // 🎯 Akses MediaQuery untuk ukuran layar
  final size = MediaQuery.of(context).size;
  
  // 🎯 Navigasi ke halaman lain
  Navigator.of(context).pushNamed('/detail');
  
  // 🎯 Akses Scaffold untuk SnackBar
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Hello!'))
  );

  return Container(
    color: theme.primaryColor,
    width: size.width * 0.8,
    child: Text('Widget Content'),
  );
}
```

<h3>Hot Reload vs Hot Restart: Superpower Developer 🔥[6]</h3>
<hr>

**Hot Reload** adalah proses memuat ulang kode yang mengalami perubahan tanpa kehilangan state di aplikasi. Berdasarkan hal tersebut, **hot reload** mempunyai waktu eksekusi lebih cepat (*sekitar 2 - 3 detik*), state yang dipertahankan, dan lebih ideal untuk UI iteration. Di sisi lain, **hot restart**  adalah prosedur untuk melakukan restart aplikasi dari awal sehingga setiap state dikembalikan ke kondisi initial. Oleh sebab itu, **hot restart** seharusnya digunakan ketika terjadi perubahan kode inisialisasi, modifikasi `main()` method, atau perubahan struktur fundamental sebuah aplikasi.

Setelah memahami definisi dan kegunaannya, saya dapat menyimpulkan bahwa **Hot Reload** digunakan ketika melakukan *styling*, teks, atau *layout minor*. Di sisi lain, **Hot Restart** digunakan ketika terjadi perubahan *business logic*, *routing*, atau *state initialization*.

Implementasinya dalam Flutter, khusus untuk **Hot Reload**, adalah sebagai berikut:

```dart
// SEBELUM Hot Reload:
Text('Counter: 5', style: TextStyle(color: Colors.black))

// SETELAH Hot Reload (ubah warna):
Text('Counter: 5', style: TextStyle(color: Colors.blue))
```

## Source/Dokumentasi 🌐

[1] geeksforgeeks. (2023, Apr 3). *Flutter - Widget Tree and Element Tree*. Retrieved from https://www.geeksforgeeks.org/flutter/flutter-widget-tree-and-element-tree/
[2] Tim Dosen dan Asisten Dosen PBP 2025. (2025). *Tutorial 6: Pengantar Flutter*. Retrieved from https://pbp-fasilkom-ui.github.io/ganjil-2026/docs/tutorial-6
[3] Flutter. (2025, Oct 10). *MaterialApp Class*. Retrieved from https://api.flutter.dev/flutter/material/MaterialApp-class.html
[4] kutu.dev. (2020, Sept 28). *Apa itu Stateless dan Stateful Application*. Retrieved from https://kutu.dev/artikel/apa-itu-stateless-vs-stateful
[5] Flutter. (2025, Oct 10). *BuildContext Class*. Retrieved from https://api.flutter.dev/flutter/widgets/BuildContext-class.html
[6] geeksforgeeks. (2023, Feb 14). *Difference Between Hot Reload and Hot Restart in Flutter*. Retrieved from https://www.geeksforgeeks.org/flutter/difference-between-hot-reload-and-hot-restart-in-flutter/