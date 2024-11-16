<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    protected $table = 'schedule';

    protected $fillable = [
        'date',
        'start_time',
        'end_time',
        'user_id'
    ];

    protected function user()
    {
        return $this->belongsTo(User::class);
    }
}
