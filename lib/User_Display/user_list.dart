import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metromony/User_Display/user_detail.dart';
import 'package:metromony/Userform/user_form.dart';
import 'package:metromony/Utils/standard.dart';
import '../Utils/crud_operation.dart';

class UserList extends StatefulWidget {
  final User user = User();
  bool search;
  UserList({super.key,required this.search});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<Map<String, dynamic>> searchList = [];
  List<Map<String, dynamic>> userList = [];
  TextEditingController searchController = TextEditingController();
  List<double> _scaleFactors = [];
  @override
  void initState() {
    super.initState();
  }
  Future<List<Map<String, dynamic>>> _getUserData() async {
    userList =  await widget.user.getUserList();
    return userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: isSearchBarHide(),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _getUserData(),
              builder: (context, snapshot) {
                 if (snapshot.hasData) {
                  _scaleFactors = List.filled(userList.length, 1.0);
                  return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return getListItem(index);
                    },
                    itemCount: searchController.text.isEmpty
                        ? userList.length
                        : searchList.length,
                  );
                } else {
                  return Center(child: Text('No users found'));
                 }
              },
            ),
          )
        ],
      )
    );
  }

  Widget getListItem(int index) {
    final currentList = searchController.text.isEmpty ? userList : searchList;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: () {

          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => UserDetail(data: userList[index]),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
            ),
          );

        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.20,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.red.shade50, Colors.deepOrange.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: const Icon(
                    Icons.person,
                    size: 35,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(

                              currentList[index][FULLNAME],
                              style: GoogleFonts.nunito(
                                  fontSize: 20, color:Colors.deepOrange.shade300),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
                        ],
                      ),
                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(Icons.location_city_outlined, size: 20),
                          const SizedBox(width: 10),
                          Text(
                            currentList[index][CITY],
                            style: const TextStyle(color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(Icons.email_outlined, size: 20),
                          const SizedBox(width: 10),
                          Container(
                            width: 175, // Adjust this width as needed
                            child: Text(
                              currentList[index][EMAIL],
                              style: const TextStyle(color: Colors.black54),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: IconButton(
                              onPressed: () async {
                                Map<String, dynamic> updatedUser = Map<String, dynamic>.from(searchController.text.isEmpty ? userList[index] : searchList[index]);

                                updatedUser[ISFAVORITE] = updatedUser[ISFAVORITE] == 0 ? 1 : 0;


                                setState(() {
                                  searchController.text.isEmpty ? userList : searchList = searchController.text.isEmpty ? userList.toList() : searchList.toList();
                                  searchController.text.isEmpty ? userList[index] : searchList[index] = updatedUser;
                                });
                                await widget.user.updateUser(
                                  map: updatedUser,
                                  id: updatedUser['UserId'],
                                );
                              },


                              icon: Icon((searchController.text.isEmpty ? userList[index][ISFAVORITE] : searchList[index][ISFAVORITE])==1? Icons.favorite : Icons.favorite_outline,
                                  size: 20, color: (searchController.text.isEmpty ? userList[index][ISFAVORITE] : searchList[index][ISFAVORITE])==1 ? Colors.red : Colors.deepOrange),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 65,
                            height: 25,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation, secondaryAnimation) => UserForm(userDetail: searchController.text.isEmpty ? userList[index] : searchList[index],isAppBar: true,),
                                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                ).then((value){
                                    setState(() {});
                                });
                              },
                              icon: const Icon(Icons.edit,
                                  size: 15, color: Colors.white),
                              label: Text(
                                "Edit",
                                style: GoogleFonts.nunito(
                                    fontSize: 12, color: Colors.white),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.deepOrange.shade500),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: 70,
                            height: 25,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('DELETE',style: GoogleFonts.nunito(color: Colors.red.shade500),),
                                      content: Text('Are you sure want to delete?',style: GoogleFonts.nunito(),),
                                      actions: [
                                        TextButton(
                                          onPressed: () async {
                                            await widget.user.deleteUser(id: userList[index]['UserId']); // Assuming 'id' is the identifier
                                            Navigator.pop(context);
                                            setState(() {}); // Refresh the list after deletion
                                          },
                                          child: Text('Yes',style: GoogleFonts.nunito(),),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('No',style: GoogleFonts.nunito()),
                                        )
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete,
                                  size: 15, color: Colors.red),
                              label: Text(
                                "Delete",
                                style: GoogleFonts.nunito(
                                    fontSize: 12, color: Colors.red),
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget isSearchBarHide() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300), // Smooth animation duration
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            // axisAlignment: -1.0,
            child: child,
          ),
        );
      },
      child: widget.search
          ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.07,
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade100,
                filled: true,
                hintText: "Search",
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      widget.search = false;
                    });
                  },
                  icon: const Icon(Icons.close),
                ),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
              ),
              onChanged: (value) {
                String searchData = value.toLowerCase();
                setState(() {
                  searchList = userList.where((user) {
                    return user[FULLNAME].toString().toLowerCase().contains(searchData) ||
                        user[CITY].toString().toLowerCase().contains(searchData) ||
                        user[EMAIL].toString().toLowerCase().contains(searchData) ||
                        user[MOBILE].toString().toLowerCase().contains(searchData) ||
                        user[AGE].toString().toLowerCase().contains(searchData);
                  }).toList();
                });
              },
            ),
          ),
        ],
      )
          : const SizedBox.shrink(),
    );
  }


  PreferredSizeWidget? getAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
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
              )),
          centerTitle: true,
          title: Text(
            "Matrimony",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.search = true;
                    });
                  },
                  icon: Icon(Icons.search_outlined, color: Colors.white),
                  iconSize: 25,
                ))
          ],
        ),
      ),
    );
  }


}