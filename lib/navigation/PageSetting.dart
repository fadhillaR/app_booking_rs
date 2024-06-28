import 'package:flutter/material.dart';

class PageSetting extends StatefulWidget {
  const PageSetting({super.key});

  @override
  State<PageSetting> createState() => _PageSettingState();
}

class _PageSettingState extends State<PageSetting> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'page setting',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}