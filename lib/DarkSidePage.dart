import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DarkSidePage extends StatefulWidget {
  const DarkSidePage({super.key});

  @override
  _DarkSidePageState createState() => _DarkSidePageState();
}

class _DarkSidePageState extends State<DarkSidePage> {

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _newsletter = true;

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
      _saveToFirebase();
    }
  }

  @override
  void dispose() {

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
            'assets/images/darthvader.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Join the Dark Side!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),


                    TextFormField(
                      controller: _firstNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person, color: Colors.white),
                        hintText: 'Enter your first name',
                        labelText: 'First Name *',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),


                    TextFormField(
                      controller: _lastNameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person_outline, color: Colors.white),
                        hintText: 'Enter your last name',
                        labelText: 'Last Name *',
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),


                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email, color: Colors.white),
                        hintText: 'Enter your email address',
                        labelText: 'Email *',
                        labelStyle: TextStyle(color: Colors.white),
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


                    TextFormField(
                      controller: _numberController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone, color: Colors.white),
                        hintText: 'Enter your phone number',
                        labelText: 'Phone Number *',
                        labelStyle: TextStyle(color: Colors.white),
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
                        const Text('Dark Side', style: TextStyle(color: Colors.white)),
                      ],
                    ),

                    const SizedBox(height: 20),


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
