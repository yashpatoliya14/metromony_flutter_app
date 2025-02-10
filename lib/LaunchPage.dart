import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metromony/Home.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  void initState(){
    super.initState();

    Future.delayed(Duration(seconds:3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: screenWidth,
        padding: EdgeInsets.symmetric(horizontal: screenWidth*0.05,vertical: screenHeight*0.4),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(color: Colors.teal),
              top: BorderSide(color: Colors.teal),
              left: BorderSide(color: Colors.teal,style: BorderStyle.solid),
              right: BorderSide(color: Colors.teal),

            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text("Welcome ",style: GoogleFonts.cinzel(fontWeight:FontWeight.w200,color: Colors.teal,fontSize: 30),textAlign: TextAlign.center,)),
              Center(child: Text("Metromony",style: GoogleFonts.poppins(fontWeight: FontWeight.w400,fontSize: 20 ),))
            ],
          ),
        ),
      ),
    );
  }
}
