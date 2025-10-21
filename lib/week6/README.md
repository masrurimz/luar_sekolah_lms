# Week 6: Penggunaan API untuk UI Aplikasi

Week 6 berfokus pada integrasi API ke aplikasi Flutter dan menampilkan data secara dinamis pada UI. Materi mencakup pengenalan package, HTTP request, parsing JSON, FutureBuilder, error handling, serta praktik menampilkan data dari API publik (JSONPlaceholder Todos) ke dalam dashboard sederhana.

## Tujuan Khusus
- Mengintegrasikan API ke aplikasi Flutter
- Memahami penggunaan package pihak ketiga (`http`)
- Melakukan parsing JSON ke model Dart
- Menampilkan data asinkron menggunakan `FutureBuilder`
- Menangani error dan state loading/empty/retry secara rapi

## Struktur Folder
```
lib/week6/
├── README.md                         # Ringkasan materi
├── PRESENTATION_GUIDE.md             # Panduan presentasi instruktur
├── models/
│   └── todo.dart                     # Model Todo (JSONPlaceholder)
├── services/
│   └── todo_api_service.dart         # HTTP client & parsing
├── concepts/                         # Halaman konsep (eksplorasi & contoh)
│   ├── 01_packages_intro.dart
│   ├── 02_http_setup.dart
│   ├── 03_http_get_basics.dart
│   ├── 04_parse_json_to_model.dart
│   ├── 05_futurebuilder_ui.dart
│   └── 06_error_handling_retry.dart
└── screens/
    ├── todo_dashboard_screen.dart    # Demo dashboard Todos
    ├── todo_crud_screen.dart         # CRUD demo: create/update/delete with optimistic UI
    └── weekly_task_screen.dart       # Instruksi tugas mingguan
```

## Persiapan (pubspec.yaml)
Tambahkan dependency `http`:

```
dependencies:
  http: ^1.2.2
```

Jalankan: `flutter pub get`

## API yang Digunakan
- JSONPlaceholder Todos: `https://jsonplaceholder.typicode.com/todos`
  - Fields: `userId`, `id`, `title`, `completed`

## Rekomendasi Alur Belajar
1) Pahami package dan dependency → 01, 02
2) Lakukan HTTP GET sederhana → 03
3) Parsing JSON → 04
4) Tampilkan dengan FutureBuilder → 05
5) Tambahkan error handling & retry → 06
6) Implementasi utuh → `screens/todo_dashboard_screen.dart`
7) Kerjakan Weekly Task → `screens/weekly_task_screen.dart`

## Weekly Task (Ringkas)
Bangun halaman dashboard yang menampilkan daftar Todo dari API. Syarat minimal:
- List dinamis (Todo) dengan indikator loading dan error state
- Refresh manual (pull-to-refresh) dan tombol retry
- Filter status: All / Completed / Pending
- Navigasi ke detail todo sederhana (opsional)

Tambahan (CRUD):
- Form tambah Todo (POST)
- Edit judul/status (PATCH/PUT) + toggle cepat
- Hapus Todo (DELETE) dengan konfirmasi

Catatan: JSONPlaceholder menerima operasi CRUD namun tidak menyimpan perubahan. Terapkan pendekatan optimistik di UI (perubahan langsung terlihat) dan tangani error dengan baik. Penilaian lengkap dan instruksi detail lihat `screens/weekly_task_screen.dart`.
