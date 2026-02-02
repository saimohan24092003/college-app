import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedSemester = 5;

  final List<Map<String, dynamic>> _subjects = [
    {
      'name': 'Data Structures & Algorithms',
      'code': 'CS301',
      'professor': 'Dr. Rajesh Kumar',
      'progress': 0.75,
      'materials': [
        {'title': 'Introduction to DSA', 'type': 'pdf', 'size': '2.4 MB'},
        {'title': 'Arrays & Linked Lists', 'type': 'pdf', 'size': '3.1 MB'},
        {'title': 'Trees & Graphs Video', 'type': 'video', 'size': '156 MB'},
        {'title': 'Sorting Algorithms Notes', 'type': 'notes', 'size': '1.2 MB'},
      ],
    },
    {
      'name': 'Database Management Systems',
      'code': 'CS302',
      'professor': 'Prof. Priya Sharma',
      'progress': 0.60,
      'materials': [
        {'title': 'ER Diagrams', 'type': 'pdf', 'size': '1.8 MB'},
        {'title': 'SQL Tutorial', 'type': 'video', 'size': '245 MB'},
        {'title': 'Normalization Notes', 'type': 'notes', 'size': '890 KB'},
      ],
    },
    {
      'name': 'Operating Systems',
      'code': 'CS303',
      'professor': 'Dr. Amit Verma',
      'progress': 0.45,
      'materials': [
        {'title': 'Process Management', 'type': 'pdf', 'size': '4.2 MB'},
        {'title': 'Memory Management', 'type': 'pdf', 'size': '3.5 MB'},
        {'title': 'Deadlock Handling', 'type': 'video', 'size': '189 MB'},
      ],
    },
    {
      'name': 'Computer Networks',
      'code': 'CS304',
      'professor': 'Dr. Sneha Gupta',
      'progress': 0.30,
      'materials': [
        {'title': 'OSI Model', 'type': 'pdf', 'size': '2.1 MB'},
        {'title': 'TCP/IP Protocol', 'type': 'notes', 'size': '1.5 MB'},
      ],
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
        title: const Text('Study Materials'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          tabs: const [
            Tab(text: 'Subjects'),
            Tab(text: 'Downloads'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildSubjectsTab(),
          _buildDownloadsTab(),
        ],
      ),
    );
  }

  Widget _buildSubjectsTab() {
    return Column(
      children: [
        // Semester Selector
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(8, (index) {
                final semester = index + 1;
                final isSelected = semester == _selectedSemester;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedSemester = semester;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? AppTheme.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Text(
                      'Sem $semester',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : AppTheme.textPrimary,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // Subjects List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _subjects.length,
            itemBuilder: (context, index) {
              return _buildSubjectCard(_subjects[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSubjectCard(Map<String, dynamic> subject) {
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
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(16),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                subject['code'].toString().substring(2),
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ),
          title: Text(
            subject['name'],
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                subject['professor'],
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: subject['progress'],
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          subject['progress'] >= 0.7
                              ? AppTheme.successColor
                              : subject['progress'] >= 0.4
                                  ? AppTheme.accentColor
                                  : AppTheme.errorColor,
                        ),
                        minHeight: 6,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${(subject['progress'] * 100).toInt()}%',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          children: [
            const Divider(),
            ...List.generate(
              (subject['materials'] as List).length,
              (index) => _buildMaterialItem(subject['materials'][index]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMaterialItem(Map<String, dynamic> material) {
    IconData icon;
    Color color;
    switch (material['type']) {
      case 'pdf':
        icon = Icons.picture_as_pdf_rounded;
        color = const Color(0xFFE53935);
        break;
      case 'video':
        icon = Icons.play_circle_filled_rounded;
        color = const Color(0xFF1E88E5);
        break;
      case 'notes':
        icon = Icons.note_rounded;
        color = const Color(0xFF43A047);
        break;
      default:
        icon = Icons.insert_drive_file_rounded;
        color = Colors.grey;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  material['title'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  material['size'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.visibility_rounded),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening: ${material['title']}'),
                    ),
                  );
                },
                iconSize: 20,
                color: AppTheme.textSecondary,
              ),
              IconButton(
                icon: const Icon(Icons.download_rounded),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Downloading: ${material['title']}'),
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                  );
                },
                iconSize: 20,
                color: AppTheme.secondaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDownloadsTab() {
    final downloads = [
      {
        'title': 'Introduction to DSA',
        'subject': 'CS301',
        'type': 'pdf',
        'size': '2.4 MB',
        'date': 'Jan 20, 2026',
      },
      {
        'title': 'Trees & Graphs Video',
        'subject': 'CS301',
        'type': 'video',
        'size': '156 MB',
        'date': 'Jan 18, 2026',
      },
      {
        'title': 'SQL Tutorial',
        'subject': 'CS302',
        'type': 'video',
        'size': '245 MB',
        'date': 'Jan 15, 2026',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Downloaded Files',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${downloads.length} files',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: downloads.length,
            itemBuilder: (context, index) {
              final download = downloads[index];
              IconData icon;
              Color color;
              switch (download['type']) {
                case 'pdf':
                  icon = Icons.picture_as_pdf_rounded;
                  color = const Color(0xFFE53935);
                  break;
                case 'video':
                  icon = Icons.play_circle_filled_rounded;
                  color = const Color(0xFF1E88E5);
                  break;
                default:
                  icon = Icons.insert_drive_file_rounded;
                  color = Colors.grey;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
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
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            download['title']!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${download['subject']} • ${download['size']} • ${download['date']}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.open_in_new_rounded),
                      onPressed: () {},
                      color: AppTheme.primaryColor,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
