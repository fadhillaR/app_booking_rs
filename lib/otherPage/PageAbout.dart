import 'package:flutter/material.dart';

class PageAbout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Container(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF424252),
            ),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0xFFE6E6E6),
        title: Text(
          'About Us',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo1.png',
                  height: 150.0,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Selamat Datang di Aplikasi Rumah Singgah!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Rumah Singgah adalah aplikasi yang dirancang untuk membantu pasien dan keluarga mencari tempat tinggal sementara selama perawatan medis. Kami berkomitmen untuk menyediakan fasilitas yang nyaman dan aman bagi penggunanya.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Fasilitas Kami:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '• Kamar tidur yang nyaman\n• Dapur lengkap\n• Ruang santai\n• Akses Wi-Fi\n• Dekat dengan fasilitas medis',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kami berharap aplikasi ini dapat membantu Anda dan keluarga selama masa perawatan. Jika ada pertanyaan atau saran, jangan ragu untuk menghubungi kami melalui menu kontak.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
