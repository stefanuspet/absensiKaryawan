<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Department extends Model
{
    protected $table = 'departments';
    protected $fillable = ['name', 'location'];

    public function employees()
    {
        return $this->hasMany(User::class);
    }
}
