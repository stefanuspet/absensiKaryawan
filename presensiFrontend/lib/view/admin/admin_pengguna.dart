import 'package:absen_presen/logic/admin/users_list_logic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminPengguna extends ConsumerWidget {
  const AdminPengguna({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersData = ref.watch(usersListLogicProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengguna'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(usersListLogicProvider.notifier).fetchAllUser();
            },
          ),
        ],
      ),
      body: usersData.when(
        data: (data) {
          return Card(
            child: InteractiveViewer(
              constrained: false,
              maxScale: 1,
              child: DataTable(
                rows: data
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(Text((data.indexOf(e) + 1).toString())),
                          DataCell(Text(e.name)),
                          DataCell(Text(e.email)),
                          DataCell(Text(e.phone)),
                          DataCell(Text(e.role)),
                          DataCell(Text(e.department?.name ?? 'Department tidak diketahui')),
                          DataCell(Text(e.department?.location ?? 'Department tidak diketahui')),
                        ],
                      ),
                    )
                    .toList(),
                columns: [
                  DataColumn(
                    label: Text('No'),
                  ),
                  DataColumn(
                    label: Text('Nama'),
                  ),
                  DataColumn(
                    label: Text('Email'),
                  ),
                  DataColumn(
                    label: Text('Phone'),
                  ),
                  DataColumn(
                    label: Text('Role'),
                  ),
                  DataColumn(
                    label: Text('Department'),
                  ),
                  DataColumn(
                    label: Text('Lokasi Department'),
                  ),
                ],
              ),
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
