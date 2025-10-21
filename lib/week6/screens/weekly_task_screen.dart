import 'package:flutter/material.dart';

class Week6WeeklyTaskScreen extends StatelessWidget {
  const Week6WeeklyTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 6 - Weekly Task')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'Tugas: Buat UI dengan API (JSONPlaceholder Todos)\n\n'
            'Tujuan:\n'
            '- Membuat dashboard yang menampilkan daftar Todo dari API\n'
            '- Menggunakan http, parsing JSON, dan FutureBuilder\n'
            '- Mengelola state loading, error, empty, dan retry\n\n'
            'Spesifikasi Minimal:\n'
            '1) Menampilkan list Todo (title, completed)\n'
            '2) Pull-to-refresh dan tombol retry\n'
            '3) Filter status: All / Completed / Pending\n'
            '4) Layout responsif & rapi\n\n'
            'Opsional (+ Kreativitas):\n'
            '- Halaman detail Todo (navigasi)\n'
            '- Pencarian judul Todo\n'
            '- Empty state yang informatif\n\n'
            'Instruksi Pengumpulan:\n'
            '- Sertakan screenshot/video demo fitur\n'
            '- Sertakan laporan singkat proses & tantangan\n'
            '- Unggah project Flutter lengkap (repository)\n\n'
            'Rubrik Penilaian (100):\n'
            '- UI sesuai deskripsi (25)\n'
            '- Integrasi API efektif (25)\n'
            '- Responsivitas & fungsional (20)\n'
            '- Kreativitas desain (15)\n'
            '- Kualitas laporan (15)\n',
          ),
        ],
      ),
    );
  }
}
