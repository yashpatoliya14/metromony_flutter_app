import 'dart:js_interop_unsafe';
import './standard.dart';

class User {
  List<Map<String, dynamic>> userList = [{
    FIRSTNAME: "John",
    LASTNAME: "Doe",
    EMAIL: "john.doe@example.com",
    MOBILE: "1234567890",
    DOB: "01/01/1996",
    HOBBIES: ["Reading", "Traveling"],
    CITY: "Rajkot",
    GENDER: "Male",
    PASSWORD: "P@assword123",
  },
    {
      FIRSTNAME: "John",
      LASTNAME: "Doe",
      EMAIL: "john.doe@example.com",
      MOBILE: "1234567890",
      DOB: "01/01/1998",
      HOBBIES: ["Reading", "Traveling"],
      CITY: "Rajkot",
      GENDER: "Male",
      PASSWORD: "P@assword123",
    },];

  void addUserInList({required map}) {
    print(map);
    Map<String, dynamic> user = {};
    user[FIRSTNAME] = map[FIRSTNAME];
    user[LASTNAME] = map[LASTNAME];
    user[EMAIL] = map[EMAIL];
    user[MOBILE] = map[MOBILE];
    user[DOB] = map[DOB];
    user[HOBBIES] = map[HOBBIES];
    user[CITY] = map[CITY];
    user[GENDER] = map[GENDER];
    user[PASSWORD] = map[PASSWORD];
    userList.add(user);
    print(userList);

  }

  List<Map<String, dynamic>> getUserList() {
    return userList;
  }

  void updateUser({required map,required id}) {
    Map<String, dynamic> user = {};
    user[FIRSTNAME] = map[FIRSTNAME];
    user[LASTNAME] = map[LASTNAME];
    user[EMAIL] = map[EMAIL];
    user[MOBILE] = map[MOBILE];
    user[DOB] = map[DOB];
    user[HOBBIES] = map[HOBBIES];
    user[CITY] = map[CITY];
    user[GENDER] = map[GENDER];
    user[PASSWORD] = map[PASSWORD];
    userList[id] = user;
  }

  void deleteUser({required id}) {
    userList.removeAt(id);
  }

  // void searchDeatil({required searchData}) {
  //   for (var element in userList) {
  //     if (element[NAME]
  //             .toString()
  //             .toLowerCase()
  //             .contains(searchData.toString().toLowerCase()) ||
  //         element[CITY]
  //             .toString()
  //             .toLowerCase()
  //             .contains(searchData.toString().toLowerCase()) ||
  //         element[EMAIL]
  //             .toString()
  //             .toLowerCase()
  //             .contains(searchData.toString().toLowerCase())) {
  //       printResultText(
  //           '${element[NAME]} . ${element[AGE]} . ${element[EMAIL]}');
  //     }
  //   }
  }

