import 'dart:convert';

import 'package:app_booking_rs/PageBooking.dart';
import 'package:app_booking_rs/models/ModelReview.dart';
import 'package:app_booking_rs/models/ModelRoom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PageDetailRoom extends StatefulWidget {
  final Result room;

  const PageDetailRoom({super.key, required this.room});

  @override
  _PageDetailRoomState createState() => _PageDetailRoomState();
}

class _PageDetailRoomState extends State<PageDetailRoom> {

  Future<void> _saveBooking(Result room) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String roomData = jsonEncode(room.toJson());
    await prefs.setString('bookedRoom', roomData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Room',
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
          Container(
            height: 200,
            child: PageView.builder(
              itemCount: widget.room.picture.length,
              itemBuilder: (context, index) {
                final imageUrl =
                    'http://127.0.0.1:8000/images/${widget.room.picture[index].filename}';
                return Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      Icon(Icons.broken_image),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          // homestay name
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.room.homestayName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'Tipe Kamar : ${widget.room.type}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Kuota          : ${widget.room.quota} orang',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Harga          : Rp ${widget.room.price}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // deskripsi
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.room.description,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),

      // bottom bar
      bottomNavigationBar: BottomAppBar(
        child: Container(
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(3)),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.2),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //     offset: Offset(0, -2),
            //   ),
            // ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Rp ${widget.room.price}/hari',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Booking Room'),
                          content:
                              Text('Are you sure you want to book this room?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Cancel'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('Book Now'),
                              onPressed: () {
                                _saveBooking(widget.room);
                                // Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PageBooking(),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3a5baa),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
