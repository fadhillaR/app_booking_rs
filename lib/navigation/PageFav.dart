import 'package:app_booking_rs/PageDetailFav.dart';
import 'package:app_booking_rs/models/ModelFavorite.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PageFav extends StatefulWidget {
  const PageFav({Key? key}) : super(key: key);

  @override
  _PageFavState createState() => _PageFavState();
}

class _PageFavState extends State<PageFav> {
  int id_user = 0;
  List<Result> _favorites = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id_user = prefs.getInt('id_user') ?? 0;
      if (id_user == 0) {
        print('Id User is empty. Login process may have failed.');
      } else {
        _fetchFavorites();
      }
    });
  }

  Future<void> _fetchFavorites() async {
    try {
      http.Response response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/favorite'),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer $id_user',
        },
      );

      if (response.statusCode == 200) {
        final parsedData = modelFavoriteFromJson(response.body);
        setState(() {
          _favorites = parsedData.result;
        });
      } else {
        throw Exception('Failed to load favorites: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching favorites: $e')),
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

  // filter search
  void _filterFavorites(String query) {
    if (query.isEmpty) {
      _fetchFavorites();
      return;
    }

    String lowerCaseQuery = query.toLowerCase();

    setState(() {
      _favorites = _favorites
          .where((favorite) =>
              favorite.homestayName.toLowerCase().contains(lowerCaseQuery))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
              onChanged: _filterFavorites,
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
          Expanded(
            child: _favorites.isEmpty
                ? Center(
                    child: Text('No favorite items found'),
                  )
                : ListView.builder(
                    itemCount: _favorites.length,
                    itemBuilder: (context, index) {
                      Result favorite = _favorites[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageDetailFavorite(
                                favorite: favorite,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Card(
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.network(
                                  'http://127.0.0.1:8000/images/${favorite.homestayPicture}',
                                  width: 110,
                                  height: 110,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          capitalize(favorite.homestayName),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          truncateDescription(
                                              capitalize(
                                                  favorite.homestayAddress),
                                              5),
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
