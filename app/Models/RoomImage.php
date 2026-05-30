<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

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

    public function getImageUrlAttribute($value)
    {
        return Storage::disk('public')->url($value);
    }

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id', 'room_id');
    }
}
