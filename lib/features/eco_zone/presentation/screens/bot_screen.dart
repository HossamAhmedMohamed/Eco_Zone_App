import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:untitled/core/cache/cache_helper.dart';
import 'package:untitled/core/utils/app_style.dart';
import 'package:untitled/features/eco_zone/data/models/message_model.dart';
import 'package:untitled/features/eco_zone/presentation/widgets/messages.dart';

class BotScreen extends StatefulWidget {
  const BotScreen({super.key});

  @override
  State<BotScreen> createState() => _BotScreenState();
}

class _BotScreenState extends State<BotScreen> {
  final TextEditingController _userMessage = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  static final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  final model = GenerativeModel(model: 'gemini-1.5-pro', apiKey: apiKey);
  
  final List<Message> _messages = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    loadMessagesFromLocal();
  }

  @override
  void dispose() {
    _userMessage.dispose();
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

  Future<void> sendMessage() async {
    final message = _userMessage.text.trim();
    if (message.isEmpty) return;
    
    _userMessage.clear();

    setState(() {
      _messages.add(
        Message(isUser: true, message: message, date: DateTime.now()),
      );
      _isLoading = true;
    });
    
    // Scroll to the bottom after adding user message
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    final content = [Content.text(message)];
    try {
      final response = await model.generateContent(content);
      setState(() {
        _messages.add(
          Message(
            isUser: false,
            message: response.text ?? "No response",
            date: DateTime.now(),
          ),
        );
        _isLoading = false;
      });
      
      // Scroll to the bottom after adding bot response
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
      saveMessagesToLocal();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Fluttertoast.showToast(
        msg: "Error: ${e.toString()}",
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> saveMessagesToLocal() async {
    final List<String> encodedMessages =
        _messages.map(
          (msg) => jsonEncode({
            'isUser': msg.isUser,
            'message': msg.message,
            'date': msg.date.toIso8601String(),
          }),
        ).toList();
    await CacheHelper().saveData(key: 'chatMessages', value: encodedMessages);
  }

  Future<void> loadMessagesFromLocal() async {
    final List<String>? encodedMessages = CacheHelper().getData(
      key: 'chatMessages',
    );

    if (encodedMessages != null && encodedMessages.isNotEmpty) {
      setState(() {
        _messages.clear();
        _messages.addAll(
          encodedMessages.map((str) {
            final json = jsonDecode(str);
            return Message(
              isUser: json['isUser'],
              message: json['message'],
              date: DateTime.parse(json['date']),
            );
          }).toList(),
        );
      });
    }
  }

  void _clearChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Chat'),
        content: const Text('Are you sure you want to clear all messages?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _messages.clear();
              });
              CacheHelper().removeData(key: 'chatMessages');
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Eco-Zone Bot',
          style: AppStyle.styleRegular25W(
            context,
          ).copyWith(color: Colors.white, fontStyle: FontStyle.italic),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white, size: 30),
            onPressed: _clearChat,
          ),
        ],
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'Welcome to Eco-Zone Bot',
                            textAlign: TextAlign.center,
                            style: AppStyle.styleBold35(context).copyWith(
                              color: Colors.deepPurple,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ask me anything?',
                          style: AppStyle.styleRegular25W(context).copyWith(
                            color: Colors.deepPurple,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      return Messages(
                        isUser: message.isUser,
                        message: message.message,
                        date: DateFormat.jm().format(message.date),
                      );
                    },
                  ),
          ),
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _userMessage,
                    decoration: InputDecoration(
                      hintText: "Ask Eco...",
                      hintStyle: AppStyle.styleRegular17(context),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                    textCapitalization: TextCapitalization.sentences,
                    maxLines: null,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.deepPurple,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send, color: Colors.white),
                    tooltip: 'Send message',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}