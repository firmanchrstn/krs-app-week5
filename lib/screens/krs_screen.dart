import 'package:flutter/material.dart';
import 'krs_detail_screen.dart'; // Import halaman detail

class KrsScreen extends StatefulWidget {
  const KrsScreen({super.key});

  @override
  State<KrsScreen> createState() => _KrsScreenState();
}

class _KrsScreenState extends State<KrsScreen> {
  // --- STATE (DATA YANG BERUBAH) ---
  int totalSks = 0;
  List<String> matkulDiambil = [];

  // --- LOGIC SEDERHANA (FUNGSI) ---

  // Fungsi untuk menambah mata kuliah
  void tambahMatkul(String namaMatkul, int sks) {
    setState(() {
      // Cek apakah matkul sudah diambil? (Agar tidak duplikat)
      if (!matkulDiambil.contains(namaMatkul)) {
        matkulDiambil.add(namaMatkul); // Tambah nama ke list
        totalSks += sks;               // Tambah total SKS
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("$namaMatkul sudah diambil!")),
        );
      }
    });
  }

  // Fungsi untuk reset / menghapus semua (Opsional untuk latihan Part C)
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
        title: const Text("Kartu Rencana Studi"),
        backgroundColor: Colors.blue[100],
        actions: [
          // Tombol Reset
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetKrs,
            tooltip: "Reset KRS",
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- BAGIAN INFORMASI STATE ---
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
                    "Total SKS:",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    "$totalSks", // Ini akan berubah otomatis saat setState dipanggil
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
            const Text("Pilih Mata Kuliah (Semester 6):", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),

            // --- DAFTAR MATA KULIAH (Hardcoded untuk pemula) ---
            
            // Matkul 1
            Card(
              child: ListTile(
                title: const Text("Pemrograman Web Lanjut"),
                subtitle: const Text("3 SKS"),
                trailing: ElevatedButton(
                  onPressed: () {
                    tambahMatkul("Pemrograman Web Lanjut", 3);
                  },
                  child: const Text("Ambil"),
                ),
              ),
            ),

            // Matkul 2
            Card(
              child: ListTile(
                title: const Text("Manajemen Proyek SI"),
                subtitle: const Text("3 SKS"),
                trailing: ElevatedButton(
                  onPressed: () {
                    tambahMatkul("Manajemen Proyek SI", 3);
                  },
                  child: const Text("Ambil"),
                ),
              ),
            ),

            // Matkul 3
            Card(
              child: ListTile(
                title: const Text("Business Intelligence"),
                subtitle: const Text("2 SKS"),
                trailing: ElevatedButton(
                  onPressed: () {
                    tambahMatkul("Business Intelligence", 2);
                  },
                  child: const Text("Ambil"),
                ),
              ),
            ),
            
            // Matkul 4 (Part C - Validation logic test)
            // Tombol ini contoh logic pengurangan (Opsional sesuai Part C.3)
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () {
                // PART C: Prevent credits below zero
                if (totalSks >= 1) {
                  setState(() {
                    totalSks -= 1;
                    // Note: Logic menghapus nama matkul agak rumit untuk pemula, 
                    // jadi di sini kita hanya kurangi angka SKS sebagai contoh validasi.
                  });
                } else {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("SKS tidak boleh minus!", style: TextStyle(color: Colors.red))),
                  );
                }
              },
              child: const Text("Kurangi 1 SKS (Test Logic)"),
            ),

            const Spacer(),

            // --- TOMBOL PASSING DATA (Part 4.3) ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                child: const Text("LIHAT RINGKASAN (View Summary)"),
                onPressed: () {
                  // Navigasi sambil membawa data (Passing Data)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => KrsDetailScreen(
                        totalSks: totalSks,          // Kirim angka
                        daftarMatkul: matkulDiambil, // Kirim list
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