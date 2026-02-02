import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  int _selectedSemester = 4;

  final Map<int, List<Map<String, dynamic>>> _results = {
    4: [
      {'subject': 'Data Structures', 'code': 'CS201', 'marks': 85, 'total': 100, 'grade': 'A'},
      {'subject': 'Digital Electronics', 'code': 'EC201', 'marks': 78, 'total': 100, 'grade': 'B+'},
      {'subject': 'Mathematics III', 'code': 'MA201', 'marks': 92, 'total': 100, 'grade': 'A+'},
      {'subject': 'Computer Architecture', 'code': 'CS202', 'marks': 74, 'total': 100, 'grade': 'B'},
      {'subject': 'Object Oriented Programming', 'code': 'CS203', 'marks': 88, 'total': 100, 'grade': 'A'},
      {'subject': 'Technical Writing', 'code': 'HU201', 'marks': 82, 'total': 100, 'grade': 'A'},
    ],
    3: [
      {'subject': 'Programming in C', 'code': 'CS101', 'marks': 90, 'total': 100, 'grade': 'A+'},
      {'subject': 'Basic Electronics', 'code': 'EC101', 'marks': 72, 'total': 100, 'grade': 'B'},
      {'subject': 'Mathematics II', 'code': 'MA102', 'marks': 88, 'total': 100, 'grade': 'A'},
      {'subject': 'Physics', 'code': 'PH101', 'marks': 76, 'total': 100, 'grade': 'B+'},
      {'subject': 'Environmental Science', 'code': 'ES101', 'marks': 85, 'total': 100, 'grade': 'A'},
    ],
  };

  final Map<int, Map<String, double>> _gpaData = {
    4: {'gpa': 8.5, 'cgpa': 8.4},
    3: {'gpa': 8.3, 'cgpa': 8.2},
    2: {'gpa': 8.0, 'cgpa': 8.1},
    1: {'gpa': 8.2, 'cgpa': 8.2},
  };

  @override
  Widget build(BuildContext context) {
    final currentResults = _results[_selectedSemester] ?? [];
    final gpa = _gpaData[_selectedSemester]?['gpa'] ?? 0.0;
    final cgpa = _gpaData[_selectedSemester]?['cgpa'] ?? 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Results'),
        actions: [
          IconButton(
            icon: const Icon(Icons.download_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Downloading marksheet...'),
                  backgroundColor: AppTheme.secondaryColor,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
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
                  final hasResults = _results.containsKey(semester);
                  return GestureDetector(
                    onTap: hasResults
                        ? () {
                            setState(() {
                              _selectedSemester = semester;
                            });
                          }
                        : null,
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : hasResults
                                ? Colors.white
                                : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : hasResults
                                  ? Colors.grey.shade300
                                  : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        'Sem $semester',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : hasResults
                                  ? AppTheme.textPrimary
                                  : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          // GPA Cards
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildGpaCard('Semester GPA', gpa, AppTheme.secondaryColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildGpaCard('CGPA', cgpa, AppTheme.primaryColor),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Results Table Header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Subject',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Marks',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Grade',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Results Table Body
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: currentResults.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.hourglass_empty_rounded,
                            size: 60,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Results not yet published',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: currentResults.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),
                      itemBuilder: (context, index) {
                        final result = currentResults[index];
                        return _buildResultRow(result);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 16),
          // Download Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Downloading marksheet as PDF...'),
                      backgroundColor: AppTheme.secondaryColor,
                    ),
                  );
                },
                icon: const Icon(Icons.download_rounded),
                label: Text(
                  'Download Marksheet',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGpaCard(String title, double value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toStringAsFixed(1),
            style: GoogleFonts.poppins(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'out of 10',
            style: GoogleFonts.poppins(
              fontSize: 11,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultRow(Map<String, dynamic> result) {
    Color gradeColor;
    switch (result['grade']) {
      case 'A+':
        gradeColor = const Color(0xFF2E7D32);
        break;
      case 'A':
        gradeColor = const Color(0xFF43A047);
        break;
      case 'B+':
        gradeColor = const Color(0xFF1976D2);
        break;
      case 'B':
        gradeColor = const Color(0xFF42A5F5);
        break;
      default:
        gradeColor = AppTheme.textSecondary;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  result['subject'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.textPrimary,
                  ),
                ),
                Text(
                  result['code'],
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '${result['marks']}/${result['total']}',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: gradeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  result['grade'],
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: gradeColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
