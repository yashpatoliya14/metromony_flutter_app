import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metromony/User_Display/about_page.dart';
import 'package:metromony/User_Display/favoriteList.dart';
import 'package:metromony/Userform/user_form.dart';
import 'package:metromony/User_Display/user_list.dart';
import 'package:animations/animations.dart';
import 'package:metromony/Utils/importFiles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  final int index;

  // Constructor with a default value for index if null
  Home({super.key, this.index = 0});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  bool isSearchBar = false;

  @override
  void initState() {
    super.initState();
    // Initialize _currentIndex with widget.index if passed, else default to 0
    _currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> bottomGradientColors = [Colors.red, Colors.deepOrange.shade300];
    final List<Color> appBarGradientColors = [Colors.red, Colors.deepOrange.shade300];

    final List<Widget> pages = [
      UserList(search: isSearchBar),
      UserForm(isAppBar: false),
      Favoritelist(),
    ];

    return Scaffold(
      body: PageTransitionSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: primaryAnimation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_currentIndex], // Use _currentIndex here
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: appBarGradientColors,
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          title: Text(
            "Matrimony",
            style: GoogleFonts.nunito(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearchBar = true;
                  _currentIndex = 0;
                });
              },
              icon: const Icon(Icons.search_outlined, color: Colors.white),
              iconSize: 25,
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutPage()));
              },
              icon: const Icon(Icons.info_outline_rounded, color: Colors.white),
              iconSize: 25,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: bottomGradientColors,
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
          ),
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            elevation: 0,
            indicatorColor: Colors.transparent,
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
              return GoogleFonts.nunito(
                fontSize: 12,
                fontWeight: states.contains(MaterialState.selected)
                    ? FontWeight.w900
                    : FontWeight.normal,
                color: states.contains(MaterialState.selected) ? Colors.white : Colors.white70,
              );
            }),
            iconTheme: MaterialStateProperty.resolveWith<IconThemeData>((states) {
              return IconThemeData(
                color: states.contains(MaterialState.selected) ? Colors.white : Colors.white70,
                size: 20,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            animationDuration: const Duration(milliseconds: 500),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            backgroundColor: Colors.transparent,
            destinations: const [
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.house),
                selectedIcon: Icon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.userPlus),
                selectedIcon: Icon(FontAwesomeIcons.userPlus),
                label: 'Add',
              ),
              NavigationDestination(
                icon: Icon(FontAwesomeIcons.heart),
                selectedIcon: Icon(FontAwesomeIcons.solidHeart),
                label: 'Favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
