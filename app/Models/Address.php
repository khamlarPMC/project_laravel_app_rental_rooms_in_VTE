<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Address extends Model
{
    protected $table = 'address';
    protected $primaryKey = 'address_id';
    public $timestamps = false;

    protected $fillable = [
        'village',
        'district',
        'province',
    ];

    public function users()
    {
        return $this->hasMany(User::class, 'address_id', 'address_id');
    }
}
