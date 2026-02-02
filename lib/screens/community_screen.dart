import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> _channels = [
    {
      'name': 'CSE Department',
      'icon': Icons.computer_rounded,
      'members': 156,
      'lastMessage': 'Prof. Kumar: Tomorrow\'s lab is shifted to Room 305',
      'time': '2m ago',
      'unread': 3,
      'color': const Color(0xFF5C6BC0),
    },
    {
      'name': 'Announcements',
      'icon': Icons.campaign_rounded,
      'members': 1200,
      'lastMessage': 'Admin: Holiday declared on 26th January',
      'time': '1h ago',
      'unread': 1,
      'color': const Color(0xFFEF5350),
    },
    {
      'name': 'Placement Cell',
      'icon': Icons.work_rounded,
      'members': 450,
      'lastMessage': 'Google hiring drive scheduled for next week',
      'time': '3h ago',
      'unread': 0,
      'color': const Color(0xFF66BB6A),
    },
    {
      'name': 'Sports Club',
      'icon': Icons.sports_soccer_rounded,
      'members': 89,
      'lastMessage': 'Cricket practice at 4 PM today',
      'time': '5h ago',
      'unread': 0,
      'color': const Color(0xFFFF7043),
    },
    {
      'name': 'Tech Club',
      'icon': Icons.code_rounded,
      'members': 234,
      'lastMessage': 'Hackathon registration closes tomorrow!',
      'time': 'Yesterday',
      'unread': 5,
      'color': const Color(0xFF42A5F5),
    },
    {
      'name': 'General Discussion',
      'icon': Icons.chat_bubble_rounded,
      'members': 800,
      'lastMessage': 'Anyone found a charger in Block A?',
      'time': 'Yesterday',
      'unread': 0,
      'color': const Color(0xFF78909C),
    },
  ];

  String? _selectedChannel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: _selectedChannel == null ? _buildChannelList() : _buildChatView(),
      floatingActionButton: _selectedChannel == null
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.send_rounded),
            ),
    );
  }

  Widget _buildChannelList() {
    return Column(
      children: [
        // Pinned Messages Section
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppTheme.accentColor.withOpacity(0.2),
                AppTheme.accentColor.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppTheme.accentColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.accentColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.push_pin_rounded,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pinned Announcement',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    Text(
                      'Mid-term exams start from Feb 10th',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppTheme.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Section Title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Channels',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textPrimary,
                ),
              ),
              const Spacer(),
              Text(
                '${_channels.length} groups',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Channel List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _channels.length,
            itemBuilder: (context, index) {
              final channel = _channels[index];
              return _buildChannelTile(channel);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChannelTile(Map<String, dynamic> channel) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedChannel = channel['name'];
        });
      },
      child: Container(
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
                color: (channel['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                channel['icon'],
                color: channel['color'],
                size: 26,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        channel['name'],
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        channel['time'],
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          channel['lastMessage'],
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: AppTheme.textSecondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (channel['unread'] > 0) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${channel['unread']}',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${channel['members']} members',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatView() {
    final messages = [
      {'sender': 'Prof. Kumar', 'message': 'Tomorrow\'s lab is shifted to Room 305', 'time': '10:30 AM', 'isMe': false},
      {'sender': 'You', 'message': 'Thank you for the update, sir!', 'time': '10:32 AM', 'isMe': true},
      {'sender': 'Rahul Sharma', 'message': 'What about the assignment submission?', 'time': '10:35 AM', 'isMe': false},
      {'sender': 'Prof. Kumar', 'message': 'Assignment deadline extended to Friday', 'time': '10:40 AM', 'isMe': false},
      {'sender': 'You', 'message': 'Great, thank you!', 'time': '10:41 AM', 'isMe': true},
    ];

    return Column(
      children: [
        // Channel Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedChannel = null;
                  });
                },
                child: const Icon(Icons.arrow_back_rounded),
              ),
              const SizedBox(width: 12),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF5C6BC0).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.computer_rounded,
                  color: Color(0xFF5C6BC0),
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedChannel ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '156 members',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppTheme.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.more_vert_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ),
        // Messages
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final msg = messages[index];
              final isMe = msg['isMe'] as bool;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.75,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppTheme.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(16).copyWith(
                      bottomRight: isMe ? const Radius.circular(4) : null,
                      bottomLeft: !isMe ? const Radius.circular(4) : null,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isMe)
                        Text(
                          msg['sender'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.secondaryColor,
                          ),
                        ),
                      Text(
                        msg['message'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: isMe ? Colors.white : AppTheme.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        msg['time'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: isMe ? Colors.white70 : AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        // Message Input
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file_rounded),
                onPressed: () {},
                color: AppTheme.textSecondary,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    filled: true,
                    fillColor: AppTheme.backgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
