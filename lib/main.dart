import 'package:causekey/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/animation.dart'; // Import for animation

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MatchedScreen(),
    );
  }
}

class MatchedScreen extends StatelessWidget {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: SafeArea(
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Container(
              padding: EdgeInsets.only(top: 10),
              child: IconButton(
                icon: Icon(
                  Icons.menu,
                ),
                onPressed: () {},
              ),
            ),
            title: Container(
              height: 60,
              padding: EdgeInsets.only(top: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.josefinSans(),
                  prefixIcon: Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: Colors.blueGrey.shade50,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            height: 40,
          ),
          _buildMatchedProfilesSection(context),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 8, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Chats ',
                  style: GoogleFonts.josefinSans(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(1)',
                  style: GoogleFonts.josefinSans(fontSize: 24),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildChatListTile(context),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMatchedProfilesSection(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarRadius = screenWidth * 0.1; // Radius based on screen width

    return Padding(
      padding: const EdgeInsets.only(top: 5.0, left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Matches ',
                style: GoogleFonts.josefinSans(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '(7)',
                style: GoogleFonts.josefinSans(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: avatarRadius * 3, // Dynamic height based on avatar size
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildProfileCircle(
                    'Maria White', 'assets/9.png', avatarRadius),
                _buildProfileCircle(
                    'Anna Fernandez', 'assets/10.png', avatarRadius),
                _buildProfileCircle(
                    'Jennifer Brown', 'assets/11.png', avatarRadius),
                _buildProfileCircle(
                    'Charlotte Evans', 'assets/12.png', avatarRadius),
                _buildProfileCircle('Ava Jones', 'assets/54.png', avatarRadius),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCircle(String name, String imagePath, double radius) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          duration: Duration(milliseconds: 200),
          scale: _isHovered ? 1.2 : 1.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  color: Colors.white,
                  width: radius,
                  height: radius,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset(
                        imagePath,
                        width: radius,
                        height: radius,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(name, style: GoogleFonts.josefinSans(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatListTile(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatScreen()),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/54.png'),
            radius: 25,
          ),
          title: Text(
            'Ava Jones',
            style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Chat now!',
            style: GoogleFonts.josefinSans(),
          ),
          trailing: Text(
            '1 hour ago',
            style: GoogleFonts.josefinSans(),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 60,
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.telegram_outlined,
            size: 40,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              size: 40,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outline,
              size: 40,
            ),
            label: ''),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 40,
            ),
            label: ''),
      ],
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
