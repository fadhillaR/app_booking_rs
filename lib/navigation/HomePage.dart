import 'dart:async';

import 'package:app_booking_rs/PageListRS.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageMulai extends StatefulWidget {
  final PageController pageController;

  const PageMulai({required this.pageController, Key? key}) : super(key: key);
  // const PageMulai({super.key});

  @override
  State<PageMulai> createState() => _PageMulaiState();
}

class _PageMulaiState extends State<PageMulai> with TickerProviderStateMixin {
  String? userName;
  late Timer _timer;

  int _currentPage = 0;
  bool _isDialogShown = false;

  @override
  void initState() {
    super.initState();
    getUsername();
    startTimer();
    widget.pageController.addListener(_handlePageChange);
  }

  @override
  void dispose() {
    _timer.cancel();
    widget.pageController.removeListener(_handlePageChange);
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      widget.pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  void _handlePageChange() {
    if (widget.pageController.page == 2) {
      Future.delayed(Duration(seconds: 3), () {
        if (widget.pageController.hasClients) {
          widget.pageController.jumpToPage(0);
        }
      });
    }
  }

  Future<void> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('name') ?? '';
    });
    

    // // Show welcome dialog if userName is not empty
    // if (userName != null && userName!.isNotEmpty) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _showWelcomeDialog(userName!);
    //   });
    // }

    // if dialog has been shown before
    bool isDialogShown = prefs.getBool('isDialogShown') ?? false;
    if (userName != null && userName!.isNotEmpty && !isDialogShown) {
      // Save the dialog shown status
      prefs.setBool('isDialogShown', true);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomeDialog(userName!);
      });
    }
  }

  void _showWelcomeDialog(String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Rumah Singgah'),
          content: Text('Selamat datang, ${capitalize(name)}!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        // toolbarHeight: 20,
        // backgroundColor: Color(0xFFE6E6E6),
        backgroundColor: Colors.white,
        title: Text(
          'Rumah Singgah',
          style: TextStyle(
            // color: Color(0xFF3a5baa),
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //           builder: (context) => PageListCart(),
        //         ),
        //       );
        //     },
        //     icon: Container(
        //       child: Icon(
        //         Icons.shopping_cart,
        //         color: Color(0xFF424252),
        //       ),
        //     ),
        //   ),
        // ],
        // actions: [
        //   if (userName != null)
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Center(
        //         child: Text(
        //           'Hi, ${capitalize(userName!)}',
        //           style: TextStyle(
        //             color: Colors.black,
        //             fontSize: 16,
        //           ),
        //         ),
        //       ),
        //     ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 800,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white, // Warna utama di tengah
                Colors.white, // Warna transparan di pinggir
                Colors.white, // Warna transparan di pinggir
                Colors.white, // Warna utama di tengah
              ],
              // colors: [
              //   Color(0xFFE6E6E6), // Warna utama di tengah
              //   Color(0xFFE6E6E6), // Warna transparan di pinggir
              //   Color(0xFFE6E6E6), // Warna transparan di pinggir
              //   Color(0xFFE6E6E6), // Warna utama di tengah
              // ],
              stops: [
                0.1,
                0.4,
                0.6,
                0.9
              ], // Menentukan ukuran masing-masing warna
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                //slider
                Container(
                  height: 200,
                  child: PageView(
                    controller: widget.pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                      print("Page changed to: $page");
                    },
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Image.network(
                        'https://izi.or.id/wp-content/uploads/2022/05/Rumah-Singgah-Pasien-1024x682.jpeg',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://static.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/p1/127/2023/11/12/FotoJet135-680111003.jpg',
                        fit: BoxFit.cover,
                      ),
                      Image.network(
                        'https://asset-2.tstatic.net/aceh/foto/bank/images/rumah-singgah-rumah-sakit-umum-daerah-dr-zainoel-abidin-2019.jpg',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),

                //button grid
                Container(
                  color: Colors.white,
                  child: Padding(
                    // padding: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            menuContainer(
                              icon: Icons.home_filled,
                              label: 'Daftar\nRumah Singgah',
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PageListRS()));
                              },
                            ),
                            SizedBox(width: 20),
                            menuContainer(
                              icon: Icons.shopping_cart,
                              label: 'Booking\n Rumah Singgah',
                              onTap: () {
                                // Navigasi ke halaman riwayat pemesanan
                              },
                            ),
                            SizedBox(width: 20),
                            menuContainer(
                              icon: Icons.credit_card,
                              label: 'Donasi',
                              onTap: () {
                                // Navigasi ke halaman donasi
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // SizedBox(width: 0.12),
                            // Text('  ', style: TextStyle(color: Colors.white),),
                            menuContainer(
                              icon: Icons.money,
                              label: 'Program Donasi\nRumah Singgah',
                              onTap: () {
                                // Navigasi ke halaman daftar rumah singgah
                              },
                            ),
                            SizedBox(width: 20),
                            menuContainer(
                              icon: Icons.photo_album,
                              label: 'Gallery',
                              onTap: () {
                                // Navigasi ke halaman riwayat pemesanan
                              },
                            ),
                            SizedBox(width: 20),
                            menuContainer(
                              icon: Icons.inventory_rounded,
                              label: 'Testimoni',
                              onTap: () {
                                // Navigasi ke halaman donasi
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget menuContainer(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            Icon(icon, size: 50, color: Color(0xFF3a5baa)),
            SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
