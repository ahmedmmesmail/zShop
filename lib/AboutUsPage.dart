import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zShop/models/TeamMember.dart';

class AboutUsPage extends StatelessWidget {
  AboutUsPage({super.key});

  final List<TeamMember> members = [
    TeamMember(name: 'Ahmed Mohamed Mohamed Esmail', Class: "14", id: 12500562),
    TeamMember(name: 'Mohamed Mansour Mohamed', Class: "8", id: 12500223),
    TeamMember(name: 'Mohamed Adel Khamis', Class: "8", id: 12500299),
    TeamMember(name: 'Sarah Salah Abd el-latiff', Class: "16", id: 12500539),
    TeamMember(name: 'Salma Mansour Mohamed Soliman', Class: "11", id: 12500020,)
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About us',
          style: GoogleFonts.poppins(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFDE5E5E),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Text(
                        "Class: ${member.Class}",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      const Spacer(),
                      Text(
                        "ID: ${member.id}",
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
