import 'dart:convert';

import 'package:app_booking_rs/PageDetailHistory.dart';
import 'package:app_booking_rs/models/ModelBooking.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PageHistory extends StatefulWidget {
  const PageHistory({super.key});

  @override
  State<PageHistory> createState() => _PageHistoryState();
}

class _PageHistoryState extends State<PageHistory> {
  int id_user = 0;

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id_user = prefs.getInt('id_user') ?? 0;
    });
  }

  Future<List<Result>> fetchBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');

    // if (token.isEmpty) {
    //   print('Token is empty. Login process may have failed.');
    //   return [];
    // }

    if (id_user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get user or booking data')),
      );
      return [];
    }

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/booking'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    //   if (jsonResponse['status'] == true) {
    //     List<dynamic> data = jsonResponse['data'];
    //     List<Result> booking =
    //         data.map((booking) => Result.fromJson(booking)).toList();
    //     return booking;
    //   } else {
    //     print('Failed to fetch booking: ${jsonResponse['message']}');
    //     return [];
    //   }
    // } else {
    //   throw Exception('Failed to load booking');
    // }

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse['message'] == 'Data Berhasil di Akses') {
        List<dynamic> data = jsonResponse['result'];
        List<Result> bookings =
            data.map((booking) => Result.fromJson(booking)).toList();

        // Filter bookings by id_user
        List<Result> filteredBookings =
            bookings.where((booking) => booking.userId == id_user).toList();
        // return booking;
        return filteredBookings;
      } else {
        print('Failed to fetch booking: ${jsonResponse['message']}');
        return [];
      }
    } else {
      throw Exception('Failed to load booking');
    }
  }

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    }
    return words.sublist(0, wordLimit).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          'Booking Information',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<List<Result>>(
          future: fetchBooking(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No room has been booked.'));
            } else {
              List<Result> bookings = snapshot.data!;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  Result booking = bookings[index];
                  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
                  String formattedBookingDate =
                      dateFormat.format(booking.createdAt);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3), 
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PageDetailHistory(booking: booking),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Container(
                              //   width: 100,
                              //   height: 100,
                              //   child: Image.network(
                              //     'http://127.0.0.1:8000/image/${booking.homestayName}',
                              //     fit: BoxFit.cover,
                              //   ),
                              // ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          booking.homestayName,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          formattedBookingDate,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Total Room : ${booking.day}',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          capitalize('${booking.status}'),
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          capitalize('${booking.statusRoom}'),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
