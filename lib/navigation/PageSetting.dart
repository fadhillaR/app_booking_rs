import 'package:app_booking_rs/PageProfil.dart';
import 'package:app_booking_rs/otherPage/PageAbout.dart';
import 'package:app_booking_rs/otherPage/PageContact.dart';
import 'package:app_booking_rs/otherPage/PageFAQ.dart';
import 'package:app_booking_rs/otherPage/PageHelp.dart';
import 'package:app_booking_rs/otherPage/PageLegal.dart';
import 'package:app_booking_rs/otherPage/PageTerms.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_booking_rs/PageLogin.dart';

class PageSetting extends StatelessWidget {
  const PageSetting({Key? key}) : super(key: key);

  Future<bool> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    return isLoggedIn ?? false;
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => PageLogin()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xfff6f6f6),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView(
            children: [
              _SingleSection(
                title: "General",
                children: [
                  _CustomListTile(
                    title: "FAQ",
                    icon: CupertinoIcons.question_diamond,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageFAQ(),
                        ),
                      );
                    },
                  ),
                  // const _CustomListTile(
                  //     title: "Language", icon: CupertinoIcons.globe),
                  // const _CustomListTile(
                  //     title: "Themes", icon: CupertinoIcons.paintbrush),
                  _CustomListTile(
                    title: "Terms and Conditions",
                    icon: CupertinoIcons.square_list,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageTerms(),
                        ),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "About Us",
                    icon: CupertinoIcons.question,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageAbout(),
                        ),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "Contact Us",
                    icon: CupertinoIcons.phone,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageContact(),
                        ),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "Help",
                    icon: CupertinoIcons.info_circle,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageHelp(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              _SingleSection(
                title: "Privacy and Security",
                children: [
                  _CustomListTile(
                    title: "Account",
                    icon: CupertinoIcons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageProfil(),
                        ),
                      );
                    },
                  ),
                  _CustomListTile(
                    title: "Legal & Policy",
                    icon: CupertinoIcons.shield,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageLegal(),
                        ),
                      );
                    },
                  ),
                  // const _CustomListTile(
                  //     title: "Security", icon: CupertinoIcons.lock_shield),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: ListTile(
                    title: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ),
                    leading: const Icon(
                      CupertinoIcons.power,
                      color: Colors.red,
                    ),
                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Logout"),
                            content:
                                const Text("Are you sure you want to logout?"),
                            actions: [
                              TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text("Logout"),
                                onPressed: () async {
                                  await _logout(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _CustomListTile(
      {Key? key,
      required this.title,
      required this.icon,
      this.trailing,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing: trailing ?? const Icon(CupertinoIcons.forward, size: 18),
      onTap: onTap,
    );
  }
}

class _SingleSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SingleSection({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style:
                Theme.of(context).textTheme.headline6?.copyWith(fontSize: 16),
          ),
        ),
        Container(
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
