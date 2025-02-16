import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metromony/User_Display/user_detail.dart';
import 'package:metromony/Userform/user_form.dart';
import 'package:metromony/Utils/standard.dart';
import '../Utils/crud_operation.dart';

class Favoritelist extends StatefulWidget {

  Favoritelist({super.key});

  @override
  State<Favoritelist> createState() => _UserListState();
}

class _UserListState extends State<Favoritelist> {
  User user = User();

  // List<Map<String, dynamic>> searchList = [];
  // TextEditingController search = TextEditingController();

  List<Map<String, dynamic>> userList=[];
  List<Map<String, dynamic>> favoriteList=[];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Map<String, dynamic>>> _getUserData() async {
    userList = await user.getUserList();

    favoriteList.clear();

    userList.forEach((user) {
      if (user[ISFAVORITE] == 1) {
        favoriteList.add(user);
      }
    });

    return favoriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        //temp search
        Padding(
          padding: const EdgeInsets.all(8.0),
          // child: isSearchBarHide(),
        ),

        //list of favorite users
        Expanded(

          child: FutureBuilder<List<Map<String, dynamic>>>(future: _getUserData(), builder: (context,snapshot){

            if(snapshot.hasData){
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return getListItem(index);
                },
                itemCount: favoriteList.length,
              );
            }else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
          }),

        )
      ],
    );
  }

  Widget getListItem(int index) {
    final currentList = favoriteList ;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),

      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetail(data: favoriteList[index])));
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

                      //fullname
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              currentList[index][FULLNAME],
                              style: GoogleFonts.nunito(
                              fontSize: 20, color: Colors.teal.shade400),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios, color: Colors.teal),
                        ],
                      ),

                      const SizedBox(height: 5),

                      //city
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

                      //email
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

                      //buttons favorite
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                            height: 25,
                            child: IconButton(
                              onPressed: () async {
                                Map<String, dynamic> updatedUser = Map<String, dynamic>.from(favoriteList[index]);
                                updatedUser[ISFAVORITE] = updatedUser[ISFAVORITE] == 0 ? 1 : 0;

                                setState(() {
                                  favoriteList[index] = updatedUser;
                                });

                                await user.updateUser(
                                  map: updatedUser,
                                  id: updatedUser['UserId'],
                                );

                              },

                              icon: Icon(
                                favoriteList[index][ISFAVORITE] == 1
                                    ? Icons.favorite
                                    : Icons.favorite_outline,
                                size: 20,
                                color: favoriteList[index][ISFAVORITE] == 1 ? Colors.red : Colors.teal,
                              ),
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                              ),
                            ),
                          ),
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

  // Widget isSearchBarHide() {
  //   if () {
  //     return Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Container(
  //           width: MediaQuery.of(context).size.width * 0.95,
  //           child: TextFormField(
  //             controller: search,
  //             decoration: InputDecoration(
  //               hintText: "search",
  //               suffixIcon: IconButton(
  //                 onPressed: () {
  //                   setState(() {
  //                     // searchBarState = false;
  //                   });
  //                 },
  //                 icon: const Icon(Icons.close),
  //               ),
  //             ),
  //             onChanged: (value) {
  //               setState(() {
  //                 // searchList = searchDetail(searchData: value) ?? [];
  //               });
  //             },
  //           ),
  //         ),
  //       ],
  //     );
  //   } else {
  //     return const SizedBox.shrink();
  //   }
  // }
}

