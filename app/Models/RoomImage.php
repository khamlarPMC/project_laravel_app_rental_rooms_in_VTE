<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class RoomImage extends Model
{
    protected $table = 'room_image';
    protected $primaryKey = 'image_id';
    public $timestamps = false;

    protected $fillable = [
        'image_url',
        'room_id',
        'is_main',
    ];

    protected $casts = [
        'is_main' => 'boolean',
    ];

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'room_id');
    }
}
