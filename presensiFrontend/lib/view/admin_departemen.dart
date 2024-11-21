import 'package:absen_presen/logic/admin/department_logic.dart';
import 'package:absen_presen/logic/admin/users_list_logic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AdminDepartemen extends ConsumerWidget {
  const AdminDepartemen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final departmentData = ref.watch(departmentLogicProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Departemen'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(usersListLogicProvider.notifier).fetchAllUser();
            },
          ),
        ],
      ),
      body: departmentData.when(
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
                          DataCell(Text(e.location)),
                        ],
                      ),
                    )
                    .toList(),
                columns: [
                  DataColumn(
                    label: Text('No'),
                  ),
                  DataColumn(
                    label: Text('Nama Departemen'),
                  ),
                  DataColumn(
                    label: Text('Lokasi Departemen'),
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
