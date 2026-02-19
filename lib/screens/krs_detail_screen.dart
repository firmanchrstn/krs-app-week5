import 'package:flutter/material.dart';

class KrsDetailScreen extends StatelessWidget {
  final int totalSks;
  final List<String> daftarMatkul;

  const KrsDetailScreen({
    super.key, 
    required this.totalSks, 
    required this.daftarMatkul
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("KRS Summary"),
        backgroundColor: Colors.blue[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Study Plan Result",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total Credits Taken:", style: TextStyle(fontSize: 18)),
                    Text(
                      "$totalSks Credits", 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            const Text("Selected Courses:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),

            if (daftarMatkul.isEmpty)
              const Text("No courses selected yet.", style: TextStyle(fontStyle: FontStyle.italic))
            else
              ...daftarMatkul.map((matkul) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text("• $matkul", style: const TextStyle(fontSize: 16)),
              )),
          ],
        ),
      ),
    );
  }
}