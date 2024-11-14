<?php

namespace App\Http\Controllers;

use App\Models\Department;
use Illuminate\Http\Request;

class DepartmentController extends Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'success',
            'data' => Department::all()
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
}
