import 'package:flutter/material.dart';
import 'krs_detail_screen.dart';

class KrsScreen extends StatefulWidget {
  const KrsScreen({super.key});

  @override
  State<KrsScreen> createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  String _selectedSemester = "Odd"; 

  // Course Data
  final List<Map<String, dynamic>> _courseList = [
    {"name": "Mobile Programming", "sks": 3, "selected": false},
    {"name": "Data Structures", "sks": 4, "selected": false},
    {"name": "Database Systems", "sks": 3, "selected": false},
    {"name": "Entrepreneurship", "sks": 2, "selected": false},
    {"name": "Professional Ethics", "sks": 2, "selected": false},
  ];

  // Calculate total selected credits (SKS)
  int get _totalSks {
    int total = 0;
    for (var course in _courseList) {
      if (course['selected'] == true) {
        total += course['sks'] as int;
      }
    }
    return total;
  }

  // --- Task 2: Implement Validation Flow & Logic ---
  void _validateAndSubmit() {
    // Rule 1: Cannot be zero or less than 3 Credits (New Validation Rule)
    if (_totalSks < 3) {
      _showSnackBar("Failed! You must take at least 3 Credits.", Colors.orange);
    } 
    // Rule 2: Cannot exceed 24 Credits
    else if (_totalSks > 24) {
      _showSnackBar("Failed! Total Credits cannot exceed 24.", Colors.red);
    } 
    // If all validations pass, navigate to detail screen
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KrsDetailScreen(),
          settings: RouteSettings(
            arguments: {
              'selectedCourses': _courseList.where((c) => c['selected']).toList(),
              'totalSks': _totalSks,
              'semester': _selectedSemester, // Sending the new field
            },
          ),
        ),
      );
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("KRS Input (Intermediate)")),
      body: Column(
        children: [
          // UI for New Field: Semester Dropdown
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              value: _selectedSemester,
              decoration: const InputDecoration(
                labelText: "Semester Type",
                border: OutlineInputBorder(),
              ),
              items: ["Odd", "Even"].map((String value) {
                return DropdownMenuItem(value: value, child: Text(value));
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedSemester = newValue!;
                });
              },
            ),
          ),

          // Total Credits Info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            color: Colors.blue[50],
            child: Text(
              "Total Selected Credits: $_totalSks / 24",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),

          // Course List
          Expanded(
            child: ListView.builder(
              itemCount: _courseList.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_courseList[index]['name']),
                  subtitle: Text("${_courseList[index]['sks']} Credits"),
                  value: _courseList[index]['selected'],
                  onChanged: (bool? value) {
                    setState(() {
                      _courseList[index]['selected'] = value!;
                    });
                  },
                );
              },
            ),
          ),

          // Submit Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _validateAndSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, 
                  foregroundColor: Colors.white,
                ),
                child: const Text("SUBMIT KRS"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}