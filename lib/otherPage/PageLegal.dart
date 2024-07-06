import 'package:flutter/material.dart';

class PageLegal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Color(0xFF424252),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0xFFE6E6E6),
        title: Text(
          'Legal & Policy',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              '📜 Syarat & Ketentuan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              'Selamat datang di aplikasi Rumah Singgah Rumah Sakit. Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi syarat dan ketentuan berikut:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),
            Text(
              '1. Penggunaan Aplikasi : Anda hanya boleh menggunakan aplikasi ini untuk tujuan yang sah dan sesuai dengan hukum yang berlaku.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2. Akun Pengguna : Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda dan semua aktivitas yang terjadi di bawah akun Anda.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3. Pembayaran : Semua transaksi yang dilakukan melalui aplikasi harus mematuhi ketentuan pembayaran yang ditetapkan oleh kami.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '4. Perubahan Layanan: Kami berhak untuk mengubah atau menghentikan layanan tanpa pemberitahuan sebelumnya.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 24),
            Text(
              '🔒 Kebijakan Privasi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              'Kami menghargai privasi Anda. Kebijakan privasi kami menjelaskan bagaimana kami mengumpulkan, menggunakan, dan melindungi informasi Anda:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 8),
            Text(
              '1. Informasi yang Kami Kumpulkan : Kami mengumpulkan informasi pribadi yang Anda berikan secara langsung seperti nama, email, dan informasi pembayaran.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '2. Penggunaan Informasi : Kami menggunakan informasi Anda untuk memberikan layanan, memproses transaksi, dan meningkatkan aplikasi kami.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '3. Keamanan Data : Kami mengambil langkah-langkah untuk melindungi informasi Anda dari akses yang tidak sah atau penyalahgunaan.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            Text(
              '4. Pembagian Informasi : Kami tidak membagikan informasi pribadi Anda kepada pihak ketiga kecuali diperlukan untuk memenuhi kewajiban hukum atau perjanjian.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),
            Text(
              '⚠️ Disclaimer',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),
            Text(
              'Informasi yang tersedia di aplikasi ini disediakan untuk tujuan informasi umum dan tidak dapat dijadikan sebagai saran profesional atau medis. Kami tidak bertanggung jawab atas kerugian atau kerusakan yang timbul dari penggunaan informasi ini.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 24),
            Text(
              'Jika Anda memiliki pertanyaan atau komentar mengenai syarat dan ketentuan, kebijakan privasi, atau disclaimer ini, silakan hubungi kami di email: dukungan@rumahsinggah.com.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
