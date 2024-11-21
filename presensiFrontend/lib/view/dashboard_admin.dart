import 'package:absen_presen/logic/auth_logic.dart';
import 'package:absen_presen/view/admin/admin_departemen.dart';
import 'package:absen_presen/view/admin/admin_pengguna.dart';
import 'package:absen_presen/view/admin/admin_presensi.dart';
import 'package:absen_presen/view/admin/admin_register.dart';
import 'package:absen_presen/view/admin/admin_schedule.dart';
import 'package:absen_presen/view/login.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminDashboard extends HookConsumerWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(authLogicProvider.notifier).doLogout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat datang admin!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPengguna(),
                  ),
                );
              },
              child: Text('Lihat pengguna'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminDepartemen(),
                  ),
                );
              },
              child: Text('Lihat departemen'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminPresensi(),
                  ),
                );
              },
              child: Text('Lihat presensi'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminSchedule(),
                  ),
                );
              },
              child: Text('Lihat jadwal'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AdminRegister(),
                  ),
                );
              },
              child: Text('Daftarkan pengguna'),
            ),
          ],
        ),
      ),
    );
  }
}
