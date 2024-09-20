import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JediPage extends StatefulWidget {
  const JediPage({super.key});

  @override
  _JediPageState createState() => _JediPageState();
}

class _JediPageState extends State<JediPage> {
  // Controllers för varje fält
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  // Form key för validering
  final _formKey = GlobalKey<FormState>();

  // Checkbox state
  bool _newsletter = true;

  // Funktion för att hantera när formuläret skickas
  Future<void> _saveToFirebase() async {
    if (_formKey.currentState!.validate()) {
      // Skicka data till Firestore
      CollectionReference users = FirebaseFirestore.instance.collection('users');
      await users.add({
        'first_name': _firstNameController.text,
        'last_name': _lastNameController.text,
        'email': _emailController.text,
        'phone': _numberController.text,
        'newsletter': _newsletter,
      });

      print('Data sent to Firestore:');
      print('First Name: ${_firstNameController.text}');
      print('Last Name: ${_lastNameController.text}');
      print('Email: ${_emailController.text}');
      print('Phone: ${_numberController.text}');
      print('Newsletter: $_newsletter');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved to Firebase')),
      );
    }
  }


  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String firstName = _firstNameController.text;
      String lastName = _lastNameController.text;
      String email = _emailController.text;
      String number = _numberController.text;
      bool newsletter = _newsletter;

      _saveToFirebase();



      // Skicka till Firebase eller annan hantering här
    }
  }

  @override
  void dispose() {
    // Glöm inte att rensa kontrollern när de inte längre behövs
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/jedi.webp',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView( // Scrolla om sidan är lång
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Welcome to the Jedi Side!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Förnamn
                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        hintText: 'Enter your first name',
                        labelText: 'First Name *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),

                    // Efternamn
                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline),
                        hintText: 'Enter your last name',
                        labelText: 'Last Name *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),

                    // E-postadress
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        hintText: 'Enter your email address',
                        labelText: 'Email *',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    // Telefonnummer
                    TextFormField(
                      controller: _numberController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone Number *',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Nyhetsbrev Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _newsletter,
                          onChanged: (bool? value) {
                            setState(() {
                              _newsletter = value ?? false;
                            });
                          },
                        ),
                        const Text('Jedi Side', style: TextStyle(color: Colors.white)),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Skicka-knapp
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Submit'),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
