<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Department extends Model
{
    protected $table = 'departments';
    protected $fillable = ['name', 'location', 'manager_id'];

    public function manager()
    {
        return $this->belongsTo(Employee::class);
    }
}
