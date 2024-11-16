import 'package:flutter/material.dart';

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Selamat datang, \$nama!',
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
