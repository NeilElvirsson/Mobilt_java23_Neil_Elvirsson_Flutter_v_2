import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Bild
            Image.network(
              'https://media.giphy.com/media/xT9IgG50Fb7Mi0prBC/giphy.gif', // Direkt URL till GIF
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20), // Lägger till lite mellanrum mellan bilden och knappen
            // Knapp
            FilledButton(
              onPressed: () {
                Navigator.pop(context); // Detta tar dig tillbaka till MyHomePage
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}