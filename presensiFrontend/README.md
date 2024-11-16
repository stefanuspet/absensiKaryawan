# absen_presen

## 🔨 Building
1. Pastikan ada Flutter SDK dan JDK 17 (untuk android).
2. Pastikan instalasi Flutter aman, run command `flutter doctor` untuk mengecek.
3. Jalankan command `flutter pub get` buat install dependency.
4. Jalankan command `flutter run` untuk run aplikasi (debug mode), atau `flutter build apk` jika mau compile (release mode) ke android.

## 🔀 Flow aplikasi
Flow logic di aplikasi kurang lebih seperti ini:

```
    User melakukan sesuatu    ->   Event dikirim ke bloc (logic) 
               ^                            |
               |                            v
    State dikirim ke widget,  <-   Bloc memproses event (misal
    Widget akan ter-refresh        memanggil API atau yang lain).

```
Silahkan lihat di [dokumentasi BLoC](https://bloclibrary.dev/bloc-concepts/) untuk penjelasan lengkapnya.
