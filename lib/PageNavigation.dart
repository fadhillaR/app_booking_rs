import 'package:app_booking_rs/navigation/HomePage.dart';
import 'package:app_booking_rs/navigation/PageHistory.dart';
import 'package:app_booking_rs/navigation/PageFav.dart';
import 'package:app_booking_rs/navigation/PageSetting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  final int initialIndex;

  const BottomNavigationPage({super.key, this.initialIndex = 0});
  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: 4, vsync: this, initialIndex: widget.initialIndex);
    pageController = PageController(initialPage: widget.initialIndex);

    //sinkronisasi
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        pageController.jumpToPage(tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: tabController, children: [
        PageMulai(pageController: pageController),
        // PageMulai(),
        PageHistory(),
        PageFav(),
        PageSetting()
      ]),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(5), bottom: Radius.circular(5)),
            color: Colors.white,
            // color: Color(0xFFf5ffff),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabBar(
                isScrollable: true,
                // labelColor: Color.fromARGB(255, 85, 77, 181),
                labelColor: Colors.blueAccent,
                // unselectedLabelColor: Color(0xFF424252),
                unselectedLabelColor: Color(0xFF3a5baa),
                controller: tabController,
                tabs: [
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0),
                      child: Icon(Icons.home_outlined),
                    ),
                  ),
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0),
                      // child: Icon(Icons.favorite),
                      child: Icon(Icons.history),
                    ),
                  ),
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0),
                      // child: Icon(Icons.local_shipping),
                      child: Icon(Icons.favorite),
                    ),
                  ),
                  Tab(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0), // Adjust spacing here
                      child: Icon(Icons.settings),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 0),
            ],
          ),
        ),
      ),
    );
  }
}
