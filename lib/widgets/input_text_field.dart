import 'package:flutter/material.dart';
import 'package:vocabmate/widgets/theme.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    this.isEnabled = true,
    this.hintText = '''Create your own Language Flashcards in three simple steps
Step 1 - Copy the text you want to create flashcards for and paste it into this text field.
Step 2 - Select the explanation language through the options button.
Step 3 - Generate your new set of vocabulary cards.''',
  });

  final TextEditingController controller;
  final bool isEnabled;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: mediumViolet,
        width: 2,
      ),
    );
    return TextField(
      controller: controller,
      autofocus: true,
      decoration: InputDecoration(
          focusedBorder: border,
          enabledBorder: border,
          disabledBorder: border,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.normal)),
      minLines: 6,
      maxLines: 12,
      enabled: isEnabled,
      keyboardType: TextInputType.multiline,
    );
  }
}
