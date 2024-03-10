// Importing necessary packages
import 'package:companion/signup.dart'; // Assuming a custom widget for navigation
import 'package:flutter/material.dart';

// Main entry point of the application
void main() {
  runApp(const ESignUp());
}

// StatelessWidget for the main application
class ESignUp extends StatelessWidget {
  // Constructor with Key
  const ESignUp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp as the root widget of the app
    return MaterialApp(
      title: 'Sign Up Demo',
      theme: ThemeData(
        // Setting theme for the app
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const SignUpScreen(), // Setting SignUpScreen as the home screen
    );
  }
}

// StatefulWidget for the sign-up screen
class SignUpScreen extends StatefulWidget {
  // Constructor with Key
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

// State class for SignUpScreen
class _SignUpScreenState extends State<SignUpScreen> {
  // Form key to validate the form
  final _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Variables for managing user inputs
  DateTime? selectedDate;
  String? selectedGender;
  final List<String> genders = ['Male', 'Female', 'Other']; // Gender options

  // Function to present a date picker and handle the date selection
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color coral = Color(0xFFFF7F50); // Custom color for the sign-up button

    return Scaffold(
      appBar: AppBar(
        // AppBar configuration
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignUp())),
        ),
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              // Text field for name input
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              // Text field for email input
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              // Text field for password input
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              // Widget for birthdate selection
              ListTile(
                title: Text(
                  selectedDate == null ? 'Birthdate' : 'Birthdate: ${selectedDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context),
              ),
              const SizedBox(height: 8.0),
              // Dropdown for gender selection
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: const Text('Gender'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a gender' : null,
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16.0),
              // Sign-up button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: coral,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Show a snackbar on valid form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    // Sign-up logic would go here
                  }
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 8.0),
              // Additional informational text
              const Text(
                'Your name will be public and we’ll send updates to the email address you provide. Age and gender help improve recommendations, and unlock event and group details.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose controllers when the widget is removed from the widget tree
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
