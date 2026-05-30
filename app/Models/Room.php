<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    protected $table = 'room';

    protected $primaryKey = 'room_id';

    const UPDATED_AT = null;

    protected $fillable = [
        'owner_id',
        'room_name',
        'price_per_month',
        'description',
        'room_status',
        'address_id',
        'is_approved',
    ];

    protected $casts = [
        'is_approved' => 'boolean',
    ];

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id', 'user_id');
    }

    public function address()
    {
        return $this->belongsTo(Address::class, 'address_id', 'address_id');
    }

    public function images()
    {
        return $this->hasMany(RoomImage::class, 'room_id', 'room_id');
    }

    public function amenities()
    {
        return $this->belongsToMany(Amenity::class, 'room_amenity', 'room_id', 'amenity_id');
    }

    public function bookings()
    {
        return $this->hasMany(Booking::class, 'room_id', 'room_id');
    }
}
