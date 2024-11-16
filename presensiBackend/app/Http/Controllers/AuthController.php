<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use App\Models\Employee;
use App\Models\User;
use Illuminate\Database\Capsule\Manager;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // Periksa apakah login untuk admin
        $user = User::where('email', $request->email)->first();
        if ($user && Hash::check($request->password, $user->password)) {
            if ($user->role == 'Administrator') {
                $token = $user->createToken('admin-token', ["admin"])->plainTextToken;
                return response()->json([
                    'message' => 'success',
                    'data' => $user,
                    'token' => $token
                ], 200);
            } else {
                $token = $user->createToken('user-token', ['user'])->plainTextToken;
                return response()->json([
                    'message' => 'success',
                    'data' => $user,
                    'token' => $token
                ], 200);
            }
        }


        return response()->json([
            'message' => 'Unauthorized',
            'errors' => 'Email or Password invalid'
        ], 401);
    }

    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required|email',
            'password' => 'required',
            'phone' => 'required',
            'department_id' => 'required'
        ]);

        $user = new User();
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = Hash::make($request->password);
        $user->phone = $request->phone;
        $user->department_id = $request->department_id;
        $user->role = 'employee';

        $user->save();

        return response()->json([
            'message' => 'success',
            'data' => $user
        ], 201);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json([
            'message' => 'Logout...'
        ], 200);
    }
}
