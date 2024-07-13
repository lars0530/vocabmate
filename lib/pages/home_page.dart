import 'package:flutter/material.dart';
import 'package:vocabmate/pages/home_page/about_section.dart';
import '../services/chatgpt_service.dart';
import '../services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import '../models/flashcard_model.dart';
import 'dart:convert';

class VocabMateHomePage extends StatefulWidget {
  const VocabMateHomePage({super.key});

  @override
  _VocabMateHomePageState createState() => _VocabMateHomePageState();
}

class _VocabMateHomePageState extends State<VocabMateHomePage> {
  final TextEditingController _controller = TextEditingController();
  final ChatGptService _chatGptService = ChatGptService();
  final UserService _userService = UserService();
  bool _isLoading = false;
  bool _isPremium = false;

  @override
  void initState() {
    super.initState();
    _fetchPremiumStatus();
  }

  void _fetchPremiumStatus() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        final isPremium = await _userService.isPremium(userId);
        setState(() {
          _isPremium = isPremium;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error retrieving premium status: $e')),
        );
      }
    }
  }

  void _sendMessage() async {
    setState(() {
      _isLoading = true;
    });

    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    try {
      final response =
          await _chatGptService.sendMessage(userId, _controller.text);
      final List<dynamic> jsonResponse = jsonDecode(response);
      final List<FlashCard> flashCards =
          jsonResponse.map((data) => FlashCard.fromJson(data)).toList();

      Navigator.pushNamed(
        context,
        '/flashcard-page',
        arguments: {'inputText': _controller.text, 'flashCards': flashCards},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _makeUserPremium() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    try {
      await _userService.upgradeToPremium(userId);
      setState(() {
        _isPremium = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is now premium.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error making user premium: $e')),
      );
    }
  }

  void _makeUserNotPremium() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    try {
      await _userService.downgradeToFree(userId);
      setState(() {
        _isPremium = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User is no longer premium.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error making user not premium: $e')),
      );
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/sign-in'); // Direct navigation
  }

  void _navigateToVocabulary() {
    Navigator.pushNamed(context, '/vocabulary-page');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vocabmate'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
          IconButton(
            icon: const Icon(Icons.book),
            onPressed: _navigateToVocabulary,
            tooltip: 'Vocabulary',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              _isPremium ? 'PREMIUM' : 'Not Premium',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8.0),
            TextField(
              controller: _controller,
              decoration:
                  const InputDecoration(labelText: 'Enter your message'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendMessage,
              child: const Text('Generate Flashcards'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _makeUserPremium,
              child: const Text('Make User Premium'),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _makeUserNotPremium,
              child: const Text('Make User Not Premium'),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const CircularProgressIndicator()
                : const Text('Enter a message to generate flashcards'),
            const AboutSection()
          ],
        ),
      ),
    );
  }
}
