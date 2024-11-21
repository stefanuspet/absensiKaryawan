import 'package:absen_presen/data/api/department_api.dart';
import 'package:absen_presen/data/model/departments/departments_model.dart';
import 'package:absen_presen/logic/admin/department_logic.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
              ref.read(departmentLogicProvider.notifier).fetchDepartment();
            },
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DepartemenAdd(),
                ),
              );
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
                          DataCell(FilledButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DepartemenEdit(data: e),
                                ),
                              );
                            },
                            child: Text('Edit'),
                          )),
                          DataCell(
                            FilledButton(
                              onPressed: () async {
                                try {
                                  await deleteDepartment(
                                    ref.read(authLogicProvider).value?.token ??
                                        '',
                                    e.id!,
                                  );
                                  ref.read(departmentLogicProvider.notifier).fetchDepartment();
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              },
                              child: Text('Delete'),
                            ),
                          ),
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
                  DataColumn(
                    label: Text('Edit'),
                  ),
                  DataColumn(
                    label: Text('Delete'),
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

class DepartemenAdd extends HookConsumerWidget {
  const DepartemenAdd({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtl = useTextEditingController();
    final locationCtl = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah departemen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: nameCtl,
              decoration: InputDecoration(
                labelText: 'Nama Departemen',
              ),
            ),
            TextField(
              controller: locationCtl,
              decoration: InputDecoration(
                labelText: 'Lokasi Departemen',
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                try {
                  final response = await addDepartment(
                    ref.read(authLogicProvider).value?.token ?? '',
                    DepartmentsModel(
                      name: nameCtl.text,
                      location: locationCtl.text,
                    ),
                  );

                  if (response.statusCode == 201 && context.mounted) {
                    ref
                        .read(departmentLogicProvider.notifier)
                        .fetchDepartment();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Berhasil tambah departemen'),
                      ),
                    );
                    Navigator.pop(context);
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}

class DepartemenEdit extends HookConsumerWidget {
  const DepartemenEdit({required this.data, super.key});

  final DepartmentsModel data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameCtl = useTextEditingController(text: data.name);
    final locationCtl = useTextEditingController(text: data.location);

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit departemen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              controller: nameCtl,
            ),
            TextField(
              controller: locationCtl,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () async {
                final response = await editDepartment(
                  ref.read(authLogicProvider).value?.token ?? '',
                  data.copyWith(name: nameCtl.text, location: locationCtl.text),
                );

                if (response.statusCode == 200 && context.mounted) {
                  ref.read(departmentLogicProvider.notifier).fetchDepartment();

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Berhasil edit departemen'),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text('Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
