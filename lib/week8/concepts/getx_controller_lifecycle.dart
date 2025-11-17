import 'package:flutter/material.dart';

class GetxControllerLifecycleScreen extends StatelessWidget {
  const GetxControllerLifecycleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const codeStyle = TextStyle(fontFamily: 'monospace', fontSize: 12.5);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Week 8 - Remote Data Source & Dio Setup'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _DataSourceCard(codeStyle: codeStyle),
            const SizedBox(height: 18),
            const _TimeoutRetryCard(),
            const SizedBox(height: 18),
            const _MappingCard(),
            const SizedBox(height: 18),
            const _LoggingCard(),
          ],
        ),
      ),
    );
  }
}

class _DataSourceCard extends StatelessWidget {
  const _DataSourceCard({required this.codeStyle});

  final TextStyle codeStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Struktur `TodoRemoteDataSource`',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            'Semua interaksi dengan Dio ditempatkan di sini. Data source bertugas mengubah JSON menjadi `TodoModel` sebelum dikirim ke repository.',
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text('''class TodoRemoteDataSource {
  TodoRemoteDataSource({Dio? client})
      : _client = client ?? Dio(_baseOptions);

  static final BaseOptions _baseOptions = BaseOptions(
    baseUrl: 'https://ls-lms.zoidify.my.id/api',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {'Accept': 'application/json'},
  );

  final Dio _client;

  Future<List<TodoModel>> fetchTodos() async {
    final response = await _client.get<Map<String, dynamic>>('/todos');
    final data = response.data?['todos'] as List<dynamic>? ?? [];
    return data.map((item) => TodoModel.fromJson(item as Map<String, dynamic>)).toList();
  }
}''', style: codeStyle.copyWith(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}

class _TimeoutRetryCard extends StatelessWidget {
  const _TimeoutRetryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.cyan.withValues(alpha: 0.09), Colors.white],
        ),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Timeout & retry strategy',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Set timeout connect & receive (10s) untuk menghindari UI menggantung.',
            'Tangani `DioExceptionType.connectionTimeout` → lempar pesan khusus dan tawarkan tombol retry.',
            'Gunakan interceptor ringan untuk menambahkan header auth (jika diperlukan) atau logging.',
            'Siapkan mekanisme retry manual di controller/use case untuk aksi kritikal (misal create todo).',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.restart_alt, color: Colors.cyan),
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

class _MappingCard extends StatelessWidget {
  const _MappingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
        children: [
          Text(
            'Mapping JSON ↔ domain',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...const [
            'Selalu gunakan `TodoModel` (extends `Todo`) untuk menjaga domain tetap immutable.',
            'Validasi field wajib: id, text, completed, createdAt, updatedAt. Jika response tidak valid, lempar exception khusus.',
            'Konversi tanggal menggunakan `DateTime.parse` dan `toIso8601String` agar kompatibel di semua layer.',
            'Repository bertugas mengirim object domain (`Todo`), bukan Map ataupun DTO.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.data_object, color: Colors.deepPurple),
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

class _LoggingCard extends StatelessWidget {
  const _LoggingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          colors: [Colors.grey.withValues(alpha: 0.1), Colors.white],
        ),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Logging & monitoring ringan',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sebelum masuk ke Week 11 (testing), kita menambahkan observability sederhana agar debugging lebih cepat.',
          ),
          const SizedBox(height: 10),
          ...const [
            'Gunakan `log()` (dart:developer) di data source untuk mencatat endpoint, status code, dan waktu respons.',
            'Tambahkan helper `mapDioError` yang mengubah error teknis menjadi pesan user-friendly.',
            'Simulasikan kegagalan API di kelas demo untuk menunjukkan cara rollback state dari controller.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.visibility, color: Colors.grey),
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
