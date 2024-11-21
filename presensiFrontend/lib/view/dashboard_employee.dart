import 'package:absen_presen/data/api/attendance_api.dart';
import 'package:absen_presen/data/api/auth_api.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:absen_presen/view/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmployeeDashboard extends ConsumerWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(authLogicProvider).value?.token;

    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Karyawan'),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => EmployeeEdit(),
          //       ),
          //     );
          //   },
          //   icon: Icon(Icons.edit),
          // ),
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
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            EmployeeInfo(),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () async {
                try {
                  final response = await checkIn(token ?? '');
                  if (response.statusCode == 201 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Presensi berhasil!'),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Anda sudah melakukan presensi!'),
                    ),
                  );
                }
              },
              child: Text('Lakukan presensi'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () async {
                final response = await checkOut(token ?? '');
                if (response.statusCode == 200 && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Checkout berhasil!'),
                    ),
                  );
                }
              },
              child: Text('Lakukan checkout'),
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () async {
                try {
                  final response = await leave(token ?? '');
                  if (response.statusCode == 201 && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Izin berhasil!'),
                      ),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          'Gagal meminta izin, anda sudah melakukan presensi!'),
                    ),
                  );
                }
              },
              child: Text('Minta izin'),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeInfo extends ConsumerWidget {
  const EmployeeInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authLogicProvider).value?.user;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat datang, ${authData?.name}!',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.left,
          ),
          Text(authData?.email ?? ''),
          Text(
            authData?.phone ?? '',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(height: 3),
          ),
          Text(
            'Departemen: ${authData?.department?.name ?? 'Departemen tidak ditemukan'}',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

class EmployeeEdit extends HookConsumerWidget {
  const EmployeeEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authData = ref.watch(authLogicProvider).value?.user;

    final nameCtl = useTextEditingController(text: authData?.name);
    final phoneCtl = useTextEditingController(text: authData?.phone);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: nameCtl,
              decoration: InputDecoration(
                labelText: 'Nama',
              ),
            ),
            TextField(
              controller: phoneCtl,
              decoration: InputDecoration(
                labelText: 'Nomor Telepon',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton(
                onPressed: () async {
                  try {
                    final response = await updateProfile(
                      ref.read(authLogicProvider).value?.token ?? '',
                      authData!.copyWith(
                        name: nameCtl.text,
                        phone: phoneCtl.text,
                      ),
                    );
                    if (response.statusCode == 200 && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Profil berhasil diubah!'),
                        ),
                      );
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Gagal mengubah profil'),
                      ),
                    );
                  }
                },
                child: Text('Simpan'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
