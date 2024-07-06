import 'package:app_booking_rs/models/ModelHospital.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class PageHospital extends StatefulWidget {
  @override
  _PageHospitalState createState() => _PageHospitalState();
}

class _PageHospitalState extends State<PageHospital> {
  late Future<ModelHospital> _hospitalData;
  late List<Result> _results;
  List<Result> _filteredResults = [];
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _hospitalData = fetchHospitalData();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      _filterResults(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<ModelHospital> fetchHospitalData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/homestayhospital'));

    if (response.statusCode == 200) {
      final data = modelHospitalFromJson(response.body);
      setState(() {
        _results = data.result;
        _filteredResults = _results;
      });
      return data;
    } else {
      throw Exception('Failed to load hospital data');
    }
  }

  void _filterResults(String query) {
    final lowerCaseQuery = query.toLowerCase();
    setState(() {
      _filteredResults = _results.where((result) {
        return result.homestayName.toLowerCase().contains(lowerCaseQuery) ||
               result.hospital.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    });
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
            color: Color(0xFF424252),
          ),
        ),
        toolbarHeight: 50,
        backgroundColor: Color(0xFFE6E6E6),
        title: Text(
          'Hospital Terdekat',
          style: TextStyle(
            color: Color(0xFF424252),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: _searchController,
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
            child: FutureBuilder<ModelHospital>(
              future: _hospitalData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: _filteredResults.length,
                    itemBuilder: (context, index) {
                      final result = _filteredResults[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          leading: CachedNetworkImage(
                            imageUrl:
                                'http://127.0.0.1:8000/images/${result.homestayPicture}',
                            fit: BoxFit.cover,
                            width: 80,
                            height: 100,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          title: Text(
                            result.homestayName,
                            style: TextStyle(fontSize: 14),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.hospital,
                                style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(
                                truncateDescription(result.homestayAddress, 5),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,  // Add text overflow behavior
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          onTap: () {
                            _launchURL(result.googleMaps);
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    }
    return words.sublist(0, wordLimit).join(' ') + '...';
  }
}
