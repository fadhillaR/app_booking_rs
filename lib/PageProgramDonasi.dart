import 'package:flutter/material.dart';

class PageProgramDonasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Program Donasi Rumah Singgah',
        //   style: TextStyle(
        //     color: Colors.black,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Selamat Datang di Program Donasi Rumah Singgah Rumah Sakit',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Kami menyediakan tempat tinggal yang nyaman dan aman bagi pasien dan keluarga yang datang ke rumah sakit. Dukungan Anda membantu kami dalam memberikan akomodasi sementara, makanan, dan dukungan emosional selama masa pengobatan mereka.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              _buildSection(
                title: 'Kenapa Donasi?',
                content:
                    'Donasi Anda akan membantu kami dalam menyediakan tempat tinggal sementara yang nyaman dan aman bagi pasien dan keluarga mereka. Kami berkomitmen untuk memberikan dukungan penuh selama mereka menjalani pengobatan di rumah sakit.',
              ),
              SizedBox(height: 16),
              _buildSection(
                title: 'Manfaat Donasi Anda',
                content:
                    '• Tempat Tinggal yang Aman\n\tMenyediakan akomodasi sementara bagi pasien dan keluarga.\n'
                    '• Makanan Sehat dan Bergizi\n\tMenyediakan makanan yang sehat dan bergizi untuk mendukung proses penyembuhan.\n'
                    '• Dukungan Emosional\n\tMemberikan dukungan emosional dan informasi yang dibutuhkan selama masa pengobatan.\n'
                    '• Akses ke Fasilitas Rumah Sakit\n\tMembantu pasien dan keluarga untuk lebih mudah mengakses fasilitas rumah sakit.',
              ),
              // SizedBox(height: 24),
              // ElevatedButton(
              //   onPressed: () {
              //     _showDonationDialog(context);
              //   },
              //   child: Text('Donasi Sekarang'),
              //   style: ElevatedButton.styleFrom(
              //     padding: EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.blueAccent,
              //     textStyle: TextStyle(
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required String content}) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 8),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  void _showDonationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Terima Kasih atas Kepedulian Anda!'),
          content: Text(
              'Anda bisa memilih berbagai cara untuk berdonasi. Pilih opsi di bawah ini untuk memulai.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Donasi Sekali'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Berlangganan Bulanan'),
            ),
          ],
        );
      },
    );
  }
}
