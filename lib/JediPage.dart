import 'package:flutter/material.dart';

class JediPage extends StatelessWidget {
  const JediPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image for Jedi page
          Image.asset(
            'assets/images/jedi.webp', // Replace with your Jedi background image URL
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome to the Jedi Side!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Additional content for Jedi side
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/jedi.webp', // Replace with your Jedi character image URL
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
