<?php

namespace Database\Seeders;

use App\Models\Amenity;
use Illuminate\Database\Seeder;

class AmenitySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $amenities = [
            'Free Wi-Fi',
            'Air Conditioning',
            'Kitchen',
            'Washing Machine',
            'TV',
            'Parking',
            'Swimming Pool',
            'Gym',
            'Pet Friendly',
            'Security',
        ];

        foreach ($amenities as $name) {
            Amenity::firstOrCreate(['amenity_name' => $name]);
        }
    }
}
