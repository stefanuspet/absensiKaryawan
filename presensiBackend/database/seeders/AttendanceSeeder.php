<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AttendanceSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = DB::table('users')->pluck('id');
        $startDate = Carbon::now()->subMonth();
        $endDate = Carbon::now();
        $statuses = ['Present', 'Absent', 'Late', 'Excused'];

        $attendanceRecords = [];
        foreach ($users as $userId) {
            if ($userId === 1) {
                continue;
            }
            $currentDate = $startDate->copy();
            while ($currentDate->lessThanOrEqualTo($endDate)) {
                $attendanceRecords[] = [
                    'user_id' => $userId,
                    'date' => $currentDate->toDateString(),
                    'start_time' => '09:00:00',
                    'end_time' => '17:00:00',
                    'status' => $statuses[array_rand($statuses)],
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
                $currentDate->addDay();
            }
        }

        DB::table('attendance')->insert($attendanceRecords);
    }
}
