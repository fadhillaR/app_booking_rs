import 'package:app_booking_rs/PageNavigation.dart';
import 'package:app_booking_rs/PageUpdateProfil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageProfil extends StatefulWidget {
  @override
  State<PageProfil> createState() => _PageProfilState();
}

class _PageProfilState extends State<PageProfil> {
  String name = '';
  String email = '';
  String phone = '';
  String address = '';
  String picture = '';
  String password = '';

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // username = prefs.getString('username') ?? '';
      email = prefs.getString('email') ?? '';
      name = prefs.getString('name') ?? '';
      phone = prefs.getString('phone') ?? '';
      address = prefs.getString('address') ?? '';
      picture = prefs.getString('picture') ?? '';
      password = prefs.getString('password') ?? '';
    });
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    String defaultPictureUrl =
        'https://static.thenounproject.com/png/544828-200.png';
    String profilePictureUrl = picture.isNotEmpty
        ? 'http://127.0.0.1:8000/images/$picture'
        : defaultPictureUrl;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => BottomNavigationPage(initialIndex: 3),
              ),
              (route) => false,
            );
          },
          icon: Container(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF424252),
            ),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0xFFE6E6E6),
        title: Text(
          'My Profile',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        // centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            // child: SizedBox(height: 5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 700,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                // CircleAvatar(
                                //   radius: 35,
                                //   backgroundImage: NetworkImage(
                                //       'https://static.thenounproject.com/png/544828-200.png'),
                                // ),
                                CircleAvatar(
                                  radius: 35,
                                  // backgroundImage: NetworkImage(
                                  //   picture.isNotEmpty ? picture : defaultPictureUrl,
                                  // ),
                                  backgroundImage:
                                      NetworkImage(profilePictureUrl),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      capitalize('$name'),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '$email',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Port Slab',
                                      ),
                                    ),
                                    Text(
                                      '$phone',
                                      style: TextStyle(
                                          fontSize: 10,
                                          fontFamily: 'Open Sans',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            Card(
                              elevation: 1,
                              color: Color(0xFFFEFBFB),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Data Pribadi',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                      ),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Name\t: ' + capitalize('$name'),
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Email\t: $email',
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        // hintText: 'Alamat\t: $address',
                                        hintText:
                                            'Alamat\t: ' + capitalize('${address.isNotEmpty ? address : "Alamat kosong"}'),
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                    TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'No. HP\t: $phone',
                                        hintStyle: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: 25,
                            // ),
                            // Card(
                            //   elevation: 1,
                            //   color: Color(0xFFFEFBFB),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(16.0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  "Ubah Profile",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PageUpdateProfil(),
                                    ),
                                  );
                                },
                                // onPressed: () async {
                                //   // Mengambil data gambar yang diperbarui
                                //   final updatedPicture = await Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => PageUpdateProfil(),
                                //     ),
                                //   );
                                //   if (updatedPicture != null) {
                                //     setState(() {
                                //       picture = updatedPicture; // Update gambar
                                //       _loadProfile();
                                //     });
                                //   }
                                // },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            // child: Container(
            //   height: 100,
            // ),
          ),
        ],
      ),
    );
  }
}
