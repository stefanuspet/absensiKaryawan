<?php

use App\Http\Controllers\AttendanceController;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\DepartmentController;
use App\Http\Controllers\ScheduleController;
use App\Http\Controllers\UserController;
use Illuminate\Support\Facades\Route;

Route::post('/login', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);


Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/myschedule', [ScheduleController::class, 'getScheduleByAuth']);

    Route::get('/mydepartment', [DepartmentController::class, 'getDepartmentByAuth']);

    Route::get('/logout', [AuthController::class, 'logout']);
    Route::get('/profile', [UserController::class, 'getProfile']);
    Route::put('/profile', [UserController::class, 'updateProfile']);

    Route::post('/attendance-checkin', [AttendanceController::class, 'checkin']);
    Route::post('/attendance-checkout', [AttendanceController::class, 'checkout']);
    Route::post('/attendance-leave', [AttendanceController::class, 'requestLeave']);
    Route::get('/myattendance', [AttendanceController::class, 'getAttendanceByAuth']);
});



Route::middleware(['auth:sanctum', 'abilities:admin'])->group(function () {
    Route::get('/users', [UserController::class, 'index']);
    Route::get('/users/{id}', [UserController::class, 'show']);

    Route::get('/userschedule/{id}', [ScheduleController::class, 'getScheduleByUser']);
    Route::post('/schedules', [ScheduleController::class, 'store']);
    Route::get('/schedules', [ScheduleController::class, 'index']);
    Route::put('/schedules/{id}', [ScheduleController::class, 'update']);
    Route::delete('/schedules/{id}', [ScheduleController::class, 'destroy']);

    Route::get('/department', [DepartmentController::class, 'index']);
    Route::post('/department', [DepartmentController::class, 'store']);
    Route::put('/department/{id}', [DepartmentController::class, 'update']);
    Route::delete('/department/{id}', [DepartmentController::class, 'delete']);
    Route::get('/department/{id}', [DepartmentController::class, 'show']);

    // attendance
    Route::get('/attendance', [AttendanceController::class, 'index']);
    Route::get('/attendance/{id}', [AttendanceController::class, 'getAttendanceByUser']);
    Route::put('/attendance/{id}', [AttendanceController::class, 'update']);
});
