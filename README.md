---


---

<h2 id="tugas-individu-7">Tugas Individu 7</h2>
<p><em><strong>by Christna Yosua Rotinsulu - 2406495691</strong></em></p>
<h3 id="soal1">Widget Tree dan Hubungan Parent-Child 🌲[1]</h3>
<hr>
<p><strong>Widget Tree</strong> adalah hierarki struktur widget dalam Flutter di mana setiap widget dapat memliki induk (<em>parent</em>) dan/atau widget anak (<em>child</em>). Berdasarkan definisi tersebut, setiap aplikasi Flutter dimulai dengan sebuah widget root yang kemudian bercabang menjadi widget-widget anak sehingga, apabila diilustrasikan, hubungan tersebut akan membentuk sebuah pohon yang kompleks (<em>tergantung seberapa banyak percabangan yang dilakukan</em>).</p>
<p><strong>Lalu, bagaimana dengan praktiknya dalam Flutter?</strong> Dalam praktiknya sendiri di Flutter, hal ini dapat saya jelaskan melalui contoh kode berikut:</p>
<pre class=" language-dart"><code class="prism  language-dart"><span class="token function">MaterialApp</span><span class="token punctuation">(</span> <span class="token comment">// 🎯 ROOT PARENT  home: Scaffold( // 🏠 Child dari MaterialApp, Parent untuk AppBar &amp; Body</span>
    appBar<span class="token punctuation">:</span> <span class="token function">AppBar</span><span class="token punctuation">(</span> <span class="token comment">// 📱 Child dari Scaffold</span>
      title<span class="token punctuation">:</span> <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Aplikasi Saya'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 👶 Child dari AppBar</span>
    <span class="token punctuation">)</span><span class="token punctuation">,</span>
    body<span class="token punctuation">:</span> <span class="token function">Container</span><span class="token punctuation">(</span> <span class="token comment">// 📦 Child dari Scaffold, Parent untuk Column</span>
      child<span class="token punctuation">:</span> <span class="token function">Column</span><span class="token punctuation">(</span> <span class="token comment">// 📑 Child dari Container, Parent untuk berbagai widget</span>
        children<span class="token punctuation">:</span> <span class="token punctuation">[</span>
          <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Data 1'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 👶 Child dari Column</span>
          <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Data 2'</span><span class="token punctuation">)</span><span class="token punctuation">,</span> <span class="token comment">// 👶 Child dari Column</span>
        <span class="token punctuation">]</span><span class="token punctuation">,</span>
      <span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">)</span><span class="token punctuation">,</span>
  <span class="token punctuation">)</span><span class="token punctuation">,</span>
<span class="token punctuation">)</span>
</code></pre>
<p>Berdasarkan kode di atas, mekanisme hubungan yang dapat saya jelaskan adalah sebagai berikut:</p>
<ul>
<li><strong>Constraints Flow</strong>: <em>Parent</em> memberikan batasan ukuran ke child atau anaknya.</li>
<li><strong>Layout Process</strong>: <em>Child</em> akan menentukan ukurannya sendiri dalam batasan yang diberikan oleh <em>parent</em>.</li>
<li><strong>Painting</strong>: Widget yang terdapat di aplikasi akan di-<em>render</em> berdasarkan posisi dalam tree.</li>
</ul>
<h3>Arsenal Widget dalam Proyek Stunting Prevention [2] ⚙️</h3>
<hr>
<p>Dalam proyek kali ini, beberapa widget yang saya gunakan untuk aplikasi <em>mobile</em> saya beserta fungsinya adalah sebagai berikut:</p>
<ol>
<li><code>Scaffold</code>: widget yang berfungsi sebagai kerangka dasar untuk <em>material design</em>, seperti appBar, body, dll.</li>
<li><code>AppBar</code>: widget yang berfungsi untuk memberikan ruang pada bagian atas aplikasi dengan judul dan aksi.</li>
<li><code>Text</code>: widget yang berfungsi untuk menampilkan teks dengan berbagai gaya.</li>
<li><code>Padding</code>: widget yang berfungsi memberikan jarak di sekitar widget <em>children</em>.</li>
<li><code>Column</code>: widget yang berfungsi menyusun widget lainnya secara vertikal.</li>
<li><code>Row</code>: widget yang berfungsi menyusun widget lainny secara horizontal.</li>
<li><code>GridView</code>: widget yang berfungsi menampilkan widget lainnya dalam format grid.</li>
<li><code>Card</code>: widget yang berfungsi sebagai <em>container</em> dengan <em>shadow</em> dan <em>rounded corners</em>.</li>
<li><code>Material</code>: widget <em>material design</em> dengan <em>ink effect</em>.</li>
<li><code>InkWell</code>: widget yang berfungsi sebagai area yang responsif terhadap sentuhan.</li>
<li><code>Container</code>: widget yang serba guna untuk <em>layout</em> dan <em>styling</em>.</li>
<li><code>Icon</code>: widget yang berfungsi menampilkan ikon <em>material</em>.</li>
<li><code>Center</code>: widget yang berfungsi memusatkan widget <em>children</em>.</li>
<li><code>SizedBox</code>: widget dengan ukuran tetap atau <em>spacer</em>.</li>
</ol>
<h3>MaterialApp: Jantung Aplikasi Flutter 🎯[3]</h3>
<hr> 
<p><strong>MaterialApp</strong> sendiri adalah sebuah widget yang mengemas seluruh aplikasi dengan desain <em>Material Design</em>. Fungsi <strong>MaterialApp</strong> sendiri dalam aplikasi adalah sebagai berikut:</p>
<ul>
<li>Mengatur <strong>rute navigasi</strong>, seperti halaman aplikasi.</li>
<li>Menyediakan <strong>theme</strong> global, seperti warna dan tipografi.</li>
<li>Mengintegrasikan <strong>localization</strong>, seperti dukungan bahasa (<em>dalam tutorial belum digunakan</em>).</li>
<li>Menyediakan akses <strong>InheritedWidget</strong>, seperti <em>MediaQuery</em>.</li>
</ul>
<p><strong>Mengapa sering menjadi root widget?</strong> Alasannya sebab MaterialApp menyediakan <strong>infrastruktur dasar</strong> yang diperlukan oleh sebuah aplikasi Flutter, seperti Navigator untuk melakukan perpindahan halaman. Berkat hal tersebut, MaterialApp membentuk fondasi yang efisien bagi aplikasi. Sebagai contoh implementasinya, dapa dilihat dari potongan code berikut:</p>
<pre class=" language-dart"><code class="prism  language-dart"><span class="token function">MaterialApp</span><span class="token punctuation">(</span>
  title<span class="token punctuation">:</span> <span class="token string">'Stunting Prevention App'</span><span class="token punctuation">,</span>      <span class="token comment">// Judul aplikasi</span>
  theme<span class="token punctuation">:</span> <span class="token function">ThemeData</span><span class="token punctuation">(</span>                      <span class="token comment">// Tema global</span>
    primarySwatch<span class="token punctuation">:</span> Colors<span class="token punctuation">.</span>blue<span class="token punctuation">,</span>
    fontFamily<span class="token punctuation">:</span> <span class="token string">'Roboto'</span><span class="token punctuation">,</span>
  <span class="token punctuation">)</span><span class="token punctuation">,</span>
  home<span class="token punctuation">:</span> <span class="token function">HomeScreen</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>                    <span class="token comment">// Halaman awal</span>
  routes<span class="token punctuation">:</span> <span class="token punctuation">{</span>                              <span class="token comment">// Daftar rute</span>
    <span class="token string">'/detail'</span><span class="token punctuation">:</span> <span class="token punctuation">(</span>context<span class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">DetailScreen</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
  <span class="token punctuation">}</span><span class="token punctuation">,</span>
  debugShowCheckedModeBanner<span class="token punctuation">:</span> <span class="token boolean">false</span><span class="token punctuation">,</span>     <span class="token comment">// Hide debug banner</span>
<span class="token punctuation">)</span>
</code></pre>
<h3>Stateless vs Stateful: Dua Sisi Widget Flutter ⚡[4]</h3>
<hr>
<p>Berikut adalah perbedaan antara stateless dan stateful di Flutter:</p>
<ol>
<li><strong>State</strong>: dari segi <em>state</em>, <em>StatelessWidget</em> bersifat <em>immutable</em>, sedangkan <em>StatefulWidget</em> bersifat <em>mutable</em> atau dapat diubah-ubah (<em>dalam hal ini menyimpan state dari user di dalam aplikasi</em>).</li>
<li><strong>Rebuild</strong>: dari segi <em>rebuild</em>, <em>StatelessWidget</em> hanya dibuat sekali saja saat dibuat, sedangkan <em>StatefulWidget</em> dapat dibuild ulang saat state berubah.</li>
<li><strong>Performance</strong>: dari segi <em>performance</em>, <em>StatelessWidget</em> lebih ringan sebab tidak perlu menyimpan state dari user, sedangkan <em>StatefulWidget</em> sedikit lebih berat sebab sifat dan fungsinya adalah menyimpan <em>state</em> dari <em>user</em> di dalam aplikasi.</li>
<li><strong>Use Case</strong>: sebab <em>StatelessWidget</em> tidak menyimpan <em>state</em> dari <em>user</em> di dalam aplikasi sehingga tampilannya bersifat statis, berbeda dengan <em>StatefulWidget</em> yang tampilannya bersifat dinamis.</li>
<li><strong>Contoh Widget</strong>: untuk <em>StatelessWidget</em>, contohnya adalah Text, Icon, dan Button. Di sisi lain, contoh widget dari <em>StatefulWidget</em> adalah Checkbox, Form, dan Input Field yang dapat menyimpan <em>state</em> dari <em>user</em>.</li>
</ol>
<p><strong>Lalu, bagaimana implementasinya dalam Flutter?</strong> Implementasi untuk kedua widget tersebut dapat dilihat potongan kode berikut dan salah satu cara mengetahui apakah sebuah widget <em>Stateless</em> atau <em>Stateful</em> adalah dengan melihat <em>parent</em> atau <em>superclass</em> yang di-<em>extends</em>. Dalam praktik kali ini, penerapan yang dilakukan hanya <em>StatelessWidget</em> dengan contoh kode sebagai berikut:</p>
<pre class=" language-dart"><code class="prism  language-dart"><span class="token keyword">class</span> <span class="token class-name">InfoCard</span> <span class="token keyword">extends</span> <span class="token class-name">StatelessWidget</span> <span class="token punctuation">{</span>
  <span class="token keyword">final</span> String title<span class="token punctuation">;</span>
  <span class="token keyword">final</span> String content<span class="token punctuation">;</span>

  <span class="token keyword">const</span> <span class="token function">InfoCard</span><span class="token punctuation">(</span><span class="token punctuation">{</span><span class="token keyword">super</span><span class="token punctuation">.</span>key<span class="token punctuation">,</span> required <span class="token keyword">this</span><span class="token punctuation">.</span>title<span class="token punctuation">,</span> required <span class="token keyword">this</span><span class="token punctuation">.</span>content<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

  <span class="token metadata symbol">@override</span>
  Widget <span class="token function">build</span><span class="token punctuation">(</span>BuildContext context<span class="token punctuation">)</span> <span class="token punctuation">{</span>
    <span class="token keyword">return</span> <span class="token function">Card</span><span class="token punctuation">(</span>
      child<span class="token punctuation">:</span> <span class="token function">Container</span><span class="token punctuation">(</span>
        padding<span class="token punctuation">:</span> <span class="token keyword">const</span> EdgeInsets<span class="token punctuation">.</span><span class="token function">all</span><span class="token punctuation">(</span><span class="token number">16.0</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        child<span class="token punctuation">:</span> <span class="token function">Column</span><span class="token punctuation">(</span>
          children<span class="token punctuation">:</span> <span class="token punctuation">[</span>
            <span class="token function">Text</span><span class="token punctuation">(</span>title<span class="token punctuation">)</span><span class="token punctuation">,</span>
            <span class="token function">Text</span><span class="token punctuation">(</span>content<span class="token punctuation">)</span><span class="token punctuation">,</span>
          <span class="token punctuation">]</span><span class="token punctuation">,</span>
        <span class="token punctuation">)</span><span class="token punctuation">,</span>
      <span class="token punctuation">)</span><span class="token punctuation">,</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<p>Di sisi lain, untuk <em>StatefulWidget</em> dapat dilihat melalui contoh potongan berikut dari dokumentasi Flutter:</p>
<pre class=" language-dart"><code class="prism  language-dart"><span class="token keyword">class</span> <span class="token class-name">CounterWidget</span> <span class="token keyword">extends</span> <span class="token class-name">StatefulWidget</span> <span class="token punctuation">{</span>
  <span class="token keyword">const</span> <span class="token function">CounterWidget</span><span class="token punctuation">(</span><span class="token punctuation">{</span><span class="token keyword">super</span><span class="token punctuation">.</span>key<span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>

  <span class="token metadata symbol">@override</span>
  State<span class="token operator">&lt;</span>CounterWidget<span class="token operator">&gt;</span> <span class="token function">createState</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token operator">=</span><span class="token operator">&gt;</span> <span class="token function">_CounterWidgetState</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>

<span class="token keyword">class</span> <span class="token class-name">_CounterWidgetState</span> <span class="token keyword">extends</span> <span class="token class-name">State</span><span class="token operator">&lt;</span>CounterWidget<span class="token operator">&gt;</span> <span class="token punctuation">{</span>
  int _counter <span class="token operator">=</span> <span class="token number">0</span><span class="token punctuation">;</span>

  <span class="token keyword">void</span> <span class="token function">_incrementCounter</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
    <span class="token function">setState</span><span class="token punctuation">(</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">{</span>
      _counter<span class="token operator">++</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>

  <span class="token metadata symbol">@override</span>
  Widget <span class="token function">build</span><span class="token punctuation">(</span>BuildContext context<span class="token punctuation">)</span> <span class="token punctuation">{</span>
    <span class="token keyword">return</span> <span class="token function">Column</span><span class="token punctuation">(</span>
      children<span class="token punctuation">:</span> <span class="token punctuation">[</span>
        <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Counter: $_counter'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token function">ElevatedButton</span><span class="token punctuation">(</span>
          onPressed<span class="token punctuation">:</span> _incrementCounter<span class="token punctuation">,</span>
          child<span class="token punctuation">:</span> <span class="token keyword">const</span> <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Increment'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
        <span class="token punctuation">)</span><span class="token punctuation">,</span>
      <span class="token punctuation">]</span><span class="token punctuation">,</span>
    <span class="token punctuation">)</span><span class="token punctuation">;</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<p>Berdasarkan hal tersebut, saya dapat menyimpulkan bahwa <em>StatelessWidget</em> dapat digunakan ketika tujuannya hanya menampilkan data dan tidak ada perubahan di bagian internal. Di sisi lain, <em>StatefulWidget</em> digunakan ketika ada interaksi yang terjadi dengan <em>user</em> dan data yang dapat berubah seiring berjalannya waktu.</p>
<h3>BuildContext: GPS Widget yang Ada di Flutter 🧭</h3>
<hr>
<p><strong>BuildContext</strong> adalah objek yang berisi informasi tentang posisi widget dalam widget tree. Berdasarkan hal tersebut, saya dapat menganalogikan bahwa <em>BuildContext</em> seperti alamat rumah dalam sebuah kota/kabupaten. <em>BuildContext</em> sendiri mempunyai peran penting, yakni sebagai berikut:</p>
<ol>
<li><strong>Akses Layanan</strong>: mengambil data dari <em>parent</em> widget, seperti <code>Theme.of(context).</code></li>
<li><strong>Navigasi</strong>: berpindah halaman dengan menggunakan <code>Navigator.of(context).</code></li>
<li><strong>Ukuran dan Posisi</strong>: mendapatkan <em>constraints</em> layout dari <em>parent</em>, seperti <strong>Screen Info</strong> melalui <code>MediaQuery.of(context)</code>.</li>
</ol>
<p>Contoh penerapan lebih lanjut dapat dilihat dari implementasi kode berikut:</p>
<pre class=" language-dart"><code class="prism  language-dart">Widget <span class="token function">build</span><span class="token punctuation">(</span>BuildContext context<span class="token punctuation">)</span> <span class="token punctuation">{</span>
  <span class="token comment">// 🎯 Akses Theme data</span>
  <span class="token keyword">final</span> theme <span class="token operator">=</span> Theme<span class="token punctuation">.</span><span class="token function">of</span><span class="token punctuation">(</span>context<span class="token punctuation">)</span><span class="token punctuation">;</span>
  
  <span class="token comment">// 🎯 Akses MediaQuery untuk ukuran layar</span>
  <span class="token keyword">final</span> size <span class="token operator">=</span> MediaQuery<span class="token punctuation">.</span><span class="token function">of</span><span class="token punctuation">(</span>context<span class="token punctuation">)</span><span class="token punctuation">.</span>size<span class="token punctuation">;</span>
  
  <span class="token comment">// 🎯 Navigasi ke halaman lain</span>
  Navigator<span class="token punctuation">.</span><span class="token function">of</span><span class="token punctuation">(</span>context<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">pushNamed</span><span class="token punctuation">(</span><span class="token string">'/detail'</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
  
  <span class="token comment">// 🎯 Akses Scaffold untuk SnackBar</span>
  ScaffoldMessenger<span class="token punctuation">.</span><span class="token function">of</span><span class="token punctuation">(</span>context<span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">showSnackBar</span><span class="token punctuation">(</span>
    <span class="token function">SnackBar</span><span class="token punctuation">(</span>content<span class="token punctuation">:</span> <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Hello!'</span><span class="token punctuation">)</span><span class="token punctuation">)</span>
  <span class="token punctuation">)</span><span class="token punctuation">;</span>

  <span class="token keyword">return</span> <span class="token function">Container</span><span class="token punctuation">(</span>
    color<span class="token punctuation">:</span> theme<span class="token punctuation">.</span>primaryColor<span class="token punctuation">,</span>
    width<span class="token punctuation">:</span> size<span class="token punctuation">.</span>width <span class="token operator">*</span> <span class="token number">0.8</span><span class="token punctuation">,</span>
    child<span class="token punctuation">:</span> <span class="token function">Text</span><span class="token punctuation">(</span><span class="token string">'Widget Content'</span><span class="token punctuation">)</span><span class="token punctuation">,</span>
  <span class="token punctuation">)</span><span class="token punctuation">;</span>
<span class="token punctuation">}</span>
</code></pre>
<h2 id="sourcedokumentasi-🌐">Source/Dokumentasi 🌐</h2>
<p>[1]</p>

