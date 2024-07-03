import 'package:app_booking_rs/models/ModelHomestay.dart';
import 'package:flutter/material.dart';

class PageDetailRS extends StatelessWidget {
  final Result homestay;

  const PageDetailRS({super.key, required this.homestay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Information',
          // homestay.name,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Image.network(
            'http://127.0.0.1:8000/images/${homestay.picture}',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homestay.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  homestay.address,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                // SizedBox(height: 16),
                // Text(
                //   'Fasilitas',
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // SizedBox(height: 8),
                // Text(
                //   '• Wi-Fi\n• AC\n• TV\n• Sarapan Gratis\n• Parkir Gratis',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey[700],
                //   ),
                // ),
                SizedBox(height: 16),
                Text(
                  'Ulasan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(height: 8),
                // Text(
                //   '“Tempat yang sangat nyaman dengan pelayanan yang luar biasa. Sangat direkomendasikan!”',
                //   style: TextStyle(
                //     fontSize: 16,
                //     color: Colors.grey[700],
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
