import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metromony/Userform/user_form.dart';
import 'package:metromony/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/crud_operation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? ishidePass = true;
  String? mobileError;
  String? passwordError;
  final _formKey = GlobalKey<FormState>();

    User _user = User();
    Future<void> _login() async {
      if (_formKey.currentState!.validate()) {
        final String phone = mobileController.text.trim();
        final String password = passwordController.text.trim();

        Map<String , dynamic>? val = await _user.getUserForLogin(mobile: phone, password: password);

        if(val!=null){
          SharedPreferences s = await SharedPreferences.getInstance();
          s.setBool('isLogin', true);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
        }else{
          showDialog(context: context, builder: (context){
            return CupertinoAlertDialog(
              title: Text("User not exists.",style: TextStyle(color: Colors.green),),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text('Done',style: GoogleFonts.nunito(),),
                ),
              ],
            );
          });
        }
      }
    }

  @override
  void dispose() {
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  final List<Color> appBarGradientColors = [Colors.red, Colors.deepOrange.shade300];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Matrimony Login",
          style: GoogleFonts.nunito(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade50, Colors.deepOrange.shade50],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Phone Number Field
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                    child: TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile',
                        errorText: mobileError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
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
                  const SizedBox(height: 8.0),
                  // Password Field
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: passwordError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Colors.white,
                        filled: true,
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

                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>UserForm(isAppBar: true,)));
                  }, child: Text("Register")),
                  const SizedBox(height: 8.0),

                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    child:  Text('Login',style: GoogleFonts.nunito(fontSize: 16, color: Colors.white),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

}
