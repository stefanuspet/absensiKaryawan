<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Attendance extends Model
{
    protected $table = 'attendance';

    protected $fillable = [
        'employee_id', 'date', 'start_time', 'end_time', 'status'
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public function scopeEmployeeAttendance($query, $employee_id)
    {
        return $query->where('employee_id', $employee_id);
    }

    public function scopeDate($query, $date)
    {
        return $query->where('date', $date);
    }

    public function scopeStatus($query, $status)
    {
        return $query->where('status', $status);
    }

    public function scopeCheckIn($query)
    {
        return $query->where('start_time', '!=', null);
    }


}
