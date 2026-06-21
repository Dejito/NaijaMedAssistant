import 'package:flutter/material.dart';


class DoctorConnectionScreen extends StatefulWidget {

  const DoctorConnectionScreen({super.key});

  @override
  State<DoctorConnectionScreen> createState() => _DoctorConnectionScreenState();
}

class _DoctorConnectionScreenState extends State<DoctorConnectionScreen> {
  // Toggle this flag to test both views seamlessly
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Optional: Simulating an automated socket or API connection after 3 seconds
    _simulateConnection();
  }

  void _simulateConnection() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: _isLoading ? _buildLoadingState() : _buildConnectedState(),
      ),
    );
  }

  // --- Left Side: Waiting/Connecting State ---
  Widget _buildLoadingState() {
    return Center(
      key: const ValueKey('LoadingState'),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // The brand asset icon centered
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF0EDFF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add_moderator_outlined, // Fallback icon resembling your custom asset
                size: 80,
                color: Color(0xFF4D2CFA),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              "Please wait, you’re being connected...",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // Floating utility button to manually toggle during testing
            const SizedBox(height: 40),
            TextButton(
              onPressed: () => setState(() => _isLoading = false),
              child: Text("Simulate Connected State", style: TextStyle(color: Colors.grey.shade400)),
            )
          ],
        ),
      ),
    );
  }

  // --- Right Side: Doctor Connected Confirmation State ---
  Widget _buildConnectedState() {
    return Center(
      key: const ValueKey('ConnectedState'),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              "You have been connected with",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 0.3,
              ),
            ),
            const SizedBox(height: 24),

            // Doctor profile photo container with perfect structural rings
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.5),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey,
                backgroundImage:
                NetworkImage(
                  'https://images.unsplash.com/photo-1594824813573-246434e33963?auto=format&fit=crop&q=80&w=200',
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Dr Balogun",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const Spacer(),

            // Core Forward Action Flow Trigger Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  // Direct user forward to secondary direct interaction screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D2CFA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Start Chat",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),

            // Floating utility back-toggle button for effortless testing runtime
            TextButton(
              onPressed: () => setState(() => _isLoading = true),
              child: Text("Back to Loading View", style: TextStyle(color: Colors.grey.shade400)),
            )
          ],
        ),
      ),
    );
  }
}