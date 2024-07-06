import 'package:app_booking_rs/models/ModelBank.dart';
import 'package:flutter/material.dart';

class PageDonasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Info Bank',
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
      body: ListView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: banks.length,
        itemBuilder: (context, index) {
          final bank = banks[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
            child: ListTile(
              leading: Image.asset(
                bank.logo,
                width: 50.0,
                height: 50.0,
              ),
              title: Text(
                bank.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Rekening: ${bank.accountNumber}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Atas Nama    : ${bank.accountHolder}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              contentPadding: EdgeInsets.all(12.0),
              onTap: () {
                _showBankDetailsDialog(context, bank);
              },
            ),
          );
        },
      ),
    );
  }

  void _showBankDetailsDialog(BuildContext context, Bank bank) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: Text(bank.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  bank.logo,
                  width: 100.0,
                  height: 100.0,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'No. Rekening: ${bank.accountNumber}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Atas Nama    : ${bank.accountHolder}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
