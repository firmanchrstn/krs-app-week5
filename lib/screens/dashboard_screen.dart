import 'package:flutter/material.dart';
import 'profile_screen.dart'; 
import 'login_screen.dart';
import 'krs_screen.dart'; // <--- JANGAN LUPA IMPORT INI

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Mahasiswa"),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 80, color: Colors.blue),
              const SizedBox(height: 20),
              const Text("Selamat Datang!", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              
              // Tombol ke Profil
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  icon: const Icon(Icons.person),
                  label: const Text("Lihat Profil Saya"),
                ),
              ),
              
              const SizedBox(height: 15),

              // --- TOMBOL MENU BARU (TUGAS WEEK 4) ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white
                  ),
                  onPressed: () {
                    // Navigasi ke KrsScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const KrsScreen()),
                    );
                  },
                  icon: const Icon(Icons.book),
                  label: const Text("Isi KRS (Tugas Week 4)"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}