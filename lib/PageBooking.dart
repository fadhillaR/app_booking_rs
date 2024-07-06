import 'package:app_booking_rs/PageKonfirmasi.dart';
import 'package:app_booking_rs/models/ModelRoom.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PageBooking extends StatefulWidget {
  const PageBooking({super.key});

  @override
  State<PageBooking> createState() => _PageBookingState();
}

class _PageBookingState extends State<PageBooking> {
  int id_user = 0;
  String name = "";
  String email = "";
  String phone = "";
  Result? bookedRoom;
  int days = 1;

  @override
  void initState() {
    super.initState();
    _loadBooking();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id_user = prefs.getInt('id_user') ?? 0;
      name = prefs.getString('name') ?? '';
      email = prefs.getString('email') ?? '';
      phone = prefs.getString('phone') ?? '';
      print(
          'Loaded profile data: Name: $name, Email: $email, Id User: $id_user');
    });
  }

  Future<void> _loadBooking() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? roomData = prefs.getString('bookedRoom');
    if (roomData != null) {
      setState(() {
        bookedRoom = Result.fromJson(jsonDecode(roomData));
      });
    }
  }

  Future<void> _placeBooking(String methodPayment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');

    if (id_user == null || bookedRoom == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to get user or booking data')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/booking'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'user_id': id_user,
          'homestays_id': bookedRoom!.homestaysId,
          'rooms_id': bookedRoom!.id,
          // 'day': 1,
          'day': days,
          'status': 'process',
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        bool success = responseData['success'] != null;
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PageKonfirmasi(),
            ),
          );
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Booking berhasil')),
          // );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Booking gagal: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Booking gagal: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking gagal: $e')),
      );
    }
  }

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

  double calculateTotalPrice() {
    if (bookedRoom == null) {
      return 0.0;
    }

    double price;
    if (bookedRoom!.price is int) {
      price = (bookedRoom!.price as int).toDouble();
    } else if (bookedRoom!.price is String) {
      price = double.tryParse(bookedRoom!.price as String) ?? 0.0;
    } else if (bookedRoom!.price is double) {
      price = bookedRoom!.price as double;
    } else {
      // Default to 0.0 if price type is unexpected
      price = 0.0;
    }

    return price * days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            // color: Color(0xFF424252),
            color: Colors.black,
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Colors.white,
        title: Text(
          'Booking',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.blueAccent,
                  Colors.blueAccent,
                  Colors.blueAccent,
                ],
                stops: [0.1, 0.4, 0.6, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   'User Details',
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 13,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Text(
                        // bookedRoom != null
                        //     ? bookedRoom!.homestayName
                        //     : 'No room selected',
                        capitalize('$name'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // bookedRoom != null
                        //     ? bookedRoom!.homestayName
                        //     : 'No room selected',
                        '$email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        // bookedRoom != null
                        //     ? '${bookedRoom!.type} | ${bookedRoom!.price}'
                        //     : '',

                        '$phone',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.hotel,
                    color: Colors.black,
                  ),
                  // leading: Icon(
                  //   Icons.location_on,
                  //   color: Color(0xFF424252),
                  // ),
                  title: Text(
                    '${bookedRoom!.homestayName}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Tipe Kamar: ${bookedRoom!.type}\n' +
                        'Kuota: ${bookedRoom!.quota}\n',
                    // truncateDescription('${bookedRoom!.description}', 6),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  trailing: Text(
                    'Rp. ${bookedRoom!.price}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // SizedBox(height: 20),
                // Center(
                //   child: ElevatedButton(
                //     onPressed: () => _placeBooking('someMethod'),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Color(0xFF424252),
                //       elevation: 0,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //     ),
                //     child: Text(
                //       'Confirm Booking',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 16.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Hari :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (days > 1) {
                          setState(() {
                            days--;
                          });
                        }
                      },
                    ),
                    Text(
                      '$days',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          days++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      // bottom button
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Container(
          height: 50.0,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // 'Total : Rp. ${bookedRoom!.price}',
                'Total : Rp. ${calculateTotalPrice().toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                // onPressed: _showPaymentMethodDialog,
                onPressed: () => _placeBooking('someMethod'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3a5baa),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
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
