import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naija_med_assistant/core/constant/app_assets.dart';
import 'package:naija_med_assistant/router/route.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _swipeIndex = 0;

  final List<Map<String, String>> _slides = [
    {
      "title": "INSTANT SYMPTOM SUPPORT.\nSMARTER HEALTH DECISIONS.",
      "image": AppImages.onboardingOne
    },
    {
      "title": "AI THAT LISTENS. CARE THAT\nMATTERS",
      "image": AppImages.onboardingTwo
    },
    {
      "title": "QUICK HELP . SMART CARE",
      "image": AppImages.onboardingThree
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _finishOnboarding() {
    // TODO: Persist completion status here
    // LocalStorageUtils().setBool("isFirstTimeUser", true);
    context.go(AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _swipeIndex == _slides.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _slides.length,
              onPageChanged: (index) => setState(() => _swipeIndex = index),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Top Brand Wrapper Section
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.42,
                      color: const Color(0xFF4D2CFA),
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          const Text(
                            "NaijaMed Assistant",
                            style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 60,
                            child: Image.asset(
                              AppImages.logoWhite,
                              fit: BoxFit.contain,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            _slides[index]["title"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Graphical Frame View
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.grey.shade100, // Background fill if asset has transparent details
                        child: Image.asset(
                          _slides[index]["image"]!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          // Control Footer Anchor Toolbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Horizontal Dot Slider Metrics
                Row(
                  children: List.generate(
                    _slides.length,
                        (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 6),
                      height: 6,
                      width: _swipeIndex == index ? 20 : 6,
                      decoration: BoxDecoration(
                        color: _swipeIndex == index ? const Color(0xFF4D2CFA) : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                ),

                // Absolute Square styled buttons matching image text frames
                InkWell(
                  onTap: () {
                    if (isLastPage) {
                      _finishOnboarding();
                    } else {
                      _pageController.animateToPage(
                        _slides.length - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: isLastPage ? Colors.black : Colors.grey.shade400, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLastPage ? "START" : "SKIP",
                          style: TextStyle(
                            color: isLastPage ? Colors.black : Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_double_arrow_right,
                          color: isLastPage ? Colors.black : Colors.grey.shade400,
                          size: 14,
                        )
                      ],
                    ),
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