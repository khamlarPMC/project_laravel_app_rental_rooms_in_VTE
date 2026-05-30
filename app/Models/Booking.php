<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    protected $table = 'booking';

    protected $primaryKey = 'booking_id';

    public $timestamps = false;

    protected $fillable = [
        'tenant_id',
        'room_id',
        'booking_date',
        'move_in_date',
        'move_out_date',
        'total_months',
        'booking_status',
    ];

    protected $casts = [
        'booking_date' => 'datetime',
        'move_in_date' => 'date',
        'move_out_date' => 'date',
    ];

    public function tenant()
    {
        return $this->belongsTo(User::class, 'tenant_id', 'user_id');
    }

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'room_id');
    }
}
