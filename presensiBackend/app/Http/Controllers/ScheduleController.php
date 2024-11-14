<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;

class ScheduleController extends Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'success',
            'data' => Schedule::all()
        ], 200);
    }

    public function showScheduleByEmployee($employee_id)
    {
        $schedule = Schedule::where('employee_id', $employee_id)->get();

        if ($schedule) {
            return response()->json([
                'message' => 'success',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function showScheduleByDate($date)
    {
        $schedule = Schedule::where('date', $date)->get();

        if ($schedule) {
            return response()->json([
                'message' => 'success',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function showScheduleByEmployeeAndDate($employee_id, $date)
    {
        $schedule = Schedule::where('employee_id', $employee_id)->where('date', $date)->get();

        if ($schedule) {
            return response()->json([
                'message' => 'success',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function store(Request $request)
    {
        $request->validate([
            'date' => 'required',
            'time' => 'required',
            'employee_id' => 'required|exists:employees,id',
        ]);

        $schedule = Schedule::create($request->all());

        return response()->json([
            'message' => 'Schedule created',
            'data' => $schedule
        ], 201);
    }


    public function update(Request $request, $id)
    {
        $schedule = Schedule::find($id);

        if ($schedule) {
            $request->validate([
                'date' => 'required',
                'time' => 'required',
                'employee_id' => 'required|exists:employees,id',
            ]);

            $schedule->update($request->all());

            return response()->json([
                'message' => 'Schedule updated',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function delete($id)
    {
        $schedule = Schedule::find($id);

        if ($schedule) {
            $schedule->delete();
            return response()->json([
                'message' => 'Schedule deleted'
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function showScheduleByID($id)
    {
        $schedule = Schedule::find($id);

        if ($schedule) {
            return response()->json([
                'message' => 'success',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }

    public function showScheduleByEmployeeAndTime($employee_id, $time)
    {
        $schedule = Schedule::where('employee_id', $employee_id)->where('time', $time)->get();

        if ($schedule) {
            return response()->json([
                'message' => 'success',
                'data' => $schedule
            ], 200);
        } else {
            return response()->json([
                'message' => 'Schedule not found'
            ], 404);
        }
    }
}
