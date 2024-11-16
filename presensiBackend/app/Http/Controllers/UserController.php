<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class UserController extends Controller
{
    public function getProfile()
    {
        $user = Auth::user();

        return response()->json([
            'message' => 'Profile retrieved successfully',
            'data' => $user
        ], 200);
    }

    public function index()
    {
        $users = User::all();

        return response()->json([
            'message' => 'success',
            'data' => $users
        ], 200);
    }

    public function show($id)
    {
        $user = User::with(['schedules', 'attendances'])->find($id);

        if (!$user) {
            return response()->json([
                'message' => 'User not found'
            ], 404);
        }

        return response()->json([
            'message' => 'success',
            'data' => $user,
        ], 200);
    }
}
