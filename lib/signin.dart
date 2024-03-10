import 'package:companion/HomeScreen/activityfeed.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'signup.dart';
import 'package:companion/ForgotPasswordScreen.dart';

void main() {
  runApp(const SignIn());
}

class SignIn extends StatelessWidget {
  const SignIn({super.key});
  static const Color coral = Color(0xFFFF7F50);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign In Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        buttonTheme: const ButtonThemeData(buttonColor: coral),
      ),
      home: const SignInScreen(),
    );
  }
}

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a custom coral color
    const Color coral = Color(0xFFFF7F50);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SignUp())),
        ),
        title: const Text('Hello again!'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Continue with Google
            SignInButton(
              icon: FontAwesomeIcons.google,
              text: 'Continue with Google',
              color: Colors.blue,
              onPressed: () {},
            ),
            const SizedBox(height: 8.0),
            // Continue with Facebook
            SignInButton(
              icon: FontAwesomeIcons.facebook,
              text: 'Continue with Facebook',
              color: Colors.blue.shade800,
              onPressed: () {},
            ),
            const SizedBox(height: 8.0),
            // Continue with GitHub
            SignInButton(
              icon: FontAwesomeIcons.github,
              text: 'Continue with GitHub',
              color: Colors.black,
              onPressed: () {},
            ),
            const SizedBox(height: 24.0), // Increased space for error message
            // Error message placeholder (use a Visibility widget to show/hide)
            const SizedBox(
              height: 20.0,
              child: Center(
                child: Text(
                  '', // Your error message here
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
            // Email input
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8.0),
            // Password input
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            // Log in button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: coral, // Use the custom coral color
                shape: RoundedRectangleBorder( // Rounded rectangle shape
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
             Navigator.of(context).push(
               MaterialPageRoute(builder: (context) => const ActivityFeedScreen()));
              },
              child: const Text(
                'Log in',
                style: TextStyle(color: Colors.white), // Text color to white
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()));
              },
              child: const Text(
                'Forgot password?',
                style: TextStyle(color: Colors.white), // Text color to white
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: const Text(
                'Don’t have an account? Sign up',
                style: TextStyle(color: Colors.white), // Text color to white
              ),
            ),
            const SizedBox(height: 16.0),
            // Terms and Policies
            const Text(
              'By continuing, you agree to our Terms of Service and Privacy Policy.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const SignInButton({
  super.key,
  required this.icon,
  required
  this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20.0),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Button background color
        foregroundColor: Colors.white, // Text and icon color
        padding: const EdgeInsets.all(12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0), // Circular edges
        ),
      ),
      onPressed: onPressed,
    );
  }
}
