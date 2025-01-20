import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './standard.dart';
class UserForm extends StatefulWidget {
  Map<String, dynamic>? userDetail;
  UserForm({super.key,Map<String, dynamic>? userDetail}){
    this.userDetail = userDetail;
  }
  @override
  State<UserForm> createState() => _UserformState();
}

class _UserformState extends State<UserForm> {

  final GlobalKey<FormState> _formkey = GlobalKey();

  int? _selectedRadio;
  String? _selectedCity;
  DateTime? selectedDate;
  bool isSelectedRadio = true;
  bool isSelectedCity = true;
  bool isSelectedHobbies = true;

  int findIndex(List<String> cities, selectedCity) {
    for (int i = 0; i < cities.length; i++) {
      if (selectedCity.toString().toLowerCase() ==
          cities[i].toString().toLowerCase()) {
        return i;
      }
    }
    return 0;
  }

  final List<Map<String, dynamic>> hobbiesData = [
    {"name": "Cricket", "isChecked": false},
    {"name": "Reading", "isChecked": false},
    {"name": "Watching", "isChecked": false},
    {"name": "Gaming", "isChecked": false},
    {"name": "Coding", "isChecked": false},
    {"name": "travelling", "isChecked": false},
  ];
  List<String> cities = ["Select your city","Rajkot","Ahemdabad"];
  List<String> gender = ["Male","Female"];

  //all controllers
  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController dob = TextEditingController();




