import 'package:app_booking_rs/PageLogin.dart';
import 'package:app_booking_rs/models/ModelBoard.dart';
import 'package:flutter/material.dart';

class BoardPage extends StatefulWidget {
  @override
  _BoardPageState createState() => _BoardPageState();
}

class _BoardPageState extends State<BoardPage> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 650,
          decoration: BoxDecoration(
            color: Color(0xFFf5ffff),
            // image: DecorationImage(
            //     image: AssetImage('assets/bgboard.png'),
            //     opacity: 0.1,
            //     fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1,
                          ),
                          Image(
                            image: AssetImage(contents[i].image),
                            width: 230,
                            height: 230,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            contents[i].title,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                // color: Color(0xFF7a8098)),
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                          SizedBox(height: 20),
                          Text(
                            contents[i].discription,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              // color: Color(0xFF7a8098),
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                height: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    contents.length,
                    (index) => buildDot(index, context),
                  ),
                ),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.all(40),
                width: double.infinity,
                child: ElevatedButton(
                  child: Text(
                    "Selanjutnya",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PageLogin(),
                        ),
                      );
                    }
                    _controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    // textStyle: TextStyle(color: Colors.white),
                    backgroundColor: Color(0xFF3a5baa),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      // side: BorderSide(
                      //   color: Color(0xFF424252), // Ganti warna border button di sini
                      //   width: 2.0, // Sesuaikan lebar border jika diperlukan
                      // ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
