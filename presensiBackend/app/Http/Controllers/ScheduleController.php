<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class ScheduleController extends Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'success',
            'data' => Schedule::all()
        ], 200);
    }

    public function getScheduleByAuth()
    {
        $user = Auth::user();
        $schedules = Schedule::where('user_id', $user->id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $schedules
        ], 200);
    }

    public function getScheduleByUser($id)
    {
        $schedules = Schedule::where('user_id', $id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $schedules
        ], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'date' => 'required',
            'start_time' => 'required|date_format:H:i:s',
            'end_time' => 'required|date_format:H:i:s',
            'user_id' => 'required|exists:users,id'
        ]);

        $schedule = Schedule::create($request->all());
        return response()->json([
            'message' => 'success',
            'data' => $schedule
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'date' => 'required',
            'start_time' => 'required|date_format:H:i:s',
            'end_time' => 'required|date_format:H:i:s',
            'user_id' => 'required|exists:users,id'
        ]);

        $schedule = Schedule::find($id);
        $schedule->update($request->all());
        return response()->json([
            'message' => 'success',
            'data' => $schedule
        ], 200);
    }

    public function destroy($id)
    {
        $schedule = Schedule::find($id);
        $schedule->delete();
        return response()->json([
            'message' => 'success',
            'data' => $schedule
        ], 200);
    }
}
