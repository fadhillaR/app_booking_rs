import 'package:app_booking_rs/PageDetailRoom.dart';
import 'package:app_booking_rs/models/ModelRoom.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class PageRoom extends StatefulWidget {
  const PageRoom({super.key});

  @override
  State<PageRoom> createState() => _PageRoomState();
}

class _PageRoomState extends State<PageRoom> with TickerProviderStateMixin {
  List<Result> _room = [];
  late TextEditingController _searchController;
  bool _isLoading = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _fetchRoom();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _fetchRoom() async {
    setState(() {
      _isLoading = true;
    });

    try {
      http.Response response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/room'),
      );

      if (response.statusCode == 200) {
        final parsedData = modelRoomFromJson(response.body);
        setState(() {
          _room = parsedData.result;
          List<String> roomTypes = _getUniqueRoomTypes();
          roomTypes.insert(0, 'All'); // Add "All" tab
          _tabController = TabController(length: roomTypes.length, vsync: this);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load room: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching room: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching room: $e')),
      );
    }
  }

  String capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  // Filter search
  void _filterRoom(String query) {
    if (query.isEmpty) {
      _fetchRoom();
      return;
    }

    String lowerCaseQuery = query.toLowerCase();

    setState(() {
      _room = _room
          .where((room) =>
              room.homestayName.toLowerCase().contains(lowerCaseQuery))
          .toList();
    });
  }

  // Get unique room types
  List<String> _getUniqueRoomTypes() {
    List<String> types = _room.map((room) => room.type).toSet().toList();
    types.sort();
    return types;
  }

  // Get rooms by type
  List<Result> _getRoomsByType(String type) {
    if (type == 'All') {
      return _room;
    }
    return _room.where((room) => room.type == type).toList();
  }

  String truncateDescription(String description, int wordLimit) {
    List<String> words = description.split(' ');
    if (words.length <= wordLimit) {
      return description;
    }
    return words.sublist(0, wordLimit).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    List<String> roomTypes = ['All'] + _getUniqueRoomTypes();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Room Rumah Singgah',
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
      body: _isLoading
          ? Center(
              child: SpinKitCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterRoom,
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelColor: Color(0xFF3a5baa),
                    unselectedLabelColor: Colors.black,
                    tabs: roomTypes
                        .map((type) => Tab(text: capitalize(type)))
                        .toList(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TabBarView(
                      controller: _tabController,
                      children: roomTypes.map((type) {
                        List<Result> roomsByType = _getRoomsByType(type);
                        return roomsByType.isEmpty
                            ? Center(child: Text('No homestay available'))
                            : GridView.builder(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1,
                                ),
                                itemCount: roomsByType.length,
                                itemBuilder: (context, index) {
                                  Result room = roomsByType[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PageDetailRoom(room: room),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // ClipRRect(
                                          //   borderRadius: BorderRadius.vertical(
                                          //     top: Radius.circular(10),
                                          //   ),
                                          //   child: Image.network(
                                          //     'http://127.0.0.1:8000/images/${room.picture.first.filename}',
                                          //     height: 130,
                                          //     width: double.infinity,
                                          //     fit: BoxFit.cover,
                                          //     errorBuilder: (context, error,
                                          //             stackTrace) =>
                                          //         Icon(Icons.broken_image),
                                          //   ),
                                          // ),
                                          Container(
                                            height: 130,
                                            width: double.infinity,
                                            child: PageView.builder(
                                              itemCount: room.picture.length,
                                              itemBuilder: (context, index) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.vertical(
                                                    top: Radius.circular(10),
                                                  ),
                                                  child: Image.network(
                                                    'http://127.0.0.1:8000/images/${room.picture[index].filename}',
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Icon(
                                                            Icons.broken_image),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 8.0),
                                            child: Text(
                                              truncateDescription(
                                                  capitalize(room.homestayName),
                                                  4),
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 1.0,
                                                bottom: 8.0),
                                            child: Text(
                                              truncateDescription(
                                                  capitalize(room.description),
                                                  5),
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
                              );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
