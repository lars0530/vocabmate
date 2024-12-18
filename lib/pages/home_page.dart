import 'package:flutter/material.dart';
import 'package:vocabmate/pages/home_page/about_section.dart';
import 'package:vocabmate/pages/home_page/app_bar.dart';
import 'package:vocabmate/pages/home_page/drawer.dart';
import 'package:vocabmate/pages/home_page/faq_section.dart';
import 'package:vocabmate/pages/home_page/input_section.dart';
import 'package:vocabmate/pages/home_page/pricing_section.dart';
import 'package:vocabmate/widgets/dev_banner.dart';
import 'package:vocabmate/widgets/extensions.dart';
import 'package:vocabmate/widgets/footer.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import '../models/flashcard_model.dart';
import 'dart:convert';

class VocabMateHomePage extends StatefulWidget {
  const VocabMateHomePage({super.key});

  @override
  _VocabMateHomePageState createState() => _VocabMateHomePageState();
}

class _VocabMateHomePageState extends State<VocabMateHomePage> {
  // void _logout() async {
  //   await FirebaseAuth.instance.signOut();
  //   Navigator.of(context).pushReplacementNamed('/sign-in'); // Direct navigation
  // }

  // void _navigateToVocabulary() {
  //   Navigator.pushNamed(context, '/vocabulary-page');
  // }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        appBar: const HomePageAppBar(),
        drawer: context.isMobile ? const HomePageDrawer() : null,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                // Wrapping the widgets around a ConstrainedBox always show the
                // footer at the bottom of the page.
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  child: const Column(
                    children: [
                      DevelopmentBanner(),
                      InputSection(),
                      SizedBox(height: 50),
                      SizedBox(height: 100),
                      PricingSection(),
                      SizedBox(height: 100),
                      AboutSection(),
                      SizedBox(height: 100),
                      FaqSection(),
                      SizedBox(height: 100),
                    ],
                  ),
                ),
                const Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
