import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:vocabmate/config.dart';
import 'package:vocabmate/models/flashcard_model.dart';

class OpenAIService {
  static Future<List<FlashCard>> generateAnkiCards(
    String userId,
    String userText,
    String model,
    String explanationLanguage,
    int numOfCards,
  ) async {
    final url = '${Config.baseUrl}/generate-anki-cards';
    print(url);
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'firebase_uid': userId,
        'text': userText,
        'model': model,
        'explanation_language': explanationLanguage,
        'num_of_cards': numOfCards
      }),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      final List<FlashCard> flashCards = (jsonResponse['flashcards'] as List)
          .map<FlashCard>((data) => FlashCard.fromJson(data))
          .toList();
      return flashCards;
    } else {
      throw Exception(
          'Failed to load response (error code: ${response.statusCode}): ${response.body}');
    }
  }

  Future<String> sendDummyMessage(String message) async {
    List<String> dummyMessages = [
      "Message received successfully.",
      "Your request has been processed.",
      "Action completed without errors.",
      "Thank you for your message.",
      "Your message has been recorded.",
      "Operation completed successfully.",
      "The process is complete.",
      "We have received your submission.",
      "Your entry has been logged.",
      "Task executed perfectly."
    ];

    // Generate a random index to select a message from the list
    int index = Random().nextInt(dummyMessages.length);

    // Return the randomly selected message
    return dummyMessages[index];
  }

  Future<String> generateTestFlashcards() async {
    // Return a dummy JSON response
    final List<Map<String, dynamic>> dummyFlashcards = [
      {
        "index": 1,
        "question":
            "What is the meaning of 'Milch' in the context of 'Ich trinke Milch'?",
        "answer": "The meaning/translation of 'Milch' is milk.",
        "vocabulary_language": "German",
        "explanation_language": "English",
        "vocab_word": "Milch",
        "vocab_meaning": "milk"
      },
      {
        "index": 2,
        "question":
            "What is the meaning of 'Hund' in the context of 'Der Hund bellt'?",
        "answer": "The meaning/translation of 'Hund' is dog.",
        "vocabulary_language": "German",
        "explanation_language": "English",
        "vocab_word": "Hund",
        "vocab_meaning": "dog"
      },
      // Add more dummy flashcards as needed
    ];

    return jsonEncode(dummyFlashcards);
  }
}
