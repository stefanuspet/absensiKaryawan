<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    protected $table = 'schedules';

    protected $fillable = [
        'date', 'time', 'employee_id'
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }

    public function scopeEmployeeSchedule($query, $employee_id)
    {
        return $query->where('employee_id', $employee_id);
    }
}
