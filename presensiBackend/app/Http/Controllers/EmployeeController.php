<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
    public function index()
    {
        return response()->json([
            'message' => 'success',
            'data' => Employee::all()
        ], 200);
    }

    public function showEmployee()
    {
        return response()->json([
            'message' => 'success',
            'data' => Employee::where('position', 'employee')->get()
        ], 200);
    }

    public function showManager()
    {
        return response()->json([
            'message' => 'success',
            'data' => Employee::where('position', 'manager')->get()
        ], 200);
    }

    public function showEmployeeByID($id)
    {
        $employee = Employee::find($id);

        if ($employee) {
            return response()->json([
                'message' => 'success',
                'data' => $employee
            ], 200);
        } else {
            return response()->json([
                'message' => 'Employee not found'
            ], 404);
        }
    }

    public function storeEmployee(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:employees',
            'password' => 'required',
            'phone' => 'required',
            'department_id' => 'required|exists:departments,id',
        ]);

        $request['position'] = 'employee';

        $employee = Employee::create($request->all());

        return response()->json([
            'message' => 'Employee created',
            'data' => $employee
        ], 201);
    }

    public function storeManager(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'email' => 'required|email|unique:employees',
            'password' => 'required',
            'phone' => 'required',
            'department_id' => 'required|exists:departments,id'
        ]);

        $employee = Employee::create($request->all());
        $employee->position = 'manager';
        $employee->manager_id = $employee->id;
        $employee->save();

        return response()->json([
            'message' => 'Manager created',
            'data' => $employee
        ], 201);
    }

    public function updateEmployee(Request $request, $id)
    {
        $employee = Employee::find($id);

        if ($employee) {
            $request->validate([
                'name' => 'required',
                'email' => 'required|email|unique:employees,email,' . $id,
                'phone' => 'required',
                'department_id' => 'required|exists:departments,id',
            ]);

            $employee->update($request->all());

            return response()->json([
                'message' => 'Employee updated',
                'data' => $employee
            ], 200);
        } else {
            return response()->json([
                'message' => 'Employee not found'
            ], 404);
        }
    }

    public function updateManager(Request $request, $id)
    {
        $employee = Employee::find($id);

        if ($employee) {
            $request->validate([
                'name' => 'required',
                'email' => 'required|email|unique:employees,email,' . $id,
                'phone' => 'required',
                'department_id' => 'required|exists:departments,id',
            ]);

            $employee->update($request->all());
            $employee->manager_id = $employee->id;
            $employee->save();

            return response()->json([
                'message' => 'Manager updated',
                'data' => $employee
            ], 200);
        } else {
            return response()->json([
                'message' => 'Manager not found'
            ], 404);
        }
    }

    public function update($id, Request $request)
    {
        $employee = Employee::find($id);

        if ($employee) {
            $request->validate([
                'name' => 'required',
                'email' => 'required|email|unique:employees,email,' . $id,
                'phone' => 'required',
                'position' => 'required|in:employee,manager',
                'manager_id' => 'required|exists:employees,id',
                'department_id' => 'required|exists:departments,id',
            ]);

            return response()->json([
                'message' => 'Employee updated',
                'data' => $employee
            ], 200);
        } else {
            return response()->json([
                'message' => 'Employee not found'
            ], 404);
        }
    }

    public function delete($id)
    {
        $employee = Employee::find($id);

        if ($employee) {
            $employee->delete();

            return response()->json([
                'message' => 'Employee deleted'
            ], 200);
        } else {
            return response()->json([
                'message' => 'Employee not found'
            ], 404);
        }
    }
}
