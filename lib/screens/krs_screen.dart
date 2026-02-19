import 'package:flutter/material.dart';
import 'krs_detail_screen.dart';

class KrsScreen extends StatefulWidget {
  const KrsScreen({super.key});

  @override
  State<KrsScreen> createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  int totalSks = 0;
  List<String> matkulDiambil = [];

  void tambahMatkul(String namaMatkul, int sks) {
    setState(() {
      if (!matkulDiambil.contains(namaMatkul)) {
        matkulDiambil.add(namaMatkul);
        totalSks += sks;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$namaMatkul is already taken!")),
        );
      }
    });
  }

  void resetKrs() {
    setState(() {
      totalSks = 0;
      matkulDiambil.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Plan Card (KRS)"),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetKrs,
            tooltip: "Reset Study Plan",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Credits:",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "$totalSks",
                    style: const TextStyle(
                      color: Colors.white, 
                      fontSize: 30, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            const Text("Select Courses (Semester 6):", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            Card(
              child: ListTile(
                title: const Text("Advanced Web Programming"),
                subtitle: const Text("3 Credits"),
                trailing: ElevatedButton(
                  onPressed: () => tambahMatkul("Advanced Web Programming", 3),
                  child: const Text("Add"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("IS Project Management"),
                subtitle: const Text("3 Credits"),
                trailing: ElevatedButton(
                  onPressed: () => tambahMatkul("IS Project Management", 3),
                  child: const Text("Add"),
                ),
              ),
            ),

            Card(
              child: ListTile(
                title: const Text("Business Intelligence"),
                subtitle: const Text("2 Credits"),
                trailing: ElevatedButton(
                  onPressed: () => tambahMatkul("Business Intelligence", 2),
                  child: const Text("Add"),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                if (totalSks >= 1) {
                  setState(() {
                    totalSks -= 1;
                  });
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Credits cannot be negative!", style: TextStyle(color: Colors.red))),
                  );
                }
              },
              child: const Text("Decrease 1 Credit (Logic Test)"),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                child: const Text("VIEW SUMMARY"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KrsDetailScreen(
                        totalSks: totalSks,
                        daftarMatkul: matkulDiambil,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}