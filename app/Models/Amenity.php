<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Amenity extends Model
{
    protected $table = 'amenity';
    protected $primaryKey = 'amenity_id';
    public $timestamps = false;

    protected $fillable = [
        'amenity_name',
    ];

    public function rooms()
    {
        return $this->belongsToMany(Room::class, 'room_amenity', 'amenity_id', 'room_id');
    }
}
