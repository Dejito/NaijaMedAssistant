import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/router/route.dart';

import '../views/widgets/titleText.dart';

// Simple model to hold individual symptom chips dynamically
class SymptomItem {
  final String id;
  final String name;
  final String emoji;

  SymptomItem({
    required this.id,
    required this.name,
    required this.emoji,
  });
}

class AISymptomChecker extends StatefulWidget {
  static const route = '/ai-symptom-checker';

  const AISymptomChecker({super.key});

  @override
  State<AISymptomChecker> createState() => _AISymptomCheckerState();
}

class _AISymptomCheckerState extends State<AISymptomChecker> {
  final TextEditingController _symptomController = TextEditingController();
  final List<SymptomItem> _selectedSymptoms = [];

  // Pool of medical/expressive emojis to pull from randomly
  final List<String> _emojiPool = ['🤒', '🤢', '🤮', '🤕', '😴', '🥵', '🥶', '😷', '💩', '🧠', '🫁', '🫀'];

  @override
  void dispose() {
    _symptomController.dispose();
    super.dispose();
  }

  void _addSymptom() {
    final text = _symptomController.text.trim();
    if (text.isEmpty) return;

    // Check for duplicates to maintain list hygiene
    if (_selectedSymptoms.any((element) => element.name.toLowerCase() == text.toLowerCase())) {
      _symptomController.clear();
      return;
    }

    final randomEmoji = _emojiPool[Random().nextInt(_emojiPool.length)];

    setState(() {
      _selectedSymptoms.add(
        SymptomItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: text,
          emoji: randomEmoji,
        ),
      );
      _symptomController.clear();
    });

    // Hide the soft keyboard after a symptom is added (without popping the screen).
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _removeSymptom(String id) {
    setState(() {
      _selectedSymptoms.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 1. Keep this true. The Scaffold will automatically resize its body height
      // when the soft keyboard appears.
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: titleText(
          'AI Symptom Checker',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.5),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        // 2. Removed "+ keyboardInset". Standard static padding is all you need.
        padding: const EdgeInsets.all(16.0),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Top Graphic Card Box Feature ---
            Container(
              width: double.infinity,
              height: 220,
              decoration: BoxDecoration(
                color: const Color(0xFFC5C0F6), // Matches soft violet gradient layout frame
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Replace with your 3D robot illustration asset if available
                  const Positioned(
                    top: 20,
                    child: Icon(Icons.smart_toy_outlined, size: 90, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 30,
                    child: Text(
                      "Welcome to our AI-powered Symptom\nChecker",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.85),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // --- 2. Input Field Header ---
            const Text(
              "Enter your symptoms",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
            ),
            const SizedBox(height: 6),

            TextFormField(
              controller: _symptomController,
              style: const TextStyle(fontSize: 14),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _addSymptom(),
              decoration: InputDecoration(
                hintText: "e.g. Cough, Fever",
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Color(0xFF4D2CFA), width: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "Please describe your symptoms in detail.",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
            ),

            const SizedBox(height: 16),

            // --- 3. Action Append Button ---
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _addSymptom,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D2CFA),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
                child: const Text(
                  "ENTER",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- 4. Dynamic Token Grid Selection ---
            if (_selectedSymptoms.isNotEmpty) ...[
              const Text(
                "Selected Symptoms",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
              ),
              const SizedBox(height: 12),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.8,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: _selectedSymptoms.length,
                itemBuilder: (context, index) {
                  final item = _selectedSymptoms[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(item.emoji, style: const TextStyle(fontSize: 16)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _removeSymptom(item.id),
                          child: Icon(Icons.cancel_outlined, size: 18, color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 30),

            // --- 5. Forward Flow Progression Navigation Action ---
            Center(
              child: InkWell(
                onTap: () {
                  context.push(AppRoutes.aiSymptomResultScreen);
                },
                borderRadius: BorderRadius.circular(24),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "PROCEED",
                        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, letterSpacing: 0.5, color: Colors.black),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFF4D2CFA),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // 3. Optional: Extra spacing at the very bottom so users can scroll
            // the "Proceed" button explicitly above the keyboard if needed.
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }}