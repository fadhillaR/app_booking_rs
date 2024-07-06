import 'dart:convert';

import 'package:app_booking_rs/PageNavigation.dart';
import 'package:app_booking_rs/models/ModelFavorite.dart';
import 'package:app_booking_rs/models/ModelReview.dart';
import 'package:app_booking_rs/review/PageListReview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PageDetailFavorite extends StatefulWidget {
  final Result favorite;

  const PageDetailFavorite({super.key, required this.favorite});

  @override
  State<PageDetailFavorite> createState() => _PageDetailFavoriteState();
}

class _PageDetailFavoriteState extends State<PageDetailFavorite> {
  late Future<ModelReview> _futureReviews;
  bool _isFavorite = true;

  @override
  void initState() {
    super.initState();
    _futureReviews = fetchReviews();
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  Future<ModelReview> fetchReviews() async {
    try {
      final response = await http.get(Uri.parse(
          'http://127.0.0.1:8000/api/review/${widget.favorite.homestaysId}'));

      if (response.statusCode == 200) {
        return modelReviewFromJson(response.body);
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load reviews: $error');
    }
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

  Future<void> _removeFavorite() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('id_user');

      final response = await http.delete(
        Uri.parse(
            'http://127.0.0.1:8000/api/favorites/${widget.favorite.homestaysId}?user_id=$userId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
          ),
        );
        // Navigator.pop(context);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigationPage(initialIndex: 2)),
          (route) => false, 
        );
      } else {
        throw Exception('Failed to remove favorite: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $error'),
        ),
      );
    }
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Remove Favorite'),
          content: Text(
              'Are you sure you want to remove this homestay from your favorites?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _removeFavorite();
                Navigator.of(context).pop();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  void _showReviewDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Your Review'),
          content:
              Text('This feature is available for you to add your review.'),
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
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              _showConfirmDialog();
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(
            'http://127.0.0.1:8000/images/${widget.favorite.homestayPicture}',
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
                      widget.favorite.homestayName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  widget.favorite.homestayAddress,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                // SizedBox(height: 16),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       'Tambahkan Review :',
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     IconButton(
                //       icon: Icon(Icons.add_comment, color: Colors.orange),
                //       onPressed: _showReviewDialog,
                //     ),
                //   ],
                // ),
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
                    .where((r) => r.homestaysId == widget.favorite.homestaysId)
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
                                    homestaysId: widget.favorite.homestaysId,
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
                      SizedBox(height: 8),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
