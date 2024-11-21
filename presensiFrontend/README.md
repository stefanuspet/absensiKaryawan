# absen_presen

## 🔨 Building
1. Pastikan ada Flutter SDK dan JDK 17 (untuk android).
2. Pastikan instalasi Flutter aman, run command `flutter doctor` untuk mengecek.
3. Jalankan command `flutter pub get` buat install dependency.
4. Jalankan command `dart run build_runner watch` buat generate code.
5. Jalankan command `flutter run` untuk run aplikasi (debug mode), atau `flutter build apk` jika mau compile (release mode) ke android.

## Konfigurasi server
Konfigurasi server ada di `./lib/data/api/dio_config.dart`, silahkan sesuaikan dengan IP server (default localhost).

## 🔀 Flow aplikasi
Flow logic di aplikasi kurang lebih seperti ini:

```
    User melakukan sesuatu    ->   Memanggil logic (apapun yang ada di folder logic)
               ^                            |
               |                            v
    State dikirim ke widget,  <-   Logic memproses panggilan (misal
    Widget akan ter-refresh        memanggil API atau yang lain).

```
Silahkan lihat di [dokumentasi Riverpod](https://riverpod.dev/) untuk penjelasan lengkapnya.
