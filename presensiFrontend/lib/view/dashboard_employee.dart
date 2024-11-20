import 'package:absen_presen/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EmployeeDashboard extends ConsumerWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = ref.watch(authLogicProvider).value?.user.name;
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi Karyawan'),
        actions: [
          IconButton(
            onPressed: () {
              // TODO implement logout action
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
              'Selamat datang, $name!',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            FilledButton(
              onPressed: () {
                // TODO implement presensi
              },
              child: Text('Lakukan presensi'),
            )
          ],
        ),
      ),
    );
  }
}
