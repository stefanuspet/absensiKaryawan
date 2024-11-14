<?php

namespace App\Http\Controllers;

use App\Models\Attendance;
use App\Models\Schedule;
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

    public function showAttendanceByEmployee($employee_id)
    {
        $attendance = Attendance::where('employee_id', $employee_id)->get();

        if ($attendance) {
            return response()->json([
                'message' => 'success',
                'data' => $attendance
            ], 200);
        } else {
            return response()->json([
                'message' => 'Attendance not found'
            ], 404);
        }
    }

    public function showAttendanceByDate($date)
    {
        $attendance = Attendance::where('date', $date)->get();

        if ($attendance) {
            return response()->json([
                'message' => 'success',
                'data' => $attendance
            ], 200);
        } else {
            return response()->json([
                'message' => 'Attendance not found'
            ], 404);
        }
    }

    public function showAttendanceByEmployeeAndDate($employee_id, $date)
    {
        $attendance = Attendance::where('employee_id', $employee_id)->where('date', $date)->get();

        if ($attendance) {
            return response()->json([
                'message' => 'success',
                'data' => $attendance
            ], 200);
        } else {
            return response()->json([
                'message' => 'Attendance not found'
            ], 404);
        }
    }

    public function storeArrivalAttendance(Request $request)
    {

        $request->validate([
            'status' => 'required'
        ]);

        $authenticatedEmployee = Auth::user();

        if ($request->employee_id != $authenticatedEmployee->id) {
            return response()->json([
                'message' => 'Unauthorized: You can only register attendance for yourself.',
            ], 403);
        }

        $schedule = Schedule::where('employee_id', $request->employee_id)
            ->whereDate('date', now()->toDateString())
            ->first();

        if (!$schedule) {
            $schedule = Schedule::create([
                'employee_id' => $request->employee_id,
                'date' => now()->toDateString(),
                'start_time' => now()->toTimeString(),
                'end_time' => null,
            ]);
        }

        $attendance = Attendance::create([
            'employee_id' => $authenticatedEmployee->id,
            'schedule_id' => $schedule->id,
            'status' => $request->status,
            'date' => now()->toDateString(),
            'start_time' => now()->toTimeString(),
            'end_time' => null,
        ]);

        return response()->json([
            'message' => 'Attendance created successfully',
            'data' => $attendance
        ], 201);
    }


    public function storeExitAttendance(Request $request)
    {

        $request->validate([
            'status' => 'required',
        ]);

        $authenticatedEmployee = Auth::user();

        if ($request->employee_id != $authenticatedEmployee->id) {
            return response()->json([
                'message' => 'Unauthorized: You can only register exit attendance for yourself.',
            ], 403);
        }

        $attendance = Attendance::where('employee_id', $request->employee_id)
            ->whereDate('date', now()->toDateString())
            ->whereNull('end_time')
            ->first();
        if (!$attendance) {
            return response()->json([
                'message' => 'No active attendance found for today. Please mark your arrival first.',
            ], 400);
        }

        $attendance->update([
            'end_time' => now()->toTimeString(),
            'status' => $request->status,
        ]);

        return response()->json([
            'message' => 'Attendance end time recorded successfully.',
            'data' => $attendance
        ], 200);
    }




    public function update(Request $request, $id)
    {
        $attendance = Attendance::find($id);

        if ($attendance) {
            $attendance->update($request->all());
            return response()->json([
                'message' => 'Attendance updated',
                'data' => $attendance
            ], 200);
        } else {
            return response()->json([
                'message' => 'Attendance not found'
            ], 404);
        }
    }


    public function delete($id)
    {
        $attendance = Attendance::find($id);

        if ($attendance) {
            $attendance->delete();
            return response()->json([
                'message' => 'Attendance deleted'
            ], 200);
        } else {
            return response()->json([
                'message' => 'Attendance not found'
            ], 404);
        }
    }
}
