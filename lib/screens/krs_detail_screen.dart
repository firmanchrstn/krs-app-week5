import 'package:flutter/material.dart';

class KrsDetailScreen extends StatelessWidget {
  // Variabel untuk menampung data yang dikirim dari KrsScreen
  final int totalSks;
  final List<String> daftarMatkul;

  // Constructor: Wajib diisi saat halaman ini dipanggil
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
              "Hasil Rencana Studi",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Menampilkan Total SKS
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total SKS Diambil:", style: TextStyle(fontSize: 18)),
                    Text(
                      "$totalSks SKS", 
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            const Text("Mata Kuliah Terpilih:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),

            // Logic sederhana menampilkan list mata kuliah
            // Jika kosong, tampilkan pesan. Jika ada, tampilkan listnya.
            if (daftarMatkul.isEmpty)
              const Text("Belum ada mata kuliah yang diambil.", style: TextStyle(fontStyle: FontStyle.italic))
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