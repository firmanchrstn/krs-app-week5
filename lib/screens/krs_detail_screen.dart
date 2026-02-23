import 'package:flutter/material.dart';

class KrsDetailScreen extends StatelessWidget {
  const KrsDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final List<Map<String, dynamic>> selectedCourses = args['selectedCourses'];
    final int totalSks = args['totalSks'];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ringkasan KRS"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mata Kuliah yang Dipilih:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: selectedCourses.length,
                itemBuilder: (context, index) {
                  final course = selectedCourses[index];
                  return ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(course['name']),
                    subtitle: Text("${course['sks']} SKS"),
                    trailing: Text(
                      course['isMandatory'] ? "Mandatory" : "Elective",
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Kredit:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$totalSks SKS",
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: Colors.blueAccent
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}