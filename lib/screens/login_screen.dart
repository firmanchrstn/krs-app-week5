import 'package:flutter/material.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isSignUpMode = false;

  void _handleAuth() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (_isSignUpMode) {
      String name = _nameController.text.trim();
      String confirmPassword = _confirmPasswordController.text.trim();

      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        _showMessage("All fields are required", Colors.red);
        return;
      }
      if (password != confirmPassword) {
        _showMessage("Passwords do not match", Colors.red);
        return;
      }

      setState(() {
        _isSignUpMode = false;
        _clearControllers();
      });
      _showMessage("Registration Successful! Please Login", Colors.green);
    } else {
      if (email.isEmpty || password.isEmpty) {
        _showMessage("Email and Password are required", Colors.red);
        return;
      }
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    }
  }

  void _clearControllers() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
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
        title: Text(_isSignUpMode ? "Sign Up" : "Login"),
        centerTitle: true,
        backgroundColor: Colors.blue[100],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Icon(
                _isSignUpMode ? Icons.person_add : Icons.lock_person,
                size: 80,
                color: Colors.blue,
              ),
              const SizedBox(height: 30),
              
              if (_isSignUpMode) ...[
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 15),
              ],

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email Addreses",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 15),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 15),

              if (_isSignUpMode) ...[
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.check_circle),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleAuth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(_isSignUpMode ? "Sign Up Now" : "Login"),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(_isSignUpMode ? "Already have an account?" : "Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUpMode = !_isSignUpMode;
                        _clearControllers();
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
          ),
        ),
      ),
    );
  }
}