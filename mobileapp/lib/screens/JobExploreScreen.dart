import 'package:mobileapp/screens/chat_list.dart';
import 'package:mobileapp/screens/myjobs.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/Data/JobData.dart';
import 'package:mobileapp/screens/JobDetails.dart';
import 'package:mobileapp/screens/profilescreen.dart';
import 'package:mobileapp/screens/notification_screen.dart';

class JobExploreScreen extends StatefulWidget {
  const JobExploreScreen({super.key});

  @override
  State<JobExploreScreen> createState() => _JobExploreScreenState();
}

class _JobExploreScreenState extends State<JobExploreScreen> {
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String _selectedLocation = 'Rwanda';
  int _selectedNavIndex = 0;

  List<Job> _allJobs = [];
  List<Job> _filteredJobs = [];
  List<String> _bookmarkedJobIds = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      _loadData();
      setState(() => _isLoading = false);
    });
  }

  void _loadData() {
    setState(() {
      _allJobs = JobData.getAllJobs();
      _filteredJobs = _allJobs;
      _categories = JobData.getCategories();
    });
  }

  void _filterJobs() {
    setState(() {
      _filteredJobs = _allJobs.where((job) {
        bool matchesSearch = _searchController.text.isEmpty ||
            job.title
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            job.companyName
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());

        bool matchesCategory = _selectedCategory == null ||
            _selectedCategory!.isEmpty ||
            job.title
                .toLowerCase()
                .contains(_selectedCategory!.toLowerCase()) ||
            job.description
                .toLowerCase()
                .contains(_selectedCategory!.toLowerCase());

        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  void _toggleBookmark(String jobId) {
    setState(() {
      if (_bookmarkedJobIds.contains(jobId)) {
        _bookmarkedJobIds.remove(jobId);
      } else {
        _bookmarkedJobIds.add(jobId);
      }
    });
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
                    SizedBox(height: 24),
                    Text(
                      'Loading jobs...',
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
                  _buildSearchSection(),
                  Expanded(child: _buildJobsList()),
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
                'Explore Jobs',
                style: TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Find your dream job',
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

  Widget _buildSearchSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          // Search Bar
          Container(
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
                    onChanged: (value) => _filterJobs(),
                    style: const TextStyle(fontSize: 14, letterSpacing: 0.2),
                    decoration: InputDecoration(
                      hintText: 'Search by job',
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
          const SizedBox(height: 12),

          // Category and Location
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Color(0xFFF8F8F8),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE0E0E0), width: 1),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.category_outlined,
                          color: Color(0xFF999999), size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            hint: Text(
                              'Category',
                              style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: 13,
                                letterSpacing: 0.2,
                              ),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Color(0xFF999999), size: 20),
                            isExpanded: true,
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 13,
                              letterSpacing: 0.2,
                            ),
                            items: _categories
                                .map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                              _filterJobs();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                decoration: BoxDecoration(
                  color: Color(0xFFF8F8F8),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFE0E0E0), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Color(0xFF999999), size: 18),
                    const SizedBox(width: 4),
                    Text(
                      _selectedLocation,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF2D2D2D),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Search Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: _filterJobs,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsList() {
    List<Job> jobsToShow =
        _filteredJobs.length > 1 ? _filteredJobs.sublist(1) : _filteredJobs;
    if (jobsToShow.isEmpty) {
      jobsToShow = [
        Job(
          id: 'new',
          companyName: 'ShortCo',
          title: 'Short Job',
          description: 'A short job card for testing.',
          employmentType: 'Full Time',
          salary: '10K/month',
          location: 'Remote',
          logoColor: Color(0xFFFF4444),
          logoIcon: Icons.work,
          isBookmarked: false,
        ),
      ];
    }
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recommended Jobs',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2D2D2D),
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Jobs that match your skills',
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
            child: jobsToShow.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off,
                            size: 64, color: Color(0xFFE0E0E0)),
                        const SizedBox(height: 16),
                        Text(
                          'No jobs found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF666666),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try adjusting your search filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF999999),
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    itemCount: jobsToShow.length,
                    itemBuilder: (context, index) {
                      return _buildJobCard(jobsToShow[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobCard(Job job) {
    bool isBookmarked = _bookmarkedJobIds.contains(job.id);

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
                InkWell(
                  onTap: () => _toggleBookmark(job.id),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color:
                          isBookmarked ? Color(0xFFFF4444) : Color(0xFFCCCCCC),
                      size: 22,
                    ),
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
        if (label == 'My Jobs') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MyJobsScreen()),
          );
        } else if (label == 'Profile') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          );
        } else if (label == 'Chat') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatListScreen()),
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
