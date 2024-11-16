<?php

namespace Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ScheduleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $users = DB::table('users')->pluck('id');
        $startDate = Carbon::now();
        $endDate = Carbon::now()->addMonth();

        $schedules = [];
        foreach ($users as $userId) {
            if ($userId === 1) {
                continue; // Skip the admin user
            }
            $currentDate = $startDate->copy();
            while ($currentDate->lessThanOrEqualTo($endDate)) {
                $schedules[] = [
                    'user_id' => $userId,
                    'date' => $currentDate->toDateString(),
                    'start_time' => '09:00:00',
                    'end_time' => '17:00:00',
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
                $currentDate->addDay();
            }
        }

        DB::table('schedule')->insert($schedules);
    }
}
