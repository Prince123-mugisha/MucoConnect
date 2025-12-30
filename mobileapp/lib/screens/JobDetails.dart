// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mobileapp/Data/JobData.dart';

class JobDetailsScreen extends StatefulWidget {
  final Job job;
  const JobDetailsScreen({super.key, required this.job});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  bool isBookmarked = false;

  // Dummy qualifications data
  final List<String> qualifications = [
    "Bachelor's degree in Accounting, Finance, or a related field.",
    "Certification as a CPA (Certified Public Accountant) or equivalent is a plus. Strong understanding of accounting principles and financial reporting standards (GAAP/IFRS).",
    "Proficient in accounting software (e.g., QuickBooks, SAP) and Microsoft Excel.",
    "Excellent analytical and problem-solving skills.",
    "Attention to detail and high level of accuracy in financial reporting.",
    "Strong organizational and time management skills to meet deadlines.",
    "Effective communication skills to provide financial information to stakeholders.",
    "Ability to work independently and as part of a team.",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildJobHeader(),
                    _buildDescriptionContent(),
                  ],
                ),
              ),
            ),
            _buildApplyButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Color(0xFF2D2D2D)),
          ),
          Text(
            'Job Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2D2D2D),
              letterSpacing: 0.2,
            ),
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Share functionality'),
                  backgroundColor: Color(0xFF666666),
                ),
              );
            },
            icon: Icon(
              Icons.share_outlined,
              color: Color(0xFF2D2D2D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Company Logo
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: widget.job.logoColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  widget.job.logoIcon,
                  color: widget.job.logoColor,
                  size: 28,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.job.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D2D2D),
                        letterSpacing: -0.5,
                      ),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Text(
                          widget.job.companyName,
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF666666),
                            letterSpacing: 0.2,
                          ),
                        ),
                        SizedBox(width: 8),
                        Container(
                          width: 3,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Color(0xFF999999),
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            widget.job.location,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF666666),
                              letterSpacing: 0.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(isBookmarked ? 'Job saved!' : 'Job unsaved'),
                      duration: Duration(seconds: 1),
                      backgroundColor: Color(0xFF666666),
                    ),
                  );
                },
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  color: isBookmarked ? Color(0xFFFF4444) : Color(0xFFCCCCCC),
                  size: 24,
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChip(widget.job.employmentType),
              _buildChip(widget.job.location),
              _buildChip('3-5 YoE'),
              _buildChip('Finance'),
              _buildChip('+5'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFE0E0E0), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Color(0xFF666666),
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _buildDescriptionContent() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab Selector (Description only - styled as selected)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              'Description',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ),
          SizedBox(height: 24),

          // About this role
          Text(
            'About this role',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D2D2D),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          Text(
            'An Accountant plays a key role in managing and overseeing the financial aspects of an organization. This includes preparing financial reports, maintaining accurate financial records, conducting audits... ',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF666666),
              height: 1.6,
              letterSpacing: 0.2,
            ),
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Full Description',
                    style: TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: SingleChildScrollView(
                    child: Text(
                      widget.job.description +
                          '\n\nAn Accountant plays a key role in managing and overseeing the financial aspects of an organization. This includes preparing financial reports, maintaining accurate financial records, conducting audits, and ensuring compliance with financial regulations and standards.',
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Color(0xFF666666),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color: Color(0xFFFF4444),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              'Read more',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFFFF4444),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          SizedBox(height: 24),

          // Qualifications
          Text(
            'Qualifications',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D2D2D),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 12),
          ...qualifications.map((qual) => _buildBulletPoint(qual)).toList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFFFF4444),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF666666),
                height: 1.6,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton() {
    return Container(
      padding: EdgeInsets.all(20),
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
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: Text(
                    'Apply for Job',
                    style: TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  content: Text(
                    'Do you want to apply for ${widget.job.title} at ${widget.job.companyName}?',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontSize: 14,
                      letterSpacing: 0.2,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFF999999),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Application submitted successfully!'),
                            backgroundColor: Color(0xFF4CAF50),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF4444),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Apply',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
            child: Text(
              'Apply for this job',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
