import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'chat_screen.dart';

class MatchedScreen extends StatefulWidget {
  @override
  _MatchedScreenState createState() => _MatchedScreenState();
}

class _MatchedScreenState extends State<MatchedScreen> {
  bool _isHovered = false;
  List<Chat> unreadChats = [
    Chat('Ava Jones', 'assets/54.png', '1 hour ago'),
  ];
  List<Chat> readChats = [];

  void _navigateToChat(Chat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(),
      ),
    ).then((_) {
      setState(() {
        unreadChats.remove(chat);
        readChats.insert(0, chat);
      });
    });
  }

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
          Divider(height: 40),
          _buildMatchedProfilesSection(context),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 8, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'New Match! ',
                  style: GoogleFonts.josefinSans(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(${unreadChats.length})',
                  style: GoogleFonts.josefinSans(fontSize: 24),
                ),
                Text(
                  '  Swipe to chat',
                  style: GoogleFonts.josefinSans(
                      fontSize: 12, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: unreadChats.length,
              itemBuilder: (context, index) {
                final chat = unreadChats[index];
                return Dismissible(
                  key: Key(chat.name),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    _navigateToChat(chat);
                  },
                  background: Container(
                    color: Color.fromARGB(255, 91, 161, 93),
                    child: Center(
                      child: Text(
                        'Entering the Chat',
                        style: GoogleFonts.josefinSans(color: Colors.white),
                      ),
                    ),
                  ),
                  child: _buildChatListTile(chat, isRead: false),
                );
              },
            ),
          ),
          Divider(),
          Container(
            padding: EdgeInsets.only(top: 8, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Read Chats ',
                  style: GoogleFonts.josefinSans(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  '(${readChats.length})',
                  style: GoogleFonts.josefinSans(fontSize: 24),
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: readChats.length,
              itemBuilder: (context, index) {
                final chat = readChats[index];
                return _buildChatListTile(chat, isRead: true);
              },
            ),
          ),
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
            height: avatarRadius * 3,
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
    double imageSize = radius * 1.2;

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
                  width: imageSize,
                  height: imageSize,
                  child: Align(
                    alignment: Alignment.center,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset(
                        imagePath,
                        width: imageSize,
                        height: imageSize,
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

  Widget _buildChatListTile(Chat chat, {required bool isRead}) {
    return GestureDetector(
      onTap: () {
        if (isRead) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        }
      },
      child: Container(
        color: isRead ? Colors.grey[200] : Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(chat.imagePath),
            radius: 25,
          ),
          title: Text(
            chat.name,
            style: GoogleFonts.josefinSans(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Chat now!',
            style: GoogleFonts.josefinSans(),
          ),
          trailing: Text(
            chat.timeAgo,
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

class Chat {
  final String name;
  final String imagePath;
  final String timeAgo;

  Chat(this.name, this.imagePath, this.timeAgo);
}
