import 'package:flutter/material.dart';

class DarkSidePage extends StatelessWidget {
  const DarkSidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for Dark Side page
          Image.asset(
            'assets/images/darthvader.jpg', // Replace with your Dark Side background image URL
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to the Dark Side!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Additional content for Dark Side
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/darthvader.jpg', // Replace with your Dark Side character image URL
                  width: 200,
                  height: 200,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to HomePage
                  },
                  child: const Text('Back to Home'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
