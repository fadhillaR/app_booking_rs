import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import '../models/ModelGaleri.dart'; // Ganti dengan path yang sesuai jika berbeda

class PageGaleri extends StatefulWidget {
  @override
  _PageGaleriState createState() => _PageGaleriState();
}

class _PageGaleriState extends State<PageGaleri> {
  late Future<ModelGaleri> _futureGaleri;

  @override
  void initState() {
    super.initState();
    _futureGaleri = fetchGaleri();
  }

  Future<ModelGaleri> fetchGaleri() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/galery'));

    if (response.statusCode == 200) {
      return modelGaleriFromJson(response.body);
    } else {
      throw Exception('Failed to load galeri');
    }
  }

  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.contain,
            width: double.infinity,
            height: double.infinity,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Gallery Photos',
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
      body: FutureBuilder<ModelGaleri>(
        future: _futureGaleri,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.result.length,
              itemBuilder: (context, index) {
                final pictureUrl =
                    'http://127.0.0.1:8000/images/${snapshot.data!.result[index].picture}';

                // return ClipRRect(
                //   borderRadius: BorderRadius.circular(8.0),
                //   child: CachedNetworkImage(
                //     imageUrl: pictureUrl,
                //     placeholder: (context, url) =>
                //         Center(child: CircularProgressIndicator()),
                //     errorWidget: (context, url, error) => Icon(Icons.error),
                //     fit: BoxFit.cover,
                //   ),
                // );
                return GestureDetector(
                  onTap: () => _showImageDialog(pictureUrl),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: pictureUrl,
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
