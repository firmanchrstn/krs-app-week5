import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final List<String> _registeredEmails = ['admin@gmail.com']; 
  bool _isSignUpMode = false; 
  bool _isOtpSent = false;    
  final String _mockOtp = "1234"; 
  void _handleSignUp() {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains("@gmail.com")) {
      _showMessage("Please enter a valid Gmail address", Colors.red);
      return;
    }

    if (_registeredEmails.contains(email)) {
      _showMessage("Email is already registered. Please Sign In.", Colors.orange);
    } else {
      setState(() {
        _registeredEmails.add(email);
        _isSignUpMode = false; 
        _emailController.clear(); 
      });
      _showMessage("Registration Successful! Please Sign In.", Colors.green);
    }
  }

  void _sendVerificationCode() {
    String email = _emailController.text.trim();

    if (email.isEmpty || !email.contains("@gmail.com")) {
      _showMessage("Please enter a valid Gmail address", Colors.red);
      return;
    }

    if (_registeredEmails.contains(email)) {
      setState(() {
        _isOtpSent = true;
      });
      _showMessage("OTP sent to $email (Code: 1234)", Colors.green);
    } else {
      _showMessage("Email not registered! Please Sign Up first.", Colors.red);
    }
  }

  void _verifyOtp() {
    if (_otpController.text == _mockOtp) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } else {
      _showMessage("Invalid Code. Try again.", Colors.red);
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUpMode ? "Create Account" : "Login"),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Icon(
                _isSignUpMode ? Icons.person_add : Icons.lock_person, 
                size: 80, 
                color: Colors.blue
              ),
              const SizedBox(height: 30),
              
              if (_isOtpSent) ...[
                Text(
                  "Enter code sent to ${_emailController.text}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "4-Digit Code",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                    child: const Text("Verify & Enter"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isOtpSent = false;
                      _otpController.clear();
                    });
                  },
                  child: const Text("Cancel / Change Email"),
                )

              ] else ...[
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: _isSignUpMode ? "Register New Gmail" : "Enter Registered Gmail",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 20),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _isSignUpMode ? _handleSignUp : _sendVerificationCode,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_isSignUpMode ? "Sign Up Now" : "Get Verification Code"),
                  ),
                ),
                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isSignUpMode ? "Already have an account?" : "Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignUpMode = !_isSignUpMode;
                          _emailController.clear();
                        });
                      },
                      child: Text(
                        _isSignUpMode ? "Sign In" : "Sign Up",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}