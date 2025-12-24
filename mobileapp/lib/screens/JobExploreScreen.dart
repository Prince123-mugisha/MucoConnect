import 'package:mobileapp/screens/myjobs.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobileapp/Data/JobData.dart';
// import 'package:mobileapp/screens/JobDetails.dart';
import 'package:mobileapp/screens/JobDetails.dart';
// Import the job model and data

class JobExploreScreen extends StatefulWidget {
  const JobExploreScreen({super.key});

  @override
  State<JobExploreScreen> createState() => _JobExploreScreenState();
}

class _JobExploreScreenState extends State<JobExploreScreen> {
  bool _isLoading = true;
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String _selectedLocation = 'Indonesia';
  int _selectedNavIndex = 0;

  List<Job> _allJobs = [];
  List<Job> _filteredJobs = [];
  List<String> _bookmarkedJobIds = [];
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 20), () {
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
      backgroundColor: Color(0xFF1A1A2E),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF4D61FC)),
                    SizedBox(height: 24),
                    Text('Loading jobs...',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
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
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Explore Job',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.notifications_outlined,
                    color: Colors.white, size: 28),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No new notifications')),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF3B3B),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) => _filterJobs(),
                    style: TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: 'Search by job',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),

          // Category and Location
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.category_outlined,
                          color: Colors.grey, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedCategory,
                            hint: Text(
                              'Choose Category',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 14),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down,
                                color: Colors.grey),
                            isExpanded: true,
                            items: _categories
                                .map((cat) => DropdownMenuItem(
                                      value: cat,
                                      child: Text(cat,
                                          style: TextStyle(fontSize: 14)),
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
              SizedBox(width: 12),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        color: Colors.grey, size: 20),
                    SizedBox(width: 4),
                    Text(
                      _selectedLocation,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Search Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _filterJobs,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4D61FC),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobsList() {
    // Remove the first job card (which may be causing overflow) or add a new short job card
    List<Job> jobsToShow =
        _filteredJobs.length > 1 ? _filteredJobs.sublist(1) : _filteredJobs;
    // Optionally, add a new job with short text if list is empty
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
          logoColor: Colors.blue,
          logoIcon: Icons.work,
          isBookmarked: false,
        ),
      ];
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Work Recommendation',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Discover jobs that suitable with your skill',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
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
                            size: 64, color: Colors.grey[300]),
                        SizedBox(height: 16),
                        Text(
                          'No jobs found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Try adjusting your search filters',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: Offset(0, 2),
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
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: job.logoColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    job.logoIcon,
                    color: job.logoColor,
                    size: 26,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.companyName,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        job.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () => _toggleBookmark(job.id),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color:
                          isBookmarked ? Color(0xFF4D61FC) : Colors.grey[400],
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),

            // Job Description
            Text(
              job.description,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[600],
                height: 1.5,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 16),

            // Job Details Tags
            Row(
              children: [
                _buildTag(job.employmentType, Icons.access_time),
                SizedBox(width: 8),
                _buildTag(job.salary, Icons.payments_outlined),
                SizedBox(width: 8),
                _buildTag(job.location, Icons.location_on_outlined),
                Spacer(),
                Icon(Icons.arrow_forward, size: 18, color: Color(0xFF4D61FC)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTag(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
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
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.explore, 'Explore', 0),
              _buildNavItem(Icons.work_outline, 'My Jobs', 1),
              _buildNavItem(Icons.person_outline, 'Profile', 2),
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
            MaterialPageRoute(builder: (_) => MyJobsScreen()),
          );
        } else {
          setState(() {
            _selectedNavIndex = index;
          });
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Color(0xFF4D61FC) : Colors.grey[400],
              size: 26,
            ),
            SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Color(0xFF4D61FC) : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
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
