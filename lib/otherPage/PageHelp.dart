import 'package:flutter/material.dart';

class PageHelp extends StatelessWidget {
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
          'Bantuan & Dukungan',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang di halaman Bantuan!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Di sini Anda bisa menemukan informasi tentang cara menggunakan aplikasi kami. Jika Anda memerlukan bantuan lebih lanjut, Anda bisa menghubungi tim dukungan kami.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 24),
            Text(
              '📚 Cara Menggunakan Aplikasi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.search, color: Colors.blueAccent),
              title: Text('Cari Rumah Singgah'),
              subtitle: Text('Cari rumah singgah berdasarkan lokasi dan kriteria Anda.'),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blueAccent),
              title: Text('Booking Rumah Singgah'),
              subtitle: Text('Pilih tanggal dan waktu untuk melakukan booking.'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.blueAccent),
              title: Text('Konfirmasi Booking'),
              subtitle: Text('Terima konfirmasi booking melalui email atau notifikasi.'),
            ),
            SizedBox(height: 24),
            Text(
              '📧 Hubungi Dukungan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Jika Anda memerlukan bantuan lebih lanjut, silakan kirimkan pesan melalui email ke dukungan@rumahsinggah.com atau telepon ke 0800-123-4567.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
