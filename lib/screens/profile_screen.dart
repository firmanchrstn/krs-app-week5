import 'package:flutter/material.dart';
import 'krs_screen.dart';

class ProfileScreen extends StatelessWidget {
  final String userName;
  final String userId;

  const ProfileScreen({
    super.key, 
    this.userName = "Firman Christian Purba", 
    this.userId = "0520230003", 
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Colors.blue[100],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 3),
                ),
                child: const Icon(Icons.person, size: 100, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              
              Text(
                userName,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "Student ID: $userId", 
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const KrsScreen()),
                  );
                },
                icon: const Icon(Icons.list_alt),
                label: const Text("View Study Plan (KRS)"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}