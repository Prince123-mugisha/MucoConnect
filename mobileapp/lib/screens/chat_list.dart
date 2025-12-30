import 'package:flutter/material.dart';
import 'package:mobileapp/screens/JobExploreScreen.dart';
import 'package:mobileapp/screens/myjobs.dart';
import 'package:mobileapp/screens/profilescreen.dart';
import 'package:mobileapp/screens/chat_screen.dart';
import 'package:mobileapp/screens/notification_screen.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  int _selectedNavIndex = 2;
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearchBar(),
            _buildStoriesSection(),
            Expanded(child: _buildChatList(context)),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Chat with recruiters',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              // Notification Icon with badge
              Stack(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.notifications_outlined,
                          color: Color(0xFF2D2D2D), size: 22),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const NotificationScreen(),
                          ),
                        );
                      },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFFFF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Color(0xFF999999), size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: TextStyle(
                    color: Color(0xFF999999),
                    fontSize: 14,
                    letterSpacing: 0.2,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoriesSection() {
    final profiles = [
      {
        'label': 'You',
        'iconType': 'emoji',
        'iconValue': '😊',
        'color': Color(0xFFFF4444),
      },
      {
        'label': 'Prince',
        'iconType': 'initials',
        'iconValue': 'PR',
        'color': Color(0xFF2196F3),
      },
      {
        'label': 'Mugisha',
        'iconType': 'emoji',
        'iconValue': '🦸',
        'color': Color(0xFFFFA726),
      },
      {
        'label': 'Muhire',
        'iconType': 'initials',
        'iconValue': 'MU',
        'color': Color(0xFF9C27B0),
      },
      {
        'label': 'Christian',
        'iconType': 'emoji',
        'iconValue': '🎸',
        'color': Color(0xFF4CAF50),
      },
      {
        'label': 'Alice',
        'iconType': 'initials',
        'iconValue': 'AL',
        'color': Color(0xFF00BCD4),
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 90,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          scrollDirection: Axis.horizontal,
          itemCount: profiles.length,
          separatorBuilder: (context, i) => const SizedBox(width: 16),
          itemBuilder: (context, i) {
            final p = profiles[i];
            return Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        (p['color'] as Color).withOpacity(0.8),
                        p['color'] as Color,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: (p['color'] as Color).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: (p['iconType'] == 'emoji')
                        ? Text(
                            p['iconValue'] as String,
                            style: const TextStyle(fontSize: 28),
                          )
                        : Text(
                            p['iconValue'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  p['label'] as String,
                  style: TextStyle(
                    color: Color(0xFF2D2D2D),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatList(BuildContext context) {
    final chats = [
      {
        'name': 'Ralph Edwards',
        'message': 'Hey! Are you available for a quick chat?',
        'time': '2:30 PM',
        'online': true,
        'unread': true,
        'iconType': 'emoji',
        'iconValue': '🦸',
        'color': Color(0xFF4CAF50),
      },
      {
        'name': 'Arlene McCoy',
        'message': 'Can you see my portfolio?',
        'time': '09:24 PM',
        'online': true,
        'unread': false,
        'iconType': 'initials',
        'iconValue': 'AM',
        'color': Color(0xFF2196F3),
      },
      {
        'name': 'Devon Lane',
        'message': 'Yes, sir',
        'time': '09:17 PM',
        'online': true,
        'unread': true,
        'iconType': 'emoji',
        'iconValue': '🎸',
        'color': Color(0xFFFFA726),
      },
      {
        'name': 'Jenny Wilson',
        'message': "Ok, we'll continue next week",
        'time': '08:13 PM',
        'online': false,
        'unread': false,
        'iconType': 'initials',
        'iconValue': 'JW',
        'color': Color(0xFF9C27B0),
      },
      {
        'name': 'Theresa Webb',
        'message': 'I also like Marvel films, especially...',
        'time': '07:45 PM',
        'online': true,
        'unread': false,
        'iconType': 'emoji',
        'iconValue': '🎬',
        'color': Color(0xFFFF4444),
      },
      {
        'name': 'Darlene Robertson',
        'message': 'Ah, I love that movie too! Your...',
        'time': 'Yesterday',
        'online': false,
        'unread': true,
        'iconType': 'initials',
        'iconValue': 'DR',
        'color': Color(0xFF00BCD4),
      },
    ];

    return Container(
      color: Color(0xFFFAFAFA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Conversations',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D2D2D),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Stay connected with opportunities',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF666666),
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              itemCount: chats.length,
              itemBuilder: (context, i) {
                final chat = chats[i];
                return _buildChatCard(
                  context,
                  name: chat['name'] as String,
                  message: chat['message'] as String,
                  time: chat['time'] as String,
                  unread: chat['unread'] as bool,
                  online: chat['online'] as bool,
                  iconType: chat['iconType'] as String,
                  iconValue: chat['iconValue'] as String,
                  color: chat['color'] as Color,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          name: chat['name'] as String,
                          iconType: chat['iconType'] as String,
                          iconValue: chat['iconValue'] as String,
                          color: chat['color'] as Color,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatCard(
    BuildContext context, {
    required String name,
    required String message,
    required String time,
    required bool unread,
    required bool online,
    required String iconType,
    required String iconValue,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: unread ? color.withOpacity(0.3) : Color(0xFFE0E0E0),
            width: unread ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar with online status
            Stack(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(0.1),
                  ),
                  child: Center(
                    child: iconType == 'emoji'
                        ? Text(
                            iconValue,
                            style: const TextStyle(fontSize: 28),
                          )
                        : Text(
                            iconValue,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: color,
                            ),
                          ),
                  ),
                ),
                if (online)
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Color(0xFF4CAF50),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Color(0xFF2D2D2D),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF999999),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color:
                                unread ? Color(0xFF2D2D2D) : Color(0xFF666666),
                            fontWeight:
                                unread ? FontWeight.w600 : FontWeight.w400,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                      if (unread)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'New',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.explore, 'Explore', 0),
              _buildNavItem(Icons.work_outline, 'My Jobs', 1),
              _buildNavItem(Icons.chat_bubble_outline, 'Chat', 2),
              _buildNavItem(Icons.person_outline, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedNavIndex == index;
    return InkWell(
      onTap: () {
        if (label == 'Explore') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const JobExploreScreen()),
          );
        } else if (label == 'My Jobs') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyJobsScreen()),
          );
        } else if (label == 'Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        } else {
          setState(() {
            _selectedNavIndex = index;
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFFFF4444) : Color(0xFF999999),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isSelected ? Color(0xFFFF4444) : Color(0xFF999999),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
