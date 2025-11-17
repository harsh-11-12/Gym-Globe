import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/chatScreen.dart';

// --- Data Model for a Chat ---
class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String avatarUrl;
  final String role; // e.g., 'Trainer', 'Gym Owner', 'User'

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.avatarUrl,
    required this.role,
  });
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Chat> _allChats = [];
  List<Chat> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    // 1. Initialize with dummy data
    _allChats = _generateDummyChats();
    // 2. Initially, show all chats
    _filteredChats = _allChats;
    // 3. Add listener for search input changes
    _searchController.addListener(_filterChats);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterChats);
    _searchController.dispose();
    super.dispose();
  }

  // --- Search Filtering Logic ---
  void _filterChats() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredChats = _allChats.where((chat) {
        // Search by name or role
        return chat.name.toLowerCase().contains(query) ||
            chat.role.toLowerCase().contains(query);
      }).toList();
    });
  }

  // --- Dummy Data Generator ---
  List<Chat> _generateDummyChats() {
    return [
      Chat(
        id: 'c001',
        name: 'Alex Johnson',
        lastMessage: 'Ready for the next session?',
        avatarUrl: 'assets/avatar_trainer.png',
        role: 'Trainer',
      ),
      Chat(
        id: 'c002',
        name: 'Gold Gym NYC',
        lastMessage: 'Our new class schedule is out!',
        avatarUrl: 'assets/avatar_gym.png',
        role: 'Gym Owner',
      ),
      Chat(
        id: 'c003',
        name: 'Sarah Connor',
        lastMessage: 'Got it, see you tomorrow.',
        avatarUrl: 'assets/avatar_user1.png',
        role: 'User',
      ),
      Chat(
        id: 'c004',
        name: 'FitPro Team',
        lastMessage: 'Your membership is active.',
        avatarUrl: 'assets/avatar_trainer2.png',
        role: 'Trainer',
      ),
    ];
  }

  // --- Action when a chat is tapped ---
  void _openChat(Chat chat) {
    Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => ChatScreen(chat: chat),
    ),
  );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('💬 Chats'), elevation: 0),
      body: Column(
        children: <Widget>[
          // 1. Search Bar (Padding for visual appeal)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search chats by name or role...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none, // Make border less prominent
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),

          const Divider(height: 1, thickness: 1),

          // 2. Chat List View
          Expanded(
            child: _filteredChats.isEmpty
                ? const Center(
                    child: Text('No chats found matching your search.'),
                  )
                : ListView.builder(
                    itemCount: _filteredChats.length,
                    itemBuilder: (context, index) {
                      final chat = _filteredChats[index];
                      return _ChatListItem(
                        chat: chat,
                        onTap: () => _openChat(chat),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widget for a single Chat Item ---
class _ChatListItem extends StatelessWidget {
  final Chat chat;
  final VoidCallback onTap;

  const _ChatListItem({required this.chat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        // Placeholder for an actual image
        backgroundColor: chat.role == 'Trainer'
            ? Colors.blue.shade100
            : chat.role == 'Gym Owner'
            ? Colors.green.shade100
            : Colors.purple.shade100,
        child: Text(
          chat.name.substring(0, 1),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        // In a real app, use Image.network(chat.avatarUrl) or AssetImage
      ),
      title: Text(
        chat.name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '${chat.lastMessage}\n(${chat.role})',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      isThreeLine:
          true, // Allows for the role on the second line of the subtitle
    );
  }
}

// --- Main function to run the app (for testing) ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ChatPage(),
    );
  }
}
