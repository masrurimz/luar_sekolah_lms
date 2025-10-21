# Week 6: Penggunaan API untuk UI Aplikasi — Panduan Presentasi

Durasi ideal: 1–2 pertemuan (3–4 jam) + tugas mingguan.

## Flow Sesi
- Opening & Hook (5–10 menit)
  - Studi kasus app yang kontennya dinamis dari API
  - Tunjukkan demo `Todo Dashboard`

- Pengenalan Package (10 menit)
  - Apa itu package (Dart vs Plugin)
  - Keuntungan menggunakan package (reuse, cepat, terpercaya)

- Setup `http` (10 menit)
  - Edit `pubspec.yaml`
  - Import `package:http/http.dart` dan `dart:convert`

- HTTP GET & Response (20 menit)
  - Endpoint JSONPlaceholder Todos
  - Status code, headers, body
  - Demo: `03_http_get_basics.dart`

- Parsing JSON → Model (25 menit)
  - Buat `Todo` model (`fromJson/toJson`)
  - Koleksi (List<Todo>) dari response
  - Demo: `04_parse_json_to_model.dart`

- FutureBuilder & UI Asinkron (25 menit)
  - State: loading, success, error, empty
  - Demo: `05_futurebuilder_ui.dart`

- Error Handling & Retry (15 menit)
  - Timeouts, exception, network failure
  - Pola retry sederhana & indikator
  - Demo: `06_error_handling_retry.dart`

- Demo Implementasi Utuh (20 menit)
  - `screens/todo_dashboard_screen.dart`
  - Fitur: pull-to-refresh, filter, retry

- Weekly Task Brief (10 menit)
  - Jelaskan kriteria & rubric

## Catatan Mengajar
- Tekankan pemisahan concern: `services` (API) vs `models` vs `screens`
- Tunjukkan pentingnya tipe data yang kuat saat parsing JSON
- Biasakan tampilkan semua state UI: loading / error / empty
- Gunakan `RefreshIndicator` untuk pengalaman pengguna yang familiar

## Q&A Cadangan
- Perbedaan `dio` vs `http`
- Caching sederhana (opsional)
- Penggunaan `provider`/`bloc` untuk state lebih kompleks (teaser minggu depan)

