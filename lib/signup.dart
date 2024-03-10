import 'package:companion/esignup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'onboarding.dart';
import 'signin.dart';

void main() {
  runApp(const SignUp());
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.black12, // Lighter shade of blue
        ),
      ),
      home: const SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  Widget buildCustomSignInButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required BuildContext context,
  }) {
    // Responsive adjustments
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonHeight = screenWidth > 600 ? 60.0 : 50.0;
    double fontSize = screenWidth > 600 ? 20.0 : 18.0;
    double iconSize = screenWidth > 600 ? 28.0 : 24.0;
    double paddingVertical = screenWidth > 600 ? 16.0 : 12.0;

    return ElevatedButton.icon(
      icon: Icon(icon, size: iconSize),
      label: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: paddingVertical),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 2.0,
        minimumSize: Size(double.infinity, buttonHeight),
      ),
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Onboarding()),
          ),
        ),
        title: const Text('Sign up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'assets/logo1.png',
                  height: 70,
                  // Adjust the size according to your needs
                ),
                const SizedBox(height: 150), // Space between logo and buttons
                buildCustomSignInButton(
                  text: '     Continue with Google',
                  icon: FontAwesomeIcons.google,
                  backgroundColor: Colors.blue.shade600,
                  onPressed: () {}, // Empty callback
                  context: context,
                ),
                const SizedBox(height: 8.0),
                buildCustomSignInButton(
                  text: '     Continue with Github',
                  icon: FontAwesomeIcons.github,
                  backgroundColor: Colors.black,
                  onPressed: () {}, // Empty callback
                  context: context,
                ),
                const SizedBox(height: 8.0),
                buildCustomSignInButton(
                  text: '     Continue with Email',
                  icon: Icons.email,
                  backgroundColor: Colors.grey.shade700,
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const ESignUp()));
                  },
                  context: context,
                ),
                const SizedBox(height: 8.0),
                buildCustomSignInButton(
                  text: 'Continue with Facebook',
                  icon: Icons.facebook,
                  backgroundColor: const Color(0xFF1877F2),
                  onPressed: () {}, // Empty callback
                  context: context,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SignIn()));
                    },
                    child: const Text('Already have an account? Sign in', style: TextStyle(fontSize: 19)),
                  ),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}