import 'package:flutter/material.dart';

class KrsDetailScreen extends StatelessWidget {
  const KrsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve data from arguments
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Map<String, dynamic>> selectedCourses = args['selectedCourses'];
    final int totalSks = args['totalSks'];
    final String semester = args['semester'];

    return Scaffold(
      appBar: AppBar(title: const Text("KRS Summary")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Semester: $semester", 
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Selected Courses:", 
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: selectedCourses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(selectedCourses[index]['name']),
                    trailing: Text("${selectedCourses[index]['sks']} Credits"),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              "Total: $totalSks Credits", 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}