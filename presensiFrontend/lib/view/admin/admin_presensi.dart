import 'package:absen_presen/data/api/attendance_api.dart';
import 'package:absen_presen/logic/admin/attendance_logic.dart';
import 'package:absen_presen/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum AttendanceStatus {
  Masuk,
  Izin,
  Alpa,
}

class AdminPresensi extends ConsumerWidget {
  const AdminPresensi({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceData = ref.watch(attendanceLogicProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Presensi karyawan'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              ref.read(attendanceLogicProvider.notifier).fetchAttendanceModel();
            },
          ),
        ],
      ),
      body: attendanceData.when(
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
                          DataCell(Text(e.user?.name ?? '')),
                          DataCell(
                            Text(
                                '${e.date.day}/${e.date.month}/${e.date.year}'),
                          ),
                          DataCell(Text(e.startTime ?? 'Belum mulai')),
                          DataCell(Text(e.endTime ?? 'Belum selesai')),
                          DataCell(
                            DropdownButton<String>(
                              value: e.status,
                              items: AttendanceStatus.values.map(
                                  (status) {
                                    return DropdownMenuItem<String>(
                                      value: status.name,
                                      child: Text(status.name),
                                    );
                                  }
                              ).toList(),
                              onChanged: (value) async {
                                await adminUpdateAttendance(
                                  ref.read(authLogicProvider).value?.token ?? '',
                                  e.id ?? 0,
                                  value ?? '',
                                );
                                ref.read(attendanceLogicProvider.notifier).fetchAttendanceModel();
                              },
                            )
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
                    label: Text('Nama'),
                  ),
                  DataColumn(
                    label: Text('Tanggal'),
                  ),
                  DataColumn(
                    label: Text('Jam Masuk'),
                  ),
                  DataColumn(
                    label: Text('Jam Keluar'),
                  ),
                  DataColumn(
                    label: Text('Status'),
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
