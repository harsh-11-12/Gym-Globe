import 'package:flutter/material.dart';
import 'package:gym_globe/pages/common%20pages/chatPage.dart';

// Assuming your Chat Model is defined like this (copied from previous response)

// --- Message Model ---
class Message {
  final String text;
  final bool isMe; // True if the message is sent by the current user

  Message({required this.text, required this.isMe});
}

class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // Initial list of dummy messages
  List<Message> _messages = [
    Message(
      text: 'Hey ${null}',
      isMe: false,
    ), // Placeholder for the contact's name
    Message(text: 'I saw your last workout plan.', isMe: false),
    Message(text: 'Looks great! I’m targeting a 5K soon.', isMe: true),
    Message(
      text: 'That’s awesome! Let’s adjust your cardio then.',
      isMe: false,
    ),
    Message(text: 'Sounds good!', isMe: true),
  ];

  @override
  void initState() {
    super.initState();
    // Replace the first message placeholder with the contact's name
    _messages[0] = Message(text: 'Hey ${widget.chat.name}!', isMe: false);
    // Scroll to the bottom when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  // --- Send Message Logic ---
  void _handleSubmitted(String text) {
    if (text.trim().isEmpty) return;

    _messageController.clear();
    setState(() {
      _messages.add(Message(text: text, isMe: true));
    });

    // Scroll to the bottom immediately after adding the new message
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.chat.name),
            Text(
              widget.chat.role,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        // Optional: Add the user's avatar to the AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              child: Text(widget.chat.name.substring(0, 1)),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // 1. Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(8.0),
              itemCount: _messages.length,
              itemBuilder: (_, int index) =>
                  _ChatMessage(message: _messages[index]),
            ),
          ),
          const Divider(height: 1.0),
          // 2. Message Input Area
          _buildTextComposer(),
        ],
      ),
    );
  }

  // --- Input Widget ---
  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _messageController,
              onSubmitted: _handleSubmitted,
              decoration: const InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }
}

// --- Custom Widget for a single Chat Bubble ---
class _ChatMessage extends StatelessWidget {
  final Message message;

  const _ChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    // Determine alignment and color based on who sent the message
    final alignment = message.isMe
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start;
    final color = message.isMe ? Colors.blue.shade500 : Colors.grey.shade300;
    final textColor = message.isMe ? Colors.white : Colors.black;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          // The message bubble
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0),
                bottomLeft: message.isMe
                    ? const Radius.circular(15.0)
                    : const Radius.circular(5.0),
                bottomRight: message.isMe
                    ? const Radius.circular(5.0)
                    : const Radius.circular(15.0),
              ),
            ),
            child: Text(message.text, style: TextStyle(color: textColor)),
          ),
        ],
      ),
    );
  }
}
