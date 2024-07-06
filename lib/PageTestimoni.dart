import 'package:flutter/material.dart';

class PageTestimoni extends StatelessWidget {
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
          'Testimoni Pengguna',
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
            // Penjelasan Singkat
            Text(
              'Berikut adalah beberapa testimoni dari pengguna yang telah menggunakan aplikasi kami untuk mencari rumah singgah selama perawatan di rumah sakit. Kami senang mendengar bahwa aplikasi ini dapat membantu mereka dalam perjalanan mereka.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 16),
            // Daftar Testimoni
            _buildTestimoni(
              userName: 'Rina S.',
              message: 'Aplikasi ini sangat membantu saya dan keluarga dalam mencari rumah singgah selama perawatan di rumah sakit. Mudah digunakan dan sangat memudahkan proses booking!',
              rating: 5,
            ),
            SizedBox(height: 16),
            _buildTestimoni(
              userName: 'Budi H.',
              message: 'Saya sangat puas dengan pelayanan aplikasi ini. Proses booking sangat cepat dan mudah. Terima kasih atas layanan yang luar biasa!',
              rating: 4,
            ),
            SizedBox(height: 16),
            _buildTestimoni(
              userName: 'Dewi A.',
              message: 'Aplikasi ini membantu saya menemukan rumah singgah dengan mudah dan cepat. Fitur-fitur yang ada sangat berguna dan memudahkan kami dalam perjalanan.',
              rating: 5,
            ),
            SizedBox(height: 16),
            _buildTestimoni(
              userName: 'Joko M.',
              message: 'Pengalaman menggunakan aplikasi ini sangat memuaskan. Antarmukanya user-friendly dan saya bisa dengan mudah menemukan rumah singgah yang kami butuhkan.',
              rating: 4,
            ),
            SizedBox(height: 16),
            _buildTestimoni(
              userName: 'Sari L.',
              message: 'Sangat membantu dalam mencari tempat tinggal sementara untuk keluarga saya selama saya menjalani perawatan. Aplikasi ini sangat direkomendasikan!',
              rating: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestimoni({
    required String userName,
    required String message,
    required int rating,
  }) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userName,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
