import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './importFiles.dart'; // Ensure this file defines your constants like FULLNAME, EMAIL, MOBILE, CITY, DOB, HOBBY, etc.

class UserDetail extends StatefulWidget {
  final Map<String, dynamic> data;
  const UserDetail({Key? key, required this.data}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  User user = User();
  List<String> hobbies= [];
  Future<List<String>> _getUserHobbies() async {
      return await user.getUserHobbies(userId: widget.data['UserId']);
  }
  @override
  void initState(){
    super.initState();
    _getUserHobbies().then((value){
      hobbies = value;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal.shade500,
                Colors.teal.shade700,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              "Matrimony",
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 28,
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal.shade100,
                backgroundImage: widget.data['profilePicture'] != null
                    ? NetworkImage(widget.data['profilePicture'])
                    : null,
                child: widget.data['profilePicture'] == null
                    ? Icon(Icons.person, size: 60, color: Colors.white)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            // User Details Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [

                    // Full Name
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.person, color: Colors.teal.shade700),
                      title: Text(
                        "Name",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[FULLNAME] ?? widget.data['name'] ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Email
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.email, color: Colors.teal.shade700),
                      title: Text(
                        "Email",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[EMAIL] ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Mobile
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.phone, color: Colors.teal.shade700),
                      title: Text(
                        "Mobile",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[MOBILE]?.toString() ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // City
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.location_city, color: Colors.teal.shade700),
                      title: Text(
                        "City",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[CITY] ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Date of Birth
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.cake, color: Colors.teal.shade700),
                      title: Text(
                        "Date of Birth",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[DOB] ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Gender
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(widget.data[GENDER]=='Male'? Icons.male:Icons.female, color: Colors.teal.shade700),
                      title: Text(
                        "Gender",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        widget.data[GENDER] ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),
                    const Divider(),

                    // Hobbies
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.sports, color: Colors.teal.shade700),
                      title: Text(
                        "Hobbies",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.w600,
                          color: Colors.teal.shade700,
                        ),
                      ),
                      subtitle: Text(
                        hobbies.toString() ?? 'N/A',
                        style: GoogleFonts.nunito(fontSize: 16),
                      ),
                    ),


                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
