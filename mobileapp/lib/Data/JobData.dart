import 'package:flutter/material.dart';

class Job {
  final String id;
  final String companyName;
  final String title;
  final String description;
  final String employmentType;
  final String salary;
  final String location;
  final Color logoColor;
  final IconData logoIcon;
  final bool isBookmarked;

  Job({
    required this.id,
    required this.companyName,
    required this.title,
    required this.description,
    required this.employmentType,
    required this.salary,
    required this.location,
    required this.logoColor,
    required this.logoIcon,
    required this.isBookmarked,
  });
}

// Job dummy data
class JobData {
  static List<Job> getAllJobs() {
    return [
      Job(
        id: '1',
        companyName: 'Risonlabs',
        title: 'UI Designer for Commercial Use',
        description:
            'We need senior UI/X Designer to create UI Kits for commercial use, the product will be publish on various platforms.',
        employmentType: 'Full Time',
        salary: '12-32K/month',
        location: 'Remote',
        logoColor: Color(0xFF5B51D8),
        logoIcon: Icons.palette_outlined,
        isBookmarked: false,
      ),
      Job(
        id: '2',
        companyName: 'Twitter',
        title: 'Graphic Designer to Create',
        description:
            'Graphic designer needed to create ads banner for Facebook, Instagram, website ads and etc.',
        employmentType: 'Full Time',
        salary: '12-32K/month',
        location: 'Remote',
        logoColor: Color(0xFF1DA1F2),
        logoIcon: Icons.image_outlined,
        isBookmarked: false,
      ),
      Job(
        id: '3',
        companyName: 'Pinterest',
        title: 'Front End Developer',
        description:
            'Looking for experienced React developer to build modern web applications with latest technologies and best practices.',
        employmentType: 'Full Time',
        salary: '25-45K/month',
        location: 'Remote',
        logoColor: Color(0xFFE60023),
        logoIcon: Icons.code,
        isBookmarked: false,
      ),
      Job(
        id: '4',
        companyName: 'BuildMaster Co',
        title: 'Senior Plumber - Residential',
        description:
            'Experienced plumber needed for high-end residential projects. Must have 5+ years experience in residential plumbing systems.',
        employmentType: 'Full Time',
        salary: '18-28K/month',
        location: 'Kigali',
        logoColor: Color(0xFF00BFA5),
        logoIcon: Icons.plumbing,
        isBookmarked: false,
      ),
      Job(
        id: '5',
        companyName: 'ElectroTech Solutions',
        title: 'Licensed Electrician',
        description:
            'Join our team of professional electricians. Work on commercial installations, maintenance, and emergency repairs.',
        employmentType: 'Full Time',
        salary: '20-35K/month',
        location: 'Kigali',
        logoColor: Color(0xFFFFB300),
        logoIcon: Icons.electrical_services,
        isBookmarked: false,
      ),
      Job(
        id: '6',
        companyName: 'WoodWorks Studio',
        title: 'Master Carpenter',
        description:
            'Skilled carpenter wanted for custom furniture and cabinetry projects. Portfolio required. Work with premium materials.',
        employmentType: 'Contract',
        salary: '15-30K/month',
        location: 'Kigali',
        logoColor: Color(0xFF795548),
        logoIcon: Icons.carpenter,
        isBookmarked: false,
      ),
      Job(
        id: '7',
        companyName: 'WeldPro Industries',
        title: 'Certified Welder - TIG/MIG',
        description:
            'Industrial welding position available. TIG/MIG experience required. Great benefits package and safety training.',
        employmentType: 'Full Time',
        salary: '22-38K/month',
        location: 'Kigali',
        logoColor: Color(0xFFFF6F00),
        logoIcon: Icons.whatshot,
        isBookmarked: false,
      ),
      Job(
        id: '8',
        companyName: 'AutoFix Garage',
        title: 'Automotive Mechanic',
        description:
            'Busy auto repair shop seeking experienced mechanic. All makes and models. ASE certification preferred.',
        employmentType: 'Full Time',
        salary: '16-28K/month',
        location: 'Kigali',
        logoColor: Color(0xFF424242),
        logoIcon: Icons.car_repair,
        isBookmarked: false,
      ),
      Job(
        id: '9',
        companyName: 'CoolAir Systems',
        title: 'HVAC Technician',
        description:
            'Install and maintain heating, ventilation, and air conditioning systems. EPA certification required.',
        employmentType: 'Full Time',
        salary: '19-32K/month',
        location: 'Kigali',
        logoColor: Color(0xFF00ACC1),
        logoIcon: Icons.ac_unit,
        isBookmarked: false,
      ),
      Job(
        id: '10',
        companyName: 'StoneCraft Ltd',
        title: 'Master Mason',
        description:
            'Expert mason needed for residential and commercial projects. Brick, stone, and concrete work. 7+ years experience.',
        employmentType: 'Full Time',
        salary: '17-29K/month',
        location: 'Kigali',
        logoColor: Color(0xFF616161),
        logoIcon: Icons.foundation,
        isBookmarked: false,
      ),
      Job(
        id: '11',
        companyName: 'MetalWorks Inc',
        title: 'Structural Welder',
        description:
            'Welding structural steel for commercial buildings. Blueprint reading required. Competitive salary and overtime.',
        employmentType: 'Contract',
        salary: '24-40K/month',
        location: 'Remote',
        logoColor: Color(0xFFD84315),
        logoIcon: Icons.construction,
        isBookmarked: false,
      ),
      Job(
        id: '12',
        companyName: 'HomeRepair Pro',
        title: 'General Contractor',
        description:
            'Lead construction projects from start to finish. Manage teams, budgets, and timelines for residential renovations.',
        employmentType: 'Full Time',
        salary: '30-50K/month',
        location: 'Kigali',
        logoColor: Color(0xFF689F38),
        logoIcon: Icons.home_repair_service,
        isBookmarked: false,
      ),
      Job(
        id: '13',
        companyName: 'TechStart Hub',
        title: 'Mobile App Developer',
        description:
            'Build cross-platform mobile applications using Flutter. Work with modern design patterns and cloud services.',
        employmentType: 'Full Time',
        salary: '28-48K/month',
        location: 'Remote',
        logoColor: Color(0xFF6C63FF),
        logoIcon: Icons.phone_android,
        isBookmarked: false,
      ),
      Job(
        id: '15',
        companyName: 'Pipeline Solutions',
        title: 'Commercial Plumber',
        description:
            'Work on large-scale commercial plumbing projects. Install and maintain complex piping systems.',
        employmentType: 'Full Time',
        salary: '20-32K/month',
        location: 'Kigali',
        logoColor: Color(0xFF26A69A),
        logoIcon: Icons.plumbing,
        isBookmarked: false,
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'Plumbing',
      'Electrical Installation',
      'Carpentry',
      'Masonry',
      'Welding',
      'Automotive Mechanics',
      'HVAC Technician',
      'Construction',
      'Design',
      'Development',
    ];
  }

  static List<String> getLocations() {
    return [
      'Indonesia',
      'Kigali',
      'Remote',
      'Rwanda',
      'Nairobi',
    ];
  }
}
