import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () {
            Navigator.pop(context); // Detta tar dig tillbaka till MyHomePage
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}