  @override
  @override
  void initState() {
    super.initState();

    if (widget.userDetail != null) {
      firstname.text = widget.userDetail?['firstname'] ?? '';
      lastname.text = widget.userDetail?['lastname'] ?? '';
      email.text = widget.userDetail?['email'] ?? '';
      mobile.text = widget.userDetail?['mobile'] ?? '';
      password.text = widget.userDetail?['password'] ?? '';
      confirmPassword.text = widget.userDetail?['password'] ?? '';
      dob.text = widget.userDetail?['dob'] ?? '';
      _selectedRadio = widget.userDetail?['gender'] == "Male" ? 0 : 1;
      _selectedCity = widget.userDetail?['city'];

      List<String> selectedHobbies = List<String>.from(widget.userDetail?['hobbies'] ?? []);
      for (var hobby in hobbiesData) {
        if (selectedHobbies.contains(hobby['name'])) {
          hobby['isChecked'] = true;
        }
      }
    } else {
      _selectedCity = cities[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
          key: _formkey,
          child: Container(
            width: screenWidth,
            height: screenHeight,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    getTextFormField(controller: firstname, name: "Firstname", widthRatio: 0.4,validateFun: (value){
                      if(value==""){
                        return 'Enter Firstname ';
                      }
                      if (!RegExp(
                          r"^[a-zA-Z\s']{3,50}$")
                          .hasMatch(value)) {
                        return "Enter a valid first name (3-50 characters,alphabets only)";
                      }
                      return null;
                    }),
                    SizedBox(width: screenWidth*0.05,),
                    getTextFormField(controller: lastname, name: "Lastname", widthRatio: 0.4,validateFun: (value){
                      if(value==""){
                        return 'Enter Lastname ';
                      }
                      if (!RegExp(
                          r"^[a-zA-Z\s']{3,50}$")
                          .hasMatch(value)) {
                        return "Enter a valid Last name (3-50 characters,alphabets only)";
                      }
                      return null;
                    }),
                  ],
                ),
                getTextFormField(controller: email, name: "Email",widthRatio:0.9,validateFun: (value){
                  if(value==""){
                      return 'Enter Email Address';
                  }
                  if (!RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)) {
                    return 'Enter a valid email address.';
                  }
                  return null;
                }),
                getTextFormField(controller: mobile, name: "Mobile",widthRatio:0.9,validateFun: (value){
                  if(value==""){
                    return 'Enter Mobile Number';
                  }
                  if (!RegExp(
                      r'^\+?[0-9]{10,15}$')
                      .hasMatch(value)) {
                    return 'Enter a valid Mobile Number.';
                  }
                  return null;
                }),
                getTextFormField(controller: password, name: "Password", widthRatio: 0.9,validateFun: (value){
                  if(value==""){
                    return 'Enter Email Address';
                  }
                  if (!RegExp(r"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$")
                      .hasMatch(value)) {
                    return "Please Enter a Strong Password";
                  }
                  return null;
                }),
                getTextFormField(controller: confirmPassword, name: "Confirm Password", widthRatio: 0.9,validateFun: (value){
                  if(value.toString().isEmpty || password.text.isEmpty){
                    return 'Enter password';
                  }
                  if (password.text != confirmPassword.text){
                    return "Password doesn't match";
                  }
                  return null;
                }),

                //date of birth
                Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  child: TextFormField(
                    controller: dob,
                    validator: (value){
                        if(value!.length==0){
                            return "Select Your BirthDate";
                        }

                        DateTime today = DateTime.now();
                        int yearDifference = today.year - selectedDate!.year;

                        if (today.month < selectedDate!.month ||
                            (today.month == selectedDate!.month && today.day < selectedDate!.day)) {
                          yearDifference--;
                        }
                        if(yearDifference<18){
                          return "You must be at least 18 years old to register.";
                        }
                        if(yearDifference>80){
                          return "You must be at most 80 years old to register.";
                        }
                        return null;

                    },
                    readOnly: true, // Prevent manual input
                    decoration: InputDecoration(
                    label: Text("Date of Birth"),
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                    suffixIcon: Icon(Icons.calendar_today), // Add calendar icon
                  ),
                  onTap: () async {
                // Open date picker
                      selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900), // Start date range
                      lastDate: DateTime.now(),  // End date range
                    );
                    if (selectedDate != null) {
                      setState(() {
                        dob.text = "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
                      });
                    }
                  },
                ),
                ),

                //select gender
                Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Gender :"),
                          getRadioButton(index: 0),
                          Text(gender[0]),
                          getRadioButton( index: 1),
                          Text(gender[1]),

                        ],
                      ),
                      getRadioButtonError()
                    ],
                  ),

                ),

                //select city
                Container(
                  width: screenWidth*0.9,
                  margin: EdgeInsets.all(screenWidth*0.025),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Background color
                    border: Border.all(color: Colors.grey), // Border color
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                  ),
                  child: DropdownButton<String>(
                    value: _selectedCity,
                    isExpanded: true,

                    underline: SizedBox(), // Remove default underline
                    items: cities.map((city) {
                      return DropdownMenuItem(
                        value: city,
                        child: Text(city),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCity = value!;
                      });
                    },
                  ),
                ),
                getCityError(),
                Container(
                  width: screenWidth*0.9,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),
                  child: Column(

                    children: [
                      Row(
                        children: [
                          Text("Hobby : "),
                        ],
                      ),
                      Row(
                        children: [

                          getCheckbox(map: hobbiesData[0]),
                          Text(hobbiesData[0]["name"]),

                          getCheckbox(map: hobbiesData[1]),
                          Text(hobbiesData[1]["name"]),

                          getCheckbox(map: hobbiesData[2]),
                          Text(hobbiesData[2]["name"]),
                        ],
                      ),
                      Row(
                        children: [
                          getCheckbox(map: hobbiesData[3]),
                          Text(hobbiesData[3]["name"]),

                          getCheckbox(map: hobbiesData[4]),
                          Text(hobbiesData[4]["name"]),

                          getCheckbox(map: hobbiesData[5]),
                          Text(hobbiesData[5]["name"]),
                        ],
                      ),
                      Row(
                        children: [
                          getHobbiesError(),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: screenWidth * 0.9,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formkey.currentState?.validate() ?? true) {
                        if (_selectedRadio == null) {
                          setState(() => isSelectedRadio = false);
                          return;
                        }

                        if (_selectedCity == null ||
                            _selectedCity == cities[0]) {
                          setState(() => isSelectedCity = false);
                          return;
                        }

                        final selectedHobbies = hobbiesData
                            .where((hobby) => hobby["isChecked"] == true)
                            .map((hobby) => hobby["name"] as String)
                            .toList();
                        if (selectedHobbies.isEmpty) {
                          setState(() => isSelectedHobbies = false);
                          return;
                        }

                        final data = {
                          "firstname": firstname.text,
                          "lastname": lastname.text,
                          "email": email.text,
                          "mobile": mobile.text,
                          "password": password.text,
                          "dob": dob.text,
                          "gender": gender[_selectedRadio!],
                          "city": _selectedCity,
                          "hobbies": selectedHobbies,
                        };

                        Navigator.pop(context, data);
                      };
                    },child: Text("Save"),
                  ),
                )

              ],
            ),
          )),
            ),
    );
  }

  Widget getRadioButton({index}){
    return Radio(
        value: index, groupValue: _selectedRadio, onChanged: (value){
      setState(() {
        _selectedRadio = value!;
      });
    });
  }

  Widget getTextFormField({required TextEditingController controller, required String name, required double widthRatio,required validateFun}) {
    return Container(
    width: MediaQuery.of(context).size.width*widthRatio,
        margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.025),
        child: TextFormField(
        controller: controller,
        validator: validateFun,
        decoration: InputDecoration(
        label: Text(name),
        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
        ),
        ),
        );
  }

  Widget getCheckbox({required map}){

    return Checkbox(
      isError: false,
      tristate: false,
      value: map["isChecked"],

      onChanged: (bool? value) {
        setState(() {
          map["isChecked"]= value!;
        });
      },
    );

  }

  Widget getRadioButtonError(){
    if(isSelectedRadio==false){
      return Text("Please select your gender.",style: TextStyle(color: Colors.redAccent),);
    }
    return SizedBox.shrink();
  }

  Widget getCityError(){
    if(isSelectedCity==false){
      return Container(

        margin: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * 0.025),
        child: Text("Please select your city",style: TextStyle(color: Colors.redAccent),),
      );
    }
    return SizedBox.shrink();
  }
  Widget getHobbiesError(){
    if(isSelectedHobbies==false){
      return Container(

        child: Text("Please select your hobbies",style: TextStyle(color: Colors.redAccent),),
      );
    }
    return SizedBox.shrink();
  }
}
