import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class AboutPage extends StatefulWidget {
   AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
          "About Us",
          style: GoogleFonts.nunito(
            color: Colors.black54,
            fontWeight: FontWeight.w700,
            fontSize: 25,
          ),
        ),
      ) ,
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle("Developed By"),
              _buildInfoRow("Yash Patoliya"),

              _buildSectionTitle("Mentored By"),
              _buildInfoRow("Prof. Mehul Bhundiya"),

              _buildSectionTitle("Explored By"),
              _buildInfoRow("AWSDC , Computer Science Engineering"),

              _buildSectionTitle("Eulogized By"),
              _buildInfoRow("Darshan University"),

              const Divider(thickness: 1, height: 30, color: Colors.black54),

              _buildSectionTitle("Contact Us"),
              _buildInfoRow("📧 Email: ", "yashpatoliya14@gmail.com"),
              _buildInfoRow("📞 Phone: ", "+91 70433 33359"),

              const Spacer(),

              // Share Button
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Share.share(
                      "Check out this amazing app!\nDownload now: https://playstore.com/yourapp",
                    );
                  },
                  icon:  Icon(Icons.share),
                  label:  Text("Share the App"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    padding:  EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📌 Helper Widget for Section Titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
    );
  }

  // 📌 Helper Widget for Info Rows
  Widget _buildInfoRow(String label, [String? value]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
          if (value != null)
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black54),
            ),
        ],
      ),
    );
  }
}
