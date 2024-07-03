import 'package:flutter/material.dart';

class PageTerms extends StatelessWidget {
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
          'Syarat dan Ketentuan',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Syarat dan Ketentuan Penggunaan Aplikasi Rumah Singgah',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3a5baa),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Selamat datang di aplikasi Rumah Singgah! Dengan menggunakan aplikasi ini, Anda setuju untuk mematuhi syarat dan ketentuan berikut. Harap baca syarat dan ketentuan ini dengan seksama sebelum melanjutkan.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 24),
            _buildSection(
              context,
              'Penerimaan Syarat dan Ketentuan',
              'Dengan mengakses atau menggunakan aplikasi Rumah Singgah, Anda setuju untuk terikat oleh syarat dan ketentuan ini serta kebijakan privasi kami. Jika Anda tidak setuju dengan syarat dan ketentuan ini, mohon untuk tidak menggunakan aplikasi kami.',
            ),
            _buildSection(
              context,
              'Penggunaan Aplikasi',
              'Anda setuju untuk menggunakan aplikasi Rumah Singgah hanya untuk tujuan yang sah dan sesuai dengan syarat dan ketentuan ini. Anda bertanggung jawab penuh atas segala aktivitas yang terjadi di akun Anda.',
            ),
            _buildSection(
              context,
              'Pendaftaran dan Akun Pengguna',
              'Untuk menggunakan fitur-fitur tertentu, Anda mungkin perlu membuat akun pengguna. Anda bertanggung jawab untuk menjaga kerahasiaan informasi akun Anda dan untuk semua aktivitas yang terjadi di akun Anda.',
            ),
            _buildSection(
              context,
              'Booking dan Pembayaran',
              'Anda dapat melakukan booking melalui aplikasi kami dengan memilih tanggal dan fasilitas yang diinginkan. Pembayaran harus dilakukan sesuai dengan ketentuan yang berlaku di aplikasi.',
            ),
            _buildSection(
              context,
              'Pembatalan dan Pengembalian Dana',
              'Jika Anda perlu membatalkan booking, Anda dapat melakukannya melalui aplikasi. Kebijakan pembatalan dan pengembalian dana akan mengikuti ketentuan yang berlaku di aplikasi.',
            ),
            _buildSection(
              context,
              'Perubahan pada Syarat dan Ketentuan',
              'Kami dapat memperbarui syarat dan ketentuan ini dari waktu ke waktu. Setiap perubahan akan diberitahukan melalui aplikasi atau melalui email. Penggunaan aplikasi setelah perubahan dianggap sebagai penerimaan terhadap syarat dan ketentuan yang diperbarui.',
            ),
            _buildSection(
              context,
              'Kontak Kami',
              'Jika Anda memiliki pertanyaan atau komentar tentang syarat dan ketentuan ini, silakan hubungi kami melalui menu "Contact Us" di aplikasi.',
            ),
            SizedBox(height: 24),
            Text(
              'Terima kasih telah menggunakan aplikasi Rumah Singgah.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.red[600],
              ),
            ),
            Text(
              'Kami berharap aplikasi ini dapat membantu Anda dalam proses perawatan medis.',
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.red[600],
                // height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3a5baa),
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
