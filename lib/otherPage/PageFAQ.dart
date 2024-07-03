import 'package:flutter/material.dart';

class PageFAQ extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'Apa itu Rumah Singgah?',
      'answer': 'Rumah Singgah adalah tempat sementara bagi pasien dan keluarga selama menjalani perawatan medis jauh dari rumah.'
    },
    {
      'question': 'Bagaimana cara melakukan booking?',
      'answer': 'Anda dapat melakukan booking melalui aplikasi ini dengan memilih tanggal, fasilitas yang diinginkan, dan mengisi data diri.'
    },
    {
      'question': 'Apa saja fasilitas yang tersedia?',
      'answer': 'Kami menyediakan kamar tidur, dapur, ruang santai, dan akses ke fasilitas medis terdekat.'
    },
    {
      'question': 'Berapa harga sewa per malam?',
      'answer': 'Harga sewa per malam bervariasi tergantung pada jenis kamar dan fasilitas yang Anda pilih.'
    },
    {
      'question': 'Bagaimana cara membatalkan booking?',
      'answer': 'Anda dapat membatalkan booking melalui aplikasi dengan mengakses menu "Booking Saya" dan memilih opsi pembatalan.'
    },
    {
      'question': 'Apakah ada syarat khusus untuk booking?',
      'answer': 'Anda harus menunjukkan bukti perawatan medis dan melakukan pembayaran sesuai dengan ketentuan yang berlaku.'
    },
  ];

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
          'FAQ - Rumah Singgah',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index]['question']!),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqs[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}
