<?php

namespace App\Http\Controllers;

use App\Models\Department;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class DepartmentController extends Controller
{
    public function index()
    {
        $departments = Department::all();
        $employees = [];
        foreach ($departments as $department) {
            $employees[] = $department->employees;
        }
        return response()->json([
            'message' => 'success',
            'data' => $departments
        ], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'location' => 'required',
        ]);

        $department = Department::create($request->all());
        return response()->json([
            'message' => 'Department created',
            'data' => $department
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
            'location' => 'required',
        ]);

        $department = Department::find($id);
        if ($department) {
            $department->update($request->all());
            return response()->json([
                'message' => 'Department updated',
                'data' => $department
            ], 200);
        } else {
            return response()->json([
                'message' => 'Department not found'
            ], 404);
        }
    }

    public function delete($id)
    {
        $department = Department::find($id);
        if ($department) {
            $department->delete();
            return response()->json([
                'message' => 'Department deleted'
            ], 200);
        } else {
            return response()->json([
                'message' => 'Department not found'
            ], 404);
        }
    }

    public function show($id)
    {
        $department = Department::with('employees')->find($id);

        if ($department) {
            return response()->json([
                'message' => 'success',
                'data' => $department
            ], 200);
        } else {
            return response()->json([
                'message' => 'Department not found'
            ], 404);
        }
    }

    public function getDepartmentByAuth()
    {
        $user = Auth::user();
        $department = Department::where('user_id', $user->id)->get();
        return response()->json([
            'message' => 'success',
            'data' => $department
        ], 200);
    }
}
