import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPresensi extends ConsumerWidget {
  const AdminPresensi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi karyawan'),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
