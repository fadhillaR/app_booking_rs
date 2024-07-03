import 'package:app_booking_rs/PageDetailRS.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:app_booking_rs/models/ModelHomestay.dart';

class PageListRS extends StatefulWidget {
  const PageListRS({super.key});

  @override
  State<PageListRS> createState() => _PageListRSState();
}

class _PageListRSState extends State<PageListRS> {
  List<Result> _homestay = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    // _loadUserData();
    _searchController = TextEditingController();
    _fetchHomestay();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Future<void> _loadUserData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     token = prefs.getString('token') ?? '';
  //     if (token.isEmpty) {
  //       print('Token is empty. Login process may have failed.');
  //     } else {
  //       _fetchFavorites();
  //     }
  //   });
  // }

  Future<void> _fetchHomestay() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/homestay'),
        // headers: {
        //   'Content-Type': 'application/json',
        //   'Authorization': 'Bearer $token',
        // },
      );

      if (response.statusCode == 200) {
        final parsedData = modelHomestayFromJson(response.body);
        setState(() {
          _homestay = parsedData.result;
        });
      } else {
        throw Exception('Failed to load homestay: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching homestay: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching homestay: $e')),
      );
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  // filter search
  void _filterHomestay(String query) {
    if (query.isEmpty) {
      _fetchHomestay();
      return;
    }

    String lowerCaseQuery = query.toLowerCase();

    setState(() {
      _homestay = _homestay
          .where((homestay) =>
              homestay.name.toLowerCase().contains(lowerCaseQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Rumah Singgah',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _filterHomestay,
              decoration: InputDecoration(
                labelText: 'Search',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Color(0xFFE6E6E6)),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _homestay.isEmpty
                ? Center(
                    child: Text('No homestay found'),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // item per row
                      crossAxisSpacing: 10, // horizontal space between items
                      mainAxisSpacing: 10, // vertical space between items
                      childAspectRatio: 1, // height
                    ),
                    itemCount: _homestay.length,
                    itemBuilder: (context, index) {
                      Result homestay = _homestay[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageDetailRS(
                                homestay: homestay,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: EdgeInsets.all(0),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(10),
                                ),
                                child: Image.network(
                                  'http://127.0.0.1:8000/images/${homestay.picture}',
                                  height: 130,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Text(
                                  capitalize(homestay.name),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 1.0, bottom: 8.0),
                                child: Text(
                                  capitalize(homestay.address),
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
