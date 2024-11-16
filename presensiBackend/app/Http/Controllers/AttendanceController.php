<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\Schedule;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class AttendanceController extends Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'success',
            'data' => Attendance::all()
        ], 200);
    }

    public function getAttendanceByAuth()
    {
        $user = Auth::user();
        $attendances = Attendance::where('user_id', $user->id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $attendances
        ], 200);
    }

    public function getAttendanceByUser($id)
    {
        $attendances = Attendance::where('user_id', $id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $attendances
        ], 200);
    }

    public function checkIn(Request $request)
    {
        $user = Auth::user();
        $date = Carbon::today()->toDateString();

        $existingAttendance = Attendance::where('user_id', $user->id)
            ->where('date', $date)
            ->first();

        if ($existingAttendance) {
            return response()->json([
                'message' => 'User already checked in today'
            ], 400);
        }

        $attendance = new Attendance();
        $attendance->user_id = $user->id;
        $attendance->date = $date;
        $attendance->start_time = Carbon::now()->format('H:i:s');
        $attendance->status = 'Masuk';
        $attendance->save();

        return response()->json([
            'message' => 'Check-in successful',
            'data' => $attendance
        ], 201);
    }

    public function checkOut(Request $request)
    {
        $user = Auth::user();
        $date = Carbon::today()->toDateString();

        $attendance = Attendance::where('user_id', $user->id)
            ->where('date', $date)
            ->first();

        if (!$attendance) {
            return response()->json([
                'message' => 'User has not checked in today'
            ], 400);
        }
        if ($attendance->status == 'Izin') {
            return response()->json([
                'message' => 'User has requested leave today'
            ], 400);
        }
        $attendance->end_time = Carbon::now()->format('H:i:s');
        $attendance->save();

        return response()->json([
            'message' => 'Check-out successful',
            'data' => $attendance
        ], 200);
    }

    // Fungsi untuk mencatat izin
    public function requestLeave(Request $request)
    {
        $user = Auth::user();
        $date = Carbon::today()->toDateString(); // Mengambil tanggal hari ini

        $existingAttendance = Attendance::where('user_id', $user->id)
            ->where('date', $date)
            ->first();

        if ($existingAttendance) {
            return response()->json([
                'message' => 'You have already registered for attendance today'
            ], 400);
        }

        // Menyimpan data izin
        $attendance = new Attendance();
        $attendance->user_id = $user->id;
        $attendance->date = $date;
        $attendance->start_time = Carbon::now()->format('H:i:s');
        $attendance->end_time = Carbon::now()->format('H:i:s');
        $attendance->status = 'Izin';
        $attendance->save();

        return response()->json([
            'message' => 'Leave request successful',
            'data' => $attendance
        ], 201);
    }

    // update attendance
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:Masuk,Izin,Alpa'
        ]);

        $attendance = Attendance::find($id);
        $attendance->status = $request->status;
        $attendance->save();

        return response()->json([
            'message' => 'Attendance updated',
            'data' => $attendance
        ], 200);
    }
}
