import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metromony/Crud.dart';
import 'package:metromony/UserForm.dart';
import 'package:metromony/UserList.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  User _user = User();
  void navigateToForm() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => UserForm())
    ).then((value) {
      if (value != null) { // Check if the value is valid
        _user.addUserInList(map: value); // Adding the new user to the list
        setState(() { // Triggering setState to rebuild the widget tree
          pages[0] = UserList(user: _user);
        });
      }
    });
  }



  late List<Widget> pages; // Make pages a List<Widget>

  @override
  void initState() {
    super.initState();
    pages = [
      UserList(user: _user,),
      Container(), // Placeholder to avoid index issues
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matrimonial",
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
        backgroundColor: Colors.red,
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          if (index == 1) {
            navigateToForm();
          } else {
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person_add_rounded), label: "Add"),
        ],
      ),
    );
  }

}
