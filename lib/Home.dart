import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metromony/Crud.dart';
import 'package:metromony/FavoriteList.dart';
import 'package:metromony/UserForm.dart';
import 'package:metromony/UserList.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  NotchBottomBarController _controller = NotchBottomBarController();
  late List<Widget> pages;
  bool isSearchBar = false;
  @override
  void initState() {
    super.initState();
    pages = [
      UserList(search: isSearchBar,),
      UserForm(),
      Favoritelist()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height*0.08),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade400,
                Colors.teal.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),

              )
            ),
            centerTitle: true,
            title: Text(
              "Matrimony",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(color: Colors.white , fontWeight:FontWeight.w700,fontSize: 25),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(onPressed: (){
                    setState(() {
                      isSearchBar = true;
                    });
                      pages[0] = UserList(search:isSearchBar);
                }, icon: Icon(Icons.search_outlined,color: Colors.white),iconSize: 25,)
              )
            ],
          ),
        ),
      ),
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue.shade50, Colors.white60],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: pages[_currentIndex]),


        bottomNavigationBar: FlashyTabBar(
          animationCurve: Curves.linear,
          selectedIndex: _currentIndex,
          iconSize: 30,
          showElevation: false, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home_filled),
              title: Text('Home'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.person_add_rounded),
              title: Text('Add'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.favorite_outline),
              title: Text('Favorite'),
            ),
          ],
        )
    );
  }

}
