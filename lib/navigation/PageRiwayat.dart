import 'package:flutter/material.dart';

class PageRiwayat extends StatefulWidget {
  const PageRiwayat({super.key});

  @override
  State<PageRiwayat> createState() => _PageRiwayatState();
}

class _PageRiwayatState extends State<PageRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page riwayat',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}