import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; 

class PageContact extends StatelessWidget {
  // Function untuk membuka email client
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'contact@rumahsinggah.com',
      query: Uri.encodeComponent('Subject=Inquiry about Rumah Singgah'),
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch $emailUri';
    }
  }

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
          'Contact Us',
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
              'Kami ingin mendengar dari Anda!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Jika Anda memiliki pertanyaan, saran, atau masukan, silakan hubungi kami melalui salah satu cara di bawah ini:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.email, color: Colors.blueAccent),
              title: Text('Email Kami'),
              subtitle: Text('contact@rumahsinggah.com'),
              onTap: _sendEmail,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.phone, color: Colors.blueAccent),
              title: Text('Telepon Kami'),
              subtitle: Text('+62 821 456 789'),
              onTap: () {
                launchUrl(Uri.parse('tel:+62123456789'));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blueAccent),
              title: Text('Alamat Kami'),
              subtitle: Text('Politeknik Negeri Padang, Padang, Indonesia'),
            ),
            Divider(),
            // Text(
            //   'Atau Anda bisa mengisi formulir di bawah ini, dan kami akan segera menghubungi Anda.',
            //   style: TextStyle(
            //     fontSize: 16,
            //     color: Colors.black87,
            //   ),
            // ),
            // SizedBox(height: 20),
            // _ContactForm(),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  @override
  __ContactFormState createState() => __ContactFormState();
}

class __ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nama:',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(
            hintText: 'Masukkan nama Anda',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Email:',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            hintText: 'Masukkan email Anda',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 10),
        Text(
          'Pesan:',
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        TextField(
          controller: _messageController,
          decoration: InputDecoration(
            hintText: 'Masukkan pesan Anda',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Tambahkan logika pengiriman pesan di sini
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Pesan Terkirim'),
                content: Text('Terima kasih telah menghubungi kami. Kami akan segera merespon pesan Anda.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _nameController.clear();
                      _emailController.clear();
                      _messageController.clear();
                    },
                    child: Text('Tutup'),
                  ),
                ],
              ),
            );
          },
          child: Text('Kirim Pesan'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
}
