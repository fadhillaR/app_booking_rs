import 'dart:convert';

import 'package:app_booking_rs/models/ModelHomestay.dart';
import 'package:app_booking_rs/models/ModelReview.dart';
import 'package:app_booking_rs/review/PageListReview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageDetailRS extends StatefulWidget {
  final Result homestay;

  const PageDetailRS({super.key, required this.homestay});

  @override
  State<PageDetailRS> createState() => _PageDetailRSState();
}

class _PageDetailRSState extends State<PageDetailRS> {
  late Future<ModelReview> _futureReviews;
  double _userRating = 0.0; // Menyimpan rating bintang pengguna
  bool _hasUserRated = false; // Menyimpan apakah pengguna sudah memberi rating
  bool _isFavorite = false;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _futureReviews = fetchReviews();
    _checkFavoriteStatus();
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  Future<void> _checkFavoriteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');
    if (id_user == null) return;

    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:8000/api/favorite/check/${widget.homestay.id}?user_id=$id_user'),
    );

    if (response.statusCode == 200) {
      setState(() {
        _isFavorite = jsonDecode(response.body)['data'] != null;
      });
    } else {
      throw Exception(
          'Failed to check favorite status: ${response.statusCode}');
    }
  }

  Future<void> _toggleFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');
    if (id_user == null) {
      print('No user ID found');
      return;
    }

    final url = _isFavorite
        ? 'http://127.0.0.1:8000/api/favorites/${widget.homestay.id}?user_id=$id_user'
        : 'http://127.0.0.1:8000/api/favorite';

    try {
      final response = _isFavorite
          ? await http.delete(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
            )
          : await http.post(
              Uri.parse(url),
              headers: {'Content-Type': 'application/json; charset=UTF-8'},
              body: jsonEncode(
                  {'user_id': id_user, 'homestays_id': widget.homestay.id}),
            );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        // Check favorite status
        _checkFavoriteStatus();

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       _isFavorite ? 'Added to favorites!' : 'Removed from favorites!',
        //     ),
        //     duration: Duration(seconds: 2),
        //   ),
        // );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(_isFavorite
                  ? 'Added to Favorites!'
                  : 'Removed from Favorites!'),
              content: Text(_isFavorite
                  ? 'This homestay has been added to your favorites.'
                  : 'This homestay has been removed from your favorites.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        throw Exception(
            'Failed to toggle favorite status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred: $error');
      throw Exception('Failed to toggle favorite status: $error');
    }
  }

  Future<ModelReview> fetchReviews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');
    try {
      final response = await http.get(
          Uri.parse('http://127.0.0.1:8000/api/review/${widget.homestay.id}'));

      if (response.statusCode == 200) {
        final reviews = modelReviewFromJson(response.body);
        // cek apakah user sudah memberi rating
        _hasUserRated = reviews.result.any((r) => r.userId == id_user);
        if (_hasUserRated) {
          // mengambil rating user jika sudah memberikan rating
          _userRating = double.parse(
              reviews.result.firstWhere((r) => r.userId == id_user).rating);
        }
        return reviews;
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load reviews: $error');
    }
  }

  Future<void> _postReview(double rating, String review) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id_user = prefs.getInt('id_user');

    if (rating == 0.0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide a rating.')),
      );
      return;
    }

    if (review.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a comment.')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/review'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'user_id': id_user,
          'homestays_id': widget.homestay.id,
          'rating': rating,
          'review': review,
        }),
      );

      if (response.statusCode == 201) {
        final result = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
        setState(() {
          _userRating = rating;
          _hasUserRated = true;
          _futureReviews = fetchReviews();
        });
      } else {
        throw Exception('Failed to post review: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to post review: $error');
    }
  }

  void _showReviewDialog() {
    if (_hasUserRated) {
      _showAlreadyRatedDialog();
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Give Your Review'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _userRating = index + 1.0;
                          });
                        },
                        child: Icon(
                          _userRating > index ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 30,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _reviewController,
                    decoration: InputDecoration(
                      labelText: 'Your Comment',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    onChanged: (value) {},
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _postReview(_userRating, _reviewController.text);
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showAlreadyRatedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('You have already rated'),
          content: Text('You have already given a rating for this homestay.'),
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

  List<Widget> _buildRatingStars(double rating) {
    return List.generate(5, (index) {
      Icon starIcon;
      if (index + 1 <= rating) {
        starIcon = const Icon(Icons.star, color: Colors.orange, size: 16);
      } else if (index + 0.5 == rating) {
        starIcon = const Icon(Icons.star_half, color: Colors.orange, size: 16);
      } else {
        starIcon =
            const Icon(Icons.star_border, color: Colors.orange, size: 16);
      }
      return starIcon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Information',
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
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(
            'http://127.0.0.1:8000/images/${widget.homestay.picture}',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(3),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
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
                      widget.homestay.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                        size: 30,
                      ),
                      onPressed: _toggleFavorite,
                    ),
                  ],
                ),
                // // Tombol untuk memberi rating
                // _hasUserRated
                //     ? SizedBox.shrink()
                //     : GestureDetector(
                //         onTap: _showReviewDialog,
                //         child: Row(
                //           children: List.generate(5, (index) {
                //             return GestureDetector(
                //               onTap: () {
                //                 setState(() {
                //                   _userRating = index + 1.0;
                //                 });
                //               },
                //               child: Icon(
                //                 _userRating > index
                //                     ? Icons.star
                //                     : Icons.star_border,
                //                 color: Colors.orange,
                //                 size: 30,
                //               ),
                //             );
                //           }),
                //         ),
                //       ),

                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tambahkan Review :',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_comment, color: Colors.orange),
                      onPressed: _showReviewDialog,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.homestay.address,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          FutureBuilder<ModelReview>(
            future: _futureReviews,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text('Failed to load reviews: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                return Center(child: Text('No reviews available'));
              } else {
                var reviews = snapshot.data!.result
                    .where((r) => r.homestaysId == widget.homestay.id)
                    .toList();

                var averageRating = reviews.isEmpty
                    ? 0.0
                    : reviews
                            .map((r) => double.parse(r.rating))
                            .reduce((a, b) => a + b) /
                        reviews.length;

                int totalReviews = reviews.length;

                return Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
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
                          Row(
                            children: [
                              Text(
                                'Reviews',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 16),
                                  SizedBox(width: 4),
                                  Text(
                                    '${averageRating.toStringAsFixed(1)}/5',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PageListReview(
                                    homestaysId: widget.homestay.id,
                                  ),
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            child: Text(
                              'See All (${totalReviews})',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3a5baa),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(height: 8),
                      // ...reviews.map((review) => Padding(
                      //       padding: const EdgeInsets.only(bottom: 8.0),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             capitalize(review.user!.name),
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               color: Colors.black,
                      //             ),
                      //           ),
                      //           SizedBox(height: 4),
                      //           Row(
                      //             children: _buildRatingStars(
                      //                 double.parse(review.rating)),
                      //           ),
                      //           SizedBox(height: 4),
                      //           Text(
                      //             review.review,
                      //             style: TextStyle(
                      //               fontSize: 14,
                      //               color: Colors.grey[700],
                      //             ),
                      //           ),
                      //           SizedBox(height: 8),
                      //         ],
                      //       ),
                      //     )),
                      // reviews.isEmpty
                      //     ? Center(child: Text('No Review Added!'))
                      //     : SizedBox.shrink(),

                      SizedBox(height: 8),
                      ListView(
                        shrinkWrap: true,
                        physics:
                            NeverScrollableScrollPhysics(), // Disable scrolling for nested ListView
                        children: reviews
                            .take(2)
                            .map((review) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        capitalize(review.user!.name),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: _buildRatingStars(
                                            double.parse(review.rating)),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        review.review,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      reviews.isEmpty
                          ? Center(child: Text('No Review Added!'))
                          : SizedBox.shrink(),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
