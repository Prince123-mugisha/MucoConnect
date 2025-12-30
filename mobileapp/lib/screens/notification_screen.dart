import 'package:flutter/material.dart';
import 'package:mobileapp/screens/JobExploreScreen.dart';
import 'package:mobileapp/screens/myjobs.dart';
import 'package:mobileapp/screens/chat_list.dart';
import 'package:mobileapp/screens/profilescreen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;

  List<NotificationItem> _allNotifications = [];
  List<NotificationItem> _jobNotifications = [];
  List<NotificationItem> _applicationNotifications = [];
  List<NotificationItem> _systemNotifications = [];
  List<NotificationItem> _chatNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {});
      }
    });

    // Simulate loading
    Future.delayed(const Duration(milliseconds: 800), () {
      _loadNotifications();
      setState(() => _isLoading = false);
    });
  }

  void _loadNotifications() {
    _allNotifications = [
      NotificationItem(
        id: '1',
        title: 'New Job Match!',
        message:
            'Senior Accountant position at TechCorp matches your profile perfectly',
        time: '2 min ago',
        type: NotificationType.job,
        isRead: false,
        icon: Icons.work_rounded,
      ),
      NotificationItem(
        id: '2',
        title: 'Application Viewed',
        message:
            'Your application for Software Developer at StartupXYZ has been viewed by the hiring team',
        time: '1 hour ago',
        type: NotificationType.application,
        isRead: false,
        icon: Icons.visibility_rounded,
      ),
      NotificationItem(
        id: '3',
        title: 'Interview Scheduled',
        message:
            'Interview scheduled for tomorrow at 2:00 PM for Electrician position',
        time: '3 hours ago',
        type: NotificationType.application,
        isRead: false,
        icon: Icons.event_available_rounded,
      ),
      NotificationItem(
        id: '4',
        title: 'Profile Update',
        message:
            'Your profile has been successfully updated with new information',
        time: '1 day ago',
        type: NotificationType.system,
        isRead: true,
        icon: Icons.check_circle_rounded,
      ),
      NotificationItem(
        id: '5',
        title: 'New Jobs Available',
        message:
            '15 new Plumbing jobs posted in your area. Check them out now!',
        time: '1 day ago',
        type: NotificationType.job,
        isRead: true,
        icon: Icons.work_rounded,
      ),
      NotificationItem(
        id: '6',
        title: 'Application Status',
        message: 'Your application status has changed to "Under Review"',
        time: '2 days ago',
        type: NotificationType.application,
        isRead: true,
        icon: Icons.update_rounded,
      ),
      NotificationItem(
        id: '7',
        title: 'New Message from Ralph',
        message: 'Hey! Are you available for a quick chat about the project?',
        time: '5 min ago',
        type: NotificationType.chat,
        isRead: false,
        icon: Icons.chat_bubble_rounded,
      ),
      NotificationItem(
        id: '8',
        title: 'Devon Lane replied',
        message: 'Yes, I will send you the updated documents by today.',
        time: '30 min ago',
        type: NotificationType.chat,
        isRead: false,
        icon: Icons.chat_bubble_rounded,
      ),
      NotificationItem(
        id: '9',
        title: 'BuildCorp Team Message',
        message: 'Team meeting scheduled for tomorrow at 10 AM.',
        time: '2 hours ago',
        type: NotificationType.chat,
        isRead: true,
        icon: Icons.group_rounded,
      ),
    ];

    // Filter by type
    _jobNotifications =
        _allNotifications.where((n) => n.type == NotificationType.job).toList();
    _applicationNotifications = _allNotifications
        .where((n) => n.type == NotificationType.application)
        .toList();
    _systemNotifications = _allNotifications
        .where((n) => n.type == NotificationType.system)
        .toList();
    _chatNotifications = _allNotifications
        .where((n) => n.type == NotificationType.chat)
        .toList();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int _getUnreadCount(List<NotificationItem> notifications) {
    return notifications.where((n) => !n.isRead).length;
  }

  void _handleNotificationTap(NotificationItem notification) {
    setState(() {
      notification.isRead = true;
    });

    // Navigate based on notification type
    if (notification.type == NotificationType.job) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JobExploreScreen()),
      );
    } else if (notification.type == NotificationType.application) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyJobsScreen()),
      );
    } else if (notification.type == NotificationType.chat) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatListScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black.withOpacity(0.03),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2D2D2D)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF2D2D2D),
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.2,
          ),
        ),
        centerTitle: true,
        actions: [
          if (_getUnreadCount(_allNotifications) > 0)
            IconButton(
              onPressed: () {
                setState(() {
                  for (var notification in _allNotifications) {
                    notification.isRead = true;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Row(
                      children: [
                        Icon(Icons.check_circle_rounded,
                            color: Colors.white, size: 20),
                        SizedBox(width: 8),
                        Text('All notifications cleared'),
                      ],
                    ),
                    backgroundColor: const Color(0xFF4CAF50),
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
              icon:
                  const Icon(Icons.done_all_rounded, color: Color(0xFFFF4444)),
              tooltip: 'Clear all',
            ),
          const SizedBox(width: 4),
        ],
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(
                    color: Color(0xFFFF4444),
                    strokeWidth: 3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Loading notifications...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                _buildTabBar(),
                Expanded(child: _buildTabView()),
              ],
            ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildTabChip('All', 0, _getUnreadCount(_allNotifications)),
          const SizedBox(width: 8),
          _buildTabChip('Jobs', 1, _getUnreadCount(_jobNotifications)),
          const SizedBox(width: 8),
          _buildTabChip('Apps', 2, _getUnreadCount(_applicationNotifications)),
          const SizedBox(width: 8),
          _buildTabChip('System', 3, _getUnreadCount(_systemNotifications)),
          const SizedBox(width: 8),
          _buildTabChip('Chat', 4, _getUnreadCount(_chatNotifications)),
        ],
      ),
    );
  }

  Widget _buildTabChip(String label, int index, int unreadCount) {
    bool isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.animateTo(index);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFFF4444), Color(0xFFFF6B6B)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: const Color(0xFFFF4444).withOpacity(0.25),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : const Color(0xFF666666),
                letterSpacing: 0.2,
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withOpacity(0.3)
                      : const Color(0xFFFF4444).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  unreadCount.toString(),
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? Colors.white : const Color(0xFFFF4444),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildNotificationsList(_allNotifications),
        _buildNotificationsList(_jobNotifications),
        _buildNotificationsList(_applicationNotifications),
        _buildNotificationsList(_systemNotifications),
        _buildNotificationsList(_chatNotifications),
      ],
    );
  }

  Widget _buildNotificationsList(List<NotificationItem> notifications) {
    if (notifications.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFFF4444).withOpacity(0.1),
                    const Color(0xFFFFA726).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_off_outlined,
                size: 50,
                color: Color(0xFFCCCCCC),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No notifications yet',
              style: TextStyle(
                fontSize: 20,
                color: Color(0xFF2D2D2D),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text(
                'You\'re all caught up! We\'ll notify you when something new arrives.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF999999),
                  height: 1.5,
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      color: const Color(0xFFFAFAFA),
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationCard(notifications[index]);
        },
      ),
    );
  }

  Widget _buildNotificationCard(NotificationItem notification) {
    Color typeColor = notification.type == NotificationType.job
        ? const Color(0xFFFF4444)
        : notification.type == NotificationType.application
            ? const Color(0xFFFFA726)
            : notification.type == NotificationType.chat
                ? const Color(0xFF2196F3)
                : const Color(0xFF4CAF50);

    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFF4444), Color(0xFFE53935)],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.delete_rounded, color: Colors.white, size: 28),
            SizedBox(height: 4),
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                'Delete Notification?',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2D2D2D),
                ),
              ),
              content: const Text(
                'This notification will be permanently deleted.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF666666),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF999999),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF4444),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Delete',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        setState(() {
          _allNotifications.remove(notification);
          _jobNotifications.remove(notification);
          _applicationNotifications.remove(notification);
          _systemNotifications.remove(notification);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white, size: 20),
                SizedBox(width: 12),
                Text('Notification deleted'),
              ],
            ),
            backgroundColor: const Color(0xFF666666),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            action: SnackBarAction(
              label: 'Undo',
              textColor: const Color(0xFFFF4444),
              onPressed: () {
                setState(() {
                  _allNotifications.add(notification);
                  if (notification.type == NotificationType.job) {
                    _jobNotifications.add(notification);
                  } else if (notification.type ==
                      NotificationType.application) {
                    _applicationNotifications.add(notification);
                  } else {
                    _systemNotifications.add(notification);
                  }
                });
              },
            ),
          ),
        );
      },
      child: InkWell(
        onTap: () => _handleNotificationTap(notification),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: notification.isRead
                ? null
                : LinearGradient(
                    colors: [
                      Colors.white,
                      typeColor.withOpacity(0.04),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
            color: notification.isRead ? Colors.white : null,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notification.isRead
                  ? const Color(0xFFE0E0E0)
                  : typeColor.withOpacity(0.3),
              width: notification.isRead ? 1 : 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: notification.isRead
                    ? Colors.black.withOpacity(0.03)
                    : typeColor.withOpacity(0.08),
                blurRadius: notification.isRead ? 8 : 12,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      typeColor,
                      typeColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: typeColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  notification.icon,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              const SizedBox(width: 14),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: notification.isRead
                                  ? FontWeight.w600
                                  : FontWeight.w700,
                              color: const Color(0xFF2D2D2D),
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        if (!notification.isRead)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFF4444),
                                  Color(0xFFFF6B6B),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      notification.message,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF666666),
                        height: 1.5,
                        letterSpacing: 0.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 13,
                                color: typeColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                notification.time,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: typeColor,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: const Color(0xFF999999),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum NotificationType {
  job,
  application,
  system,
  chat,
}

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  bool isRead;
  final IconData icon;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.isRead,
    required this.icon,
  });
}
