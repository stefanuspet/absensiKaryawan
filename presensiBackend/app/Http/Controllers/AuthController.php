<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use App\Models\Employee;
use Illuminate\Database\Capsule\Manager;
use Illuminate\Http\Request;
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
        $admin = Admin::where('email', $request->email)->first();
        if ($admin && Hash::check($request->password, $admin->password)) {
            $token = $admin->createToken("admin", ['admin'])->plainTextToken;
            return response()->json([
                "message" => "Login Success",
                'role' => 'admin',
                "token" => $token
            ], 200);
        }

        $employee = Employee::where('email', $request->email)->first();
        if ($employee && Hash::check($request->password, $employee->password)) {
            if ($employee->position == 'manager') {
                $token = $employee->createToken("manager", ['manager'])->plainTextToken;
                return response()->json([
                    "message" => "Login Success",
                    'role' => 'manager',
                    "token" => $token
                ], 200);
            } else {
                $token = $employee->createToken("employee", ['employee'])->plainTextToken;
                return response()->json([
                    "message" => "Login Success",
                    'role' => 'employee',
                    "token" => $token
                ], 200);
            }
        }


        return response()->json([
            'message' => 'Unauthorized',
            'errors' => 'Email or Password invalid'
        ], 401);
    }
}
