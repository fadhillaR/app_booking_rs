import 'package:flutter/material.dart';

class PageHistory extends StatefulWidget {
  const PageHistory({super.key});

  @override
  State<PageHistory> createState() => _PageHistoryState();
}

class _PageHistoryState extends State<PageHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page riwayat pesanan',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}