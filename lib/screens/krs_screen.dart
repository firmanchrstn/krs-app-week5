import 'package:flutter/material.dart';
import 'krs_detail_screen.dart'; // Pastikan import sesuai nama file

class KrsScreen extends StatefulWidget {
  const KrsScreen({super.key});

  @override
  State<KrsScreen> createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  // Data mata kuliah
  final List<Map<String, dynamic>> _courseList = [
    {"id": 1, "name": "Pemrograman Mobile", "sks": 3, "isMandatory": true, "selected": false},
    {"id": 2, "name": "Struktur Data", "sks": 4, "isMandatory": true, "selected": false},
    {"id": 3, "name": "Basis Data", "sks": 3, "isMandatory": true, "selected": false},
    {"id": 4, "name": "Kewirausahaan", "sks": 2, "isMandatory": false, "selected": false},
    {"id": 5, "name": "Etika Profesi", "sks": 2, "isMandatory": false, "selected": false},
    {"id": 6, "name": "Bahasa Inggris Tech", "sks": 2, "isMandatory": false, "selected": false},
    {"id": 7, "name": "Sistem Operasi", "sks": 3, "isMandatory": true, "selected": false},
    {"id": 8, "name": "Cloud Computing", "sks": 4, "isMandatory": false, "selected": false},
  ];

  // Logic Bisnis: Batas SKS berdasarkan IPK (Option C)
  double gpa = 3.5; 
  int get maxSks => gpa >= 3.0 ? 24 : 20;

  int get totalSks {
    return _courseList
        .where((course) => course['selected'])
        .fold(0, (sum, item) => sum + (item['sks'] as int));
  }

  bool get hasMandatorySelected {
    return _courseList.any((course) => course['selected'] && course['isMandatory']);
  }

  void _validateAndSubmit() {
    if (totalSks == 0) {
      _showSnackBar("Silakan pilih minimal satu mata kuliah.", Colors.orange);
    } else if (totalSks > maxSks) {
      _showSnackBar("Gagal! Total SKS ($totalSks) melebihi batas maksimal $maxSks.", Colors.red);
    } else if (!hasMandatorySelected) {
      _showSnackBar("Gagal! Anda wajib memilih minimal satu mata kuliah Mandatory.", Colors.red);
    } else {
      // Navigasi ke halaman detail (Option B)
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KrsDetailScreen(),
          settings: RouteSettings(
            arguments: {
              'selectedCourses': _courseList.where((c) => c['selected']).toList(),
              'totalSks': totalSks,
            },
          ),
        ),
      );
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Input KRS"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            color: totalSks > maxSks ? Colors.red.shade50 : Colors.blue.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batas Maksimal SKS ($gpa):",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  "$totalSks / $maxSks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: totalSks > maxSks ? Colors.red : Colors.blue.shade900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _courseList.length,
              itemBuilder: (context, index) {
                final course = _courseList[index];
                return CheckboxListTile(
                  title: Text(course['name']),
                  subtitle: Text(
                    "${course['sks']} SKS | ${course['isMandatory'] ? 'Mandatory' : 'Elective'}",
                    style: TextStyle(
                      color: course['isMandatory'] ? Colors.blue : Colors.grey,
                    ),
                  ),
                  value: course['selected'],
                  activeColor: Colors.blueAccent,
                  onChanged: (bool? value) {
                    setState(() {
                      _courseList[index]['selected'] = value!;
                    });
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: _validateAndSubmit,
                child: const Text("SUBMIT KRS", style: TextStyle(fontSize: 16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}