import 'package:app_booking_rs/PageNavigation.dart';
import 'package:flutter/material.dart';

class PageKonfirmasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Konfirmasi Pemesanan'),
      // ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 100,
            ),
            SizedBox(height: 20),
            Text(
              'Pemesanan Berhasil',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavigationPage(initialIndex: 0),
                  ),
                );
              },
              child: Text(
                'Kembali ke Halaman Utama',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 5, // Bayangan tombol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
