import 'package:flutter/material.dart';

class GetxApiIntegrationScreen extends StatelessWidget {
  const GetxApiIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Week 7 - GetX + API Integration')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _ApiChecklist(),
            SizedBox(height: 16),
            _ErrorHandlingTips(),
            SizedBox(height: 16),
            _TestingIdeas(),
          ],
        ),
      ),
    );
  }
}

class _ApiChecklist extends StatelessWidget {
  const _ApiChecklist();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.cyan.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Checklist integrasi API (todos endpoint)',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Gunakan baseUrl: https://ls-lms.zoidify.my.id/api',
            'Endpoint utama: GET /todos, POST /todos, PATCH /todos/{id}/toggle, DELETE /todos/{id}',
            'Gunakan Dio atau http client dengan timeout 10-15 detik',
            'Simpan header umum (Accept, Content-Type) pada BaseOptions',
            'Gunakan model (DTO) untuk mapping JSON ↔ entity',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, size: 18, color: Colors.cyan),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorHandlingTips extends StatelessWidget {
  const _ErrorHandlingTips();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Strategi error handling',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _TipRow(
            'Tangkap DioException dan sediakan pesan human readable (cek statusCode, timeout, connection error).',
          ),
          _TipRow(
            'Sediakan fallback data lokal agar demo tetap jalan walau API off.',
          ),
          _TipRow(
            'Gunakan snackbar atau banner pada UI untuk memberi feedback user.',
          ),
          _TipRow(
            'Pastikan spinner/loading indicator ditampilkan selama proses async.',
          ),
        ],
      ),
    );
  }
}

class _TestingIdeas extends StatelessWidget {
  const _TestingIdeas();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.pink.withValues(alpha: 0.08), Colors.white],
        ),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Testing ideas (bonus)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          _TipRow(
            'Mock repository di unit test controller untuk memastikan add/toggle/delete bekerja.',
          ),
          _TipRow(
            'Widget test: gunakan Get.testMode = true dan pump halaman dengan binding.',
          ),
          _TipRow(
            'Integration test: simulasi user menambahkan todo dan memastikan muncul di list.',
          ),
        ],
      ),
    );
  }
}

class _TipRow extends StatelessWidget {
  const _TipRow(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 20, color: Colors.grey),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
