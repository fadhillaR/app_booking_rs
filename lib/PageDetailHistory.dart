import 'package:app_booking_rs/PageNavigation.dart';
import 'package:app_booking_rs/models/ModelBooking.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageDetailHistory extends StatefulWidget {
  final Result booking;

  const PageDetailHistory({super.key, required this.booking});
  // const PageDetailHistory({super.key});

  @override
  State<PageDetailHistory> createState() => _PageDetailHistoryState();
}

class _PageDetailHistoryState extends State<PageDetailHistory> {
  late int totalDays;
  String name = "";
  String phone = "";

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    }
    return words.sublist(0, wordLimit).join(' ') + '...';
  }

  @override
  void initState() {
    super.initState();
    calculateTotalDays();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
    });
  }

  void calculateTotalDays() {
    setState(() {
      totalDays = widget.booking.day;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat.yMd().format(widget.booking.createdAt);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationPage(initialIndex: 1),
              ),
            );
            // Navigator.pop(context);
          },
          icon: Container(
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 50,
        // backgroundColor: Color(0xFFE6E6E6),
        backgroundColor: Colors.white,
        title: Text(
          'Booking Detail',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFf5ffff),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.grey),
                //   borderRadius: BorderRadius.circular(10),
                // ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${widget.booking.id}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$formattedDate',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$totalDays Hari',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Uncomment and use the Image.network if needed
                          // Container(
                          //   width: 100,
                          //   height: 100,
                          //   child: Image.network(
                          //     'http://127.0.0.1:8000/image/${widget.booking.rooms}',
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  capitalize(widget.booking.homestayName),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'Tipe Kamar: ' + capitalize(widget.booking.roomsType),
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
                                      '${widget.booking.day} hari',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '${widget.booking.totalPrice}',
                                      style: TextStyle(
                                        color: Colors.red,
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
                    SizedBox(height: 10),
                    Text(
                      'Booking Information',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Nama ',
                            ),
                            SizedBox(width: 78),
                            Text(
                              ':',
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                '$name',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'No HP',
                            ),
                            SizedBox(width: 78),
                            Text(
                              ':',
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: Text(
                                '$phone',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Status',
                            ),
                            SizedBox(width: 78),
                            Text(
                              ':',
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${widget.booking.status}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Status Room',
                            ),
                            SizedBox(width: 35),
                            Text(
                              ':',
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${widget.booking.statusRoom}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              'Total Payment',
                            ),
                            SizedBox(width: 25),
                            Text(
                              ':',
                            ),
                            SizedBox(width: 10),
                            Text(
                              '${widget.booking.totalPrice}',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
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
    );
  }
}
