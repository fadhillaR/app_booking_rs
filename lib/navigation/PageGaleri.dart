import 'package:flutter/material.dart';

class PageGaleri extends StatefulWidget {
  const PageGaleri({super.key});

  @override
  State<PageGaleri> createState() => _PageGaleriState();
}

class _PageGaleriState extends State<PageGaleri> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page galeri',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}