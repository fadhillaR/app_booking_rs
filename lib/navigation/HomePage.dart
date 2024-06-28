import 'package:flutter/material.dart';

class PageMulai extends StatefulWidget {
  const PageMulai({super.key});

  @override
  State<PageMulai> createState() => _PageMulaiState();
}

class _PageMulaiState extends State<PageMulai> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page homepage',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}