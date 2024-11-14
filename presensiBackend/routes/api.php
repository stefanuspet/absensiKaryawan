<?php

use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\EmployeeController;
use App\Http\Controllers\ScheduleController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/login', [AuthController::class, 'login']);


Route::middleware(['auth:sanctum', 'abilities:admin'])->group(function () {
    Route::get('/department', [DepartmentController::class, 'index']);
    Route::post('/department', [DepartmentController::class, 'store']);
    Route::put('/department/{id}', [DepartmentController::class, 'update']);
    Route::delete('/department/{id}', [DepartmentController::class, 'delete']);
});

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/employee', [EmployeeController::class, 'index']);
    Route::post('/employee', [EmployeeController::class, 'storeEmployee']);
    Route::post('/manager', [EmployeeController::class, 'storeManager']);
    Route::get('/showEmployee', [EmployeeController::class, 'showEmployee']);
    Route::get('/showManager', [EmployeeController::class, 'showManager']);
    Route::get('/employee/{id}', [EmployeeController::class, 'showEmployeeByID']);
    Route::put('/employee/{id}', [EmployeeController::class, 'updateEmployee']);
    Route::delete('/employee/{id}', [EmployeeController::class, 'delete']);

    // schedule
    Route::get('/schedule', [ScheduleController::class, 'index']);
    Route::get('/schedule/{employee_id}', [ScheduleController::class, 'showScheduleByEmployee']);
    Route::get('/schedule/{date}', [ScheduleController::class, 'showScheduleByDate']);
    Route::get('/schedule/{employee_id}/{date}', [ScheduleController::class, 'showScheduleByEmployeeAndDate']);
    Route::post('/schedule', [ScheduleController::class, 'store']);
    Route::put('/schedule/{id}', [ScheduleController::class, 'update']);
    Route::put('/schedule/{id}', [ScheduleController::class, 'delete']);
    Route::get('/schedule/{id}', [ScheduleController::class, 'showScheduleByID']);


    // attendance
    Route::get('/attendance', [AttendanceController::class, 'index']);
    Route::get('/attendance/{employee_id}', [AttendanceController::class, 'showAttendanceByEmployee']);
    Route::get('/attendance/{date}', [AttendanceController::class, 'showAttendanceByDate']);
    Route::get('/attendance/{employee_id}/{date}', [AttendanceController::class, 'showAttendanceByEmployeeAndDate']);
    Route::post('/attendance', [AttendanceController::class, 'storeArrivalAttendance']);
    Route::post('/attendance/exit', [AttendanceController::class, 'storeExitAttendance']);
    Route::put('/attendance/{id}', [AttendanceController::class, 'update']);
    Route::put('/attendance/{id}', [AttendanceController::class, 'delete']);
});
