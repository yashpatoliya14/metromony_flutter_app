import 'package:flutter/cupertino.dart';

import 'importFiles.dart';
import 'package:intl/intl.dart';
class UserForm extends StatefulWidget {
  Map<String, dynamic>? userDetail;
  UserForm({super.key, Map<String, dynamic>? userDetail}) {
    this.userDetail = userDetail;
  }
  @override
  State<UserForm> createState() => _UserformState();
}

class _UserformState extends State<UserForm> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  //hobbies List
  final List<Map<String, dynamic>> hobbiesData = [
    {"name": "Cricket", "isChecked": false},
    {"name": "Reading", "isChecked": false},
    {"name": "Watching", "isChecked": false},
    {"name": "Gaming", "isChecked": false},
    {"name": "Coding", "isChecked": false},
    {"name": "travelling", "isChecked": false},
  ];

  //cities list
  List<String> cities = [
    "Select your city",
    "Rajkot",
    "Ahemdabad",
    "Vadodara",
    "Surat",
    "Delhi",
    "Mumbai",
    "Jaipur",
    "banglore",
    "hydrabad",
    "kolakata"
  ];

  User user = User();
  bool? ishidePass = true;
  bool? ishideConfirm = true;

  //select variables
  int? _selectedRadio;
  String? _selectedCity;
  DateTime? selectedDate = DateTime.now();
  bool isSelectedRadio = true;
  bool isSelectedCity = true;
  bool isSelectedHobbies = true;
  List<String>? selectedHobbies;
  bool isAppBar = true;

  //errors variables
  String? firstNameError;
  String? emailError;
  String? mobileError;
  String? passwordError;
  String? confirmPasswordError;
  String? dobError;
  String? cityError;
  String? hobbiesError;
  String? genderError;


  //gender list
  List<String> gender = ["Male", "Female"];
  int? isFavorite;

  //all controllers
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  //get userHobbies when user editable mode
  Future<List<String>> _getUserHobbies() async {
    if (widget.userDetail != null) {
      return await user.getUserHobbies(userId: widget.userDetail!['UserId']);
    }
    return [];
  }

  @override
  void initState() {
    super.initState();

    //if user editable mode then assign values to the controller text
    if (widget.userDetail != null) {

      firstnameController.text = widget.userDetail?[FULLNAME] ?? '';
      emailController.text = widget.userDetail?[EMAIL] ?? '';
      mobileController.text = widget.userDetail?[MOBILE].toString() ?? '';
      passwordController.text = widget.userDetail?[PASSWORD] ?? '';
      confirmPasswordController.text = widget.userDetail?[PASSWORD] ?? '';
      dobController.text = widget.userDetail?[DOB] ?? '';
      _selectedRadio = widget.userDetail?[GENDER] == "Male" ? 0 : 1;
      _selectedCity = widget.userDetail?[CITY] ?? cities[0];
      List<String> db = widget.userDetail?[DOB].split("/");
      selectedDate = DateTime(
          int.parse(db[2]),
          int.parse(db[1]),
          int.parse(db[0])
      );
      _getUserHobbies().then((fetchedHobbies) {
        print("Fetched hobbies: $fetchedHobbies");
        setState(() {
          selectedHobbies = fetchedHobbies;
          for (var hobby in hobbiesData) {
            hobby["isChecked"] = selectedHobbies!.contains(hobby["name"]);
            print("Hobby ${hobby["name"]} isChecked: ${hobby["isChecked"]}");
          }
        });
      });


      isFavorite = widget.userDetail![ISFAVORITE];

    } else {
      _selectedCity = cities[0];
    }

  }



  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: PreferredSize(preferredSize:Size.fromHeight(isAppBar ? MediaQuery.of(context).size.height*0.08 : 0),child: getAppBar()),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade50, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,

            child: Container(
              width: screenWidth,
              height: screenHeight,

              child: ListView(

                children: [

                  //fullname
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: firstnameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        errorText: firstNameError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.person),
                      ),
                      textCapitalization: TextCapitalization.words,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s']"))
                      ],
                      validator: (value) {
                        return validateFirstName(value);
                      },
                      onChanged: (value) {
                        setState(() {
                          firstNameError = validateFirstName(value);
                        });
                      },
                    ),
                  ),

                  //Email
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: emailError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.email),
                      ),
                      onChanged: (value) {
                        setState(() {
                          emailError = validateEmail(value);
                        });
                      },
                      validator: (value) {
                        return validateEmail(value);
                      },
                    ),
                  ),

                  //mobile
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        errorText: mobileError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.phone_iphone_outlined),
                      ),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      onChanged: (value) {
                        setState(() {
                          mobileError = validateMobile(value);
                        });
                      },
                      validator: (value) {
                        return validateMobile(value);
                      },
                    ),
                  ),

                  //password
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: passwordError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(onPressed: (){
                          setState(() {
                            ishidePass=!ishidePass!;
                          });
                        }, icon: ishidePass!?Icon( Icons.remove_red_eye):Icon( Icons.visibility_off))
                      ),
                      obscureText: ishidePass!,
                      onChanged: (value) {
                        setState(() {
                          passwordError = validatePassword(value);
                        });
                      },
                      validator: (value) {
                        return validatePassword(value);
                      },
                    ),
                  ),

                  //confirm password
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        errorText: confirmPasswordError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.password_outlined),
                        suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              ishideConfirm=!ishideConfirm!;
                            });
                        }, icon: ishideConfirm!?Icon( Icons.remove_red_eye):Icon( Icons.visibility_off))

                      ),
                      obscureText: ishideConfirm!,
                      onChanged: (value) {
                        setState(() {
                          confirmPasswordError =
                              validateConfirmPassword(value);
                        });
                      },
                      validator: (value) {
                        return validateConfirmPassword(value);
                      },
                    ),
                  ),

                  //date of birth
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    child: TextFormField(
                      controller: dobController,
                      readOnly: true, // Prevent manual input
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        errorText: dobError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        prefixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDate!,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );

                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                            dobController.text = DateFormat("dd-MM-yyyy").format(selectedDate!); // Change format here
                            dobError = validateDOB(dobController.text);
                          });
                        }
                      },
                      validator: (value) {
                        return validateDOB(value);
                      },
                    ),
                  ),

                  //select gender
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Select Gender",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Custom "Male" toggle
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedRadio = 0;
                                  genderError = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: _selectedRadio == 0 ? Colors.teal : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.teal),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.male,
                                      color: _selectedRadio == 0 ? Colors.white : Colors.teal,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Male",
                                      style: TextStyle(
                                        color: _selectedRadio == 0 ? Colors.white : Colors.teal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedRadio = 1;
                                  genderError = null;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                                decoration: BoxDecoration(
                                  color: _selectedRadio == 1 ? Colors.teal : Colors.white,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.teal),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.female,
                                      color: _selectedRadio == 1 ? Colors.white : Colors.teal,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      "Female",
                                      style: TextStyle(
                                        color: _selectedRadio == 1 ? Colors.white : Colors.teal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (genderError != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              genderError!,
                              style: TextStyle(color: Colors.redAccent, fontSize: 12),
                            ),
                          )
                      ],
                    ),
                  ),


                  //select city
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0), // Softer corners
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(2, 2), // Subtle shadow
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedCity,
                      decoration: InputDecoration(
                        border: InputBorder.none, // Removes the default border
                        contentPadding: EdgeInsets.zero,
                      ),
                      isExpanded: true,
                      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.teal), // Stylish dropdown icon
                      dropdownColor: Colors.white,
                      items: cities.map((city) {
                        return DropdownMenuItem(
                          value: city,
                          child: Text(
                            city,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCity = value!;
                          cityError = validateCity(_selectedCity);
                        });
                      },
                      validator: (value) => value == null ? "Please select a city" : null, // Validation
                    ),
                  ),

                  getCityError(),

                  //Hobbies
                Container(
                  width: screenWidth*0.9,
                  margin: EdgeInsets.all(screenWidth*0.025),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hobbies:", style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),),
                      Wrap(
                        spacing: 10,
                        children: hobbiesData.map((hobby) {
                          return FilterChip(
                            label: Text(hobby["name"]),
                            selected: hobby["isChecked"],
                            selectedColor: Colors.teal.shade100,
                            onSelected: (bool selected) {
                              setState(() {
                                hobby["isChecked"] = selected;
                                hobbiesError = validateHobbies();
                              });
                            },
                          );
                        }).toList(),
                      ),
                      if (hobbiesError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(hobbiesError!,
                              style:
                              TextStyle(color: Colors.redAccent, fontSize: 12)),
                        ),
                    ],
                  ),
                ),

                  //save button
                  Container(
                    width: screenWidth * 0.9,
                    margin: EdgeInsets.all(screenWidth * 0.025),

                    child: ElevatedButton(
                      style: ButtonStyle(

                      ),
                      onPressed: () {

                        if (_formkey.currentState?.validate() ?? false) {

                          //gender error
                          if (_selectedRadio == null) {
                            setState(() => genderError = "Please select your gender.");
                            return;
                          }
                          else {
                            setState(() => genderError = null);
                          }

                          //city error
                          if (_selectedCity == null || _selectedCity == cities[0]) {
                            setState(() => cityError = "Please select your city");
                            return;
                          }
                          else {
                            setState(() => cityError = null);
                          }

                          //hobby error
                          final selectedHobbies = hobbiesData
                              .where((hobby) => hobby["isChecked"] == true)
                              .map((hobby) => hobby["name"] as String)
                              .toList();

                          if (selectedHobbies.isEmpty) {
                            setState(() => hobbiesError = "Please select your hobbies");
                            return;
                          }
                          else {
                            setState(() => hobbiesError = null);
                          }

                          //all errors is null then ..
                          if (firstNameError == null &&
                              emailError == null &&
                              mobileError == null &&
                              passwordError == null &&
                              confirmPasswordError == null &&
                              dobError == null &&
                              cityError == null &&
                              hobbiesError == null &&
                              genderError == null) {


                            //final data
                            final data = {
                              FULLNAME: firstnameController.text,
                              EMAIL: emailController.text,
                              MOBILE: mobileController.text,
                              PASSWORD: passwordController.text,
                              DOB: dobController.text,
                              GENDER: gender[_selectedRadio!],
                              CITY: _selectedCity,
                              HOBBY: selectedHobbies,
                              ISFAVORITE: isFavorite
                            };

                            if (widget.userDetail != null) {

                              user.updateUser(map: data, id: widget.userDetail!['UserId']);
                              showDialog(context: context, builder: (context){
                                return CupertinoAlertDialog(
                                    title: Text("Edit Successful !",style: TextStyle(color: Colors.green),),
                                    actions: [
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context,data);
                                        },
                                        child: Text('Done',style: GoogleFonts.nunito(),),
                                      ),
                                    ],
                                );
                              }).then((value){
                                Navigator.pop(context,data);

                              });

                            }
                            else {

                              user.addUser(map: data);
                              showDialog(context: context, builder: (context){
                                return CupertinoAlertDialog(
                                  title: Text("Add Successful !",style: TextStyle(color: Colors.green),),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(context,data);
                                      },
                                      child: Text('Done',style: GoogleFonts.nunito(),),
                                    ),
                                  ],
                                );
                              }).then((value){
                                Navigator.pop(context,data);

                              });

                            }
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fix the errors in the form')),
                            );
                          }

                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please fill all required fields')),
                          );
                        }
                      },

                      child: Text("Save"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //all functions

  Widget getRadioButton({index}) {
    return Radio(
        value: index,
        groupValue: _selectedRadio,
        onChanged: (value) {
          setState(() {
            _selectedRadio = value!;
            genderError = null; // Clear gender error when radio is selected
          });
        });
  }

  Widget getCheckbox({required map}) {
    return Checkbox(
      isError: false,
      tristate: false,
      value: map["isChecked"],
      onChanged: (bool? value) {
        setState(() {
          map["isChecked"] = value!;
          hobbiesError = validateHobbies(); // Validate hobbies on checkbox change
        });
      },
    );
  }

  Widget getAppBar(){
    if(widget.userDetail!=null){
      isAppBar = true;
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

                      // GlobalData.searchBarState = true;
                      // pages[0] = UserList();
                    });
                  }, icon: Icon(Icons.search_outlined,color: Colors.white),iconSize: 25,)
              )
            ],
          ),
        ),
      );
    }else{
      isAppBar = false;
      return SizedBox.shrink();
    }
  }

  Widget getRadioButtonError() {
    if (genderError != null) {
      return Text(
        genderError!,
        style: TextStyle(color: Colors.redAccent),
      );
    }
    return SizedBox.shrink();
  }

  Widget getCityError() {
    if (cityError != null) {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025),
        child: Text(
          cityError!,
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    }
    return SizedBox.shrink();
  }

  Widget getHobbiesError() {
    if (hobbiesError != null) {
      return Container(
        child: Text(
          hobbiesError!,
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    }
    return SizedBox.shrink();
  }

  String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Your Full Name';
    }
    if (!RegExp(r"^[a-zA-Z\s']{3,50}$").hasMatch(value)) {
      return "Enter a valid first name (3-50 characters, alphabets only)";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Email Address';
    }
    if (!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value)) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Mobile Number';
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'Enter a valid Mobile Number.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Password';
    }
    if (!RegExp(r"(?=^.{8,}$)((?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$")
        .hasMatch(value)) {
      return "Please Enter a Strong Password";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Confirm Password';
    }
    if (passwordController.text != confirmPasswordController.text) {
      return "Passwords do not match";
    }
    return null;
  }

  String? validateDOB(String? value) {
    if (value == null || value.isEmpty) {
      return "Select Your BirthDate";
    }

    DateTime today = DateTime.now();
    int yearDifference = today.year - selectedDate!.year;

    if (today.month < selectedDate!.month ||
        (today.month == selectedDate!.month && today.day < selectedDate!.day)) {
      yearDifference--;
    }
    if (yearDifference < 18) {
      return "You must be at least 18 years old to register.";
    }
    if (yearDifference > 80) {
      return "You must be at most 80 years old to register.";
    }
    return null;
  }

  String? validateCity(String? value) {
    if (value == null || value == cities[0]) {
      return "Please select your city";
    }
    return null;
  }

  String? validateHobbies() {
    final selectedHobbies = hobbiesData
        .where((hobby) => hobby["isChecked"] == true)
        .map((hobby) => hobby["name"] as String)
        .toList();
    if (selectedHobbies.isEmpty) {
      return "Please select your hobbies";
    }
    return null;
  }
}