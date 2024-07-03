import 'package:flutter/material.dart';

class PageFav extends StatefulWidget {
  const PageFav({super.key});

  @override
  State<PageFav> createState() => _PageFavState();
}

class _PageFavState extends State<PageFav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page favorite',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}