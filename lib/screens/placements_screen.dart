import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class PlacementsScreen extends StatefulWidget {
  const PlacementsScreen({super.key});

  @override
  State<PlacementsScreen> createState() => _PlacementsScreenState();
}

class _PlacementsScreenState extends State<PlacementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _jobs = [
    {
      'company': 'Google',
      'role': 'Software Engineer',
      'package': '24 LPA',
      'location': 'Bangalore',
      'deadline': 'Jan 30, 2026',
      'eligibility': '7.0 CGPA',
      'type': 'Full Time',
      'branches': ['CSE', 'IT', 'ECE'],
      'isApplied': false,
      'color': const Color(0xFF4285F4),
    },
    {
      'company': 'Microsoft',
      'role': 'Product Manager',
      'package': '22 LPA',
      'location': 'Hyderabad',
      'deadline': 'Feb 5, 2026',
      'eligibility': '7.5 CGPA',
      'type': 'Full Time',
      'branches': ['CSE', 'IT'],
      'isApplied': true,
      'color': const Color(0xFF00A4EF),
    },
    {
      'company': 'Amazon',
      'role': 'SDE Intern',
      'package': '60K/month',
      'location': 'Remote',
      'deadline': 'Feb 10, 2026',
      'eligibility': '6.5 CGPA',
      'type': 'Internship',
      'branches': ['CSE', 'IT', 'ECE', 'EEE'],
      'isApplied': false,
      'color': const Color(0xFFFF9900),
    },
    {
      'company': 'Flipkart',
      'role': 'Data Analyst',
      'package': '18 LPA',
      'location': 'Bangalore',
      'deadline': 'Feb 15, 2026',
      'eligibility': '6.0 CGPA',
      'type': 'Full Time',
      'branches': ['CSE', 'IT', 'ECE'],
      'isApplied': false,
      'color': const Color(0xFF2874F0),
    },
    {
      'company': 'Infosys',
      'role': 'Systems Engineer',
      'package': '6.5 LPA',
      'location': 'Multiple',
      'deadline': 'Feb 20, 2026',
      'eligibility': '6.0 CGPA',
      'type': 'Full Time',
      'branches': ['All'],
      'isApplied': true,
      'color': const Color(0xFF007CC3),
    },
  ];

  final List<Map<String, dynamic>> _myApplications = [
    {
      'company': 'Microsoft',
      'role': 'Product Manager',
      'appliedDate': 'Jan 20, 2026',
      'status': 'Under Review',
      'color': const Color(0xFF00A4EF),
    },
    {
      'company': 'Infosys',
      'role': 'Systems Engineer',
      'appliedDate': 'Jan 18, 2026',
      'status': 'Shortlisted',
      'color': const Color(0xFF007CC3),
    },
    {
      'company': 'TCS',
      'role': 'Developer',
      'appliedDate': 'Jan 10, 2026',
      'status': 'Interview Scheduled',
      'color': const Color(0xFF000000),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placements'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Opportunities'),
            Tab(text: 'My Applications'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOpportunitiesTab(),
          _buildApplicationsTab(),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesTab() {
    final filters = ['All', 'Full Time', 'Internship', 'Eligible'];

    return Column(
      children: [
        // Filters
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filters.map((filter) {
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedFilter = filter;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      filter,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color:
                            isSelected ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        // Jobs List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _jobs.length,
            itemBuilder: (context, index) {
              return _buildJobCard(_jobs[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildJobCard(Map<String, dynamic> job) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: (job['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          job['company'][0],
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: job['color'],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['company'],
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimary,
                            ),
                          ),
                          Text(
                            job['role'],
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: job['type'] == 'Internship'
                            ? AppTheme.accentColor.withOpacity(0.1)
                            : AppTheme.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        job['type'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: job['type'] == 'Internship'
                              ? AppTheme.accentColor
                              : AppTheme.successColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _buildJobDetail(Icons.currency_rupee_rounded, job['package']),
                    const SizedBox(width: 16),
                    _buildJobDetail(Icons.location_on_outlined, job['location']),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildJobDetail(Icons.school_outlined, job['eligibility']),
                    const SizedBox(width: 16),
                    _buildJobDetail(Icons.calendar_today_outlined, 'Due: ${job['deadline']}'),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: (job['branches'] as List<String>).map((branch) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        branch,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => _showJobDetails(context, job),
                    icon: const Icon(Icons.info_outline_rounded, size: 18),
                    label: Text(
                      'Details',
                      style: GoogleFonts.poppins(fontSize: 13),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 35,
                  color: Colors.grey.shade200,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: job['isApplied']
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Applied to ${job['company']}!'),
                                backgroundColor: AppTheme.successColor,
                              ),
                            );
                          },
                    icon: Icon(
                      job['isApplied']
                          ? Icons.check_circle_rounded
                          : Icons.send_rounded,
                      size: 18,
                      color: job['isApplied']
                          ? AppTheme.successColor
                          : AppTheme.primaryColor,
                    ),
                    label: Text(
                      job['isApplied'] ? 'Applied' : 'Apply',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: job['isApplied']
                            ? AppTheme.successColor
                            : AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppTheme.textSecondary),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppTheme.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildApplicationsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: _buildStatCard('Total', '5', AppTheme.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Shortlisted', '2', AppTheme.successColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatCard('Pending', '3', AppTheme.accentColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Recent Applications',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _myApplications.length,
            itemBuilder: (context, index) {
              return _buildApplicationCard(_myApplications[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppTheme.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationCard(Map<String, dynamic> application) {
    Color statusColor;
    IconData statusIcon;
    switch (application['status']) {
      case 'Shortlisted':
        statusColor = AppTheme.successColor;
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case 'Interview Scheduled':
        statusColor = const Color(0xFF9C27B0);
        statusIcon = Icons.calendar_today_rounded;
        break;
      case 'Under Review':
        statusColor = AppTheme.accentColor;
        statusIcon = Icons.hourglass_top_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help_outline_rounded;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: (application['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                application['company'][0],
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: application['color'],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application['company'],
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  application['role'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Applied: ${application['appliedDate']}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  statusIcon,
                  size: 20,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                application['status'],
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showJobDetails(BuildContext context, Map<String, dynamic> job) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: (job['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Center(
                            child: Text(
                              job['company'][0],
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: job['color'],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job['company'],
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                job['role'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: AppTheme.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildDetailSection('Package', job['package']),
                    _buildDetailSection('Location', job['location']),
                    _buildDetailSection('Eligibility', job['eligibility']),
                    _buildDetailSection('Deadline', job['deadline']),
                    _buildDetailSection('Type', job['type']),
                    const SizedBox(height: 16),
                    Text(
                      'Eligible Branches',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (job['branches'] as List<String>).map((b) {
                        return Chip(
                          label: Text(b),
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Job Description',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We are looking for talented individuals to join our team. The role involves developing cutting-edge solutions, collaborating with cross-functional teams, and contributing to impactful projects.\n\nRequirements:\n• Strong programming fundamentals\n• Problem-solving skills\n• Good communication\n• Team player',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppTheme.textSecondary,
                        height: 1.6,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: const Text('External Link'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: job['isApplied']
                                ? null
                                : () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Applied to ${job['company']}!'),
                                        backgroundColor: AppTheme.successColor,
                                      ),
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            child: Text(job['isApplied'] ? 'Already Applied' : 'Apply Now'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDetailSection(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppTheme.textSecondary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
