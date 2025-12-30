import 'package:flutter/material.dart';
import 'package:mobileapp/Data/JobData.dart';
import 'package:mobileapp/screens/JobDetails.dart';
import 'package:mobileapp/screens/JobExploreScreen.dart';
import 'package:mobileapp/screens/chat_list.dart';
import 'package:mobileapp/screens/profilescreen.dart';

class MyJobsScreen extends StatefulWidget {
  const MyJobsScreen({super.key});

  @override
  State<MyJobsScreen> createState() => _MyJobsScreenState();
}

class _MyJobsScreenState extends State<MyJobsScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  List<Job> _myJobs = [];
  late TabController _tabController;
  int _selectedNavIndex = 1; // Set to 1 since this is "My Jobs"

  // Separate lists for different job statuses
  List<Job> _savedJobs = [];
  List<Job> _appliedJobs = [];
  List<Job> _interviewJobs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Simulate loading
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        final allJobs = JobData.getAllJobs();
        // Split jobs into different categories for demo
        _savedJobs = allJobs.take(2).toList();
        _appliedJobs = allJobs.skip(2).take(3).toList();
        _interviewJobs = allJobs.skip(5).take(1).toList();
        _myJobs = allJobs.take(6).toList();
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Job> _getCurrentJobs() {
    switch (_tabController.index) {
      case 0:
        return _savedJobs;
      case 1:
        return _appliedJobs;
      case 2:
        return _interviewJobs;
      default:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFFFF4444)),
                    const SizedBox(height: 24),
                    Text(
                      'Loading your jobs...',
                      style: TextStyle(
                        color: Color(0xFF666666),
                        fontSize: 16,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  _buildHeader(),
                  _buildTabBar(),
                  Expanded(child: _buildTabContent()),
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
                'My Jobs',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Track your job applications',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 13,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(Icons.refresh, color: Color(0xFF2D2D2D), size: 22),
              onPressed: () {
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() => _isLoading = false);
                });
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        controller: _tabController,
        onTap: (index) => setState(() {}),
        indicator: BoxDecoration(
          color: Color(0xFFFF4444),
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Color(0xFF999999),
        labelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: 'Saved (${_savedJobs.length})'),
          Tab(text: 'Applied (${_appliedJobs.length})'),
          Tab(text: 'Interview (${_interviewJobs.length})'),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildJobsList(_savedJobs, 'Saved Jobs', 'saved'),
        _buildJobsList(_appliedJobs, 'Applied Jobs', 'applied'),
        _buildJobsList(_interviewJobs, 'Interview Stage', 'interview'),
      ],
    );
  }

  Widget _buildJobsList(List<Job> jobs, String title, String type) {
    return Container(
      color: Color(0xFFFAFAFA),
      child: jobs.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      type == 'saved'
                          ? Icons.bookmark_border
                          : type == 'applied'
                              ? Icons.work_outline
                              : Icons.event_available,
                      size: 40,
                      color: Color(0xFFCCCCCC),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No $type jobs yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      type == 'saved'
                          ? 'Bookmark jobs to save them for later'
                          : type == 'applied'
                              ? 'Jobs you apply for will appear here'
                              : 'Interview invitations will show up here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF999999),
                        letterSpacing: 0.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                return _buildJobCard(jobs[index], type);
              },
            ),
    );
  }

  Widget _buildJobCard(Job job, String type) {
    Color statusColor = type == 'saved'
        ? Color(0xFFFF4444)
        : type == 'applied'
            ? Color(0xFFFFA726)
            : Color(0xFF4CAF50);

    IconData statusIcon = type == 'saved'
        ? Icons.bookmark
        : type == 'applied'
            ? Icons.send
            : Icons.event_available;

    String statusText = type == 'saved'
        ? 'Saved'
        : type == 'applied'
            ? 'Applied'
            : 'Interview Scheduled';

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsScreen(job: job)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Company Logo
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: job.logoColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    job.logoIcon,
                    color: job.logoColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.companyName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2D2D),
                          letterSpacing: -0.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Status Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        color: statusColor,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        statusText,
                        style: TextStyle(
                          fontSize: 11,
                          color: statusColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Job Description
            Text(
              job.description,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF666666),
                height: 1.5,
                letterSpacing: 0.2,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 14),

            // Job Details Tags
            Row(
              children: [
                _buildTag(job.employmentType, Icons.access_time),
                const SizedBox(width: 6),
                _buildTag(job.salary, Icons.payments_outlined),
                const SizedBox(width: 6),
                _buildTag(job.location, Icons.location_on_outlined),
                const Spacer(),
                Icon(Icons.arrow_forward, size: 16, color: Color(0xFFFF4444)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFE0E0E0), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Color(0xFF999999)),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: Color(0xFF666666),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
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
              _buildNavItem(Icons.person_outline, 'Profile', 4),
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
        } else if (label == 'Chat') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatListScreen()),
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
}
