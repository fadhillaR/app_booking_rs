import 'package:app_booking_rs/models/ModelReview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class PageListReview extends StatefulWidget {
  final int homestaysId;

  // const PageListReview({super.key, required this.homestaysId});
  const PageListReview({required this.homestaysId, Key? key}) : super(key: key);

  @override
  State<PageListReview> createState() => _PageListReviewState();
}

class _PageListReviewState extends State<PageListReview> {
  late Future<ModelReview> _futureReviews;

  @override
  void initState() {
    super.initState();
    _futureReviews = fetchReviews();
  }

  Future<ModelReview> fetchReviews() async {
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/review/${widget.homestaysId}'),
      );

      if (response.statusCode == 200) {
        return modelReviewFromJson(response.body);
      } else {
        throw Exception('Failed to load reviews: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to load reviews: $error');
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  // star widgets
  List<Widget> _buildRatingStars(double rating) {
    List<Widget> stars = [];
    for (int i = 1; i <= 5; i++) {
      Icon starIcon;
      if (i <= rating) {
        starIcon = const Icon(Icons.star, color: Colors.orange, size: 16);
      } else {
        starIcon = const Icon(Icons.star_border, color: Colors.orange, size: 16);
      }
      stars.add(starIcon);
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Reviews',
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
      body: FutureBuilder<ModelReview>(
        future: _futureReviews,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final reviews = snapshot.data?.result ?? [];
            if (reviews.isEmpty) {
              return const Center(child: Text('No reviews available'));
            }

            return ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                DateFormat dateFormat = DateFormat('dd MMM yyyy');
                String formattedBookingDate =
                    dateFormat.format(review.createdAt);

                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(color: Colors.black, width: 1.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            capitalize(review.user!.name),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0),
                          ),
                          Text(
                            '$formattedBookingDate',
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          ..._buildRatingStars(double.parse(review.rating)),
                          // // jumlah star
                          // Text(
                          //   review.rating,
                          //   style: const TextStyle(
                          //       fontSize: 16.0, fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(capitalize(review.review)),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No reviews available'));
          }
        },
      ),
    );
  }
}
