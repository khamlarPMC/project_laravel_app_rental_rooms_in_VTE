<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Room;
use App\Models\User;
use App\Models\Address;

class RoomSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Create an owner user if none exists
        $owner = User::first() ?? User::factory()->create([
            'name' => 'Owner Test',
            'email' => 'owner@test.com',
            'phone' => '123456789',
            'role_id' => 1, // Assuming 1 is Owner
        ]);

        // Create a mock address
        $address = Address::create([
            'village' => 'Village A',
            'district' => 'Central',
            'province' => 'Vientiane',
        ]);

        // Create mock rooms
        Room::create([
            'owner_id' => $owner->user_id,
            'room_name' => 'Luxury Studio Apartment',
            'price_per_month' => 350.00,
            'description' => 'A beautiful luxury studio in the heart of the city.',
            'room_status' => 'available',
            'address_id' => $address->address_id,
            'is_approved' => true,
        ]);

        Room::create([
            'owner_id' => $owner->user_id,
            'room_name' => 'Cozy Single Room',
            'price_per_month' => 150.00,
            'description' => 'Small but cozy room for students.',
            'room_status' => 'occupied',
            'address_id' => $address->address_id,
            'is_approved' => true,
        ]);

        Room::create([
            'owner_id' => $owner->user_id,
            'room_name' => 'Modern One Bedroom',
            'price_per_month' => 250.00,
            'description' => 'Modern apartment with high-speed internet.',
            'room_status' => 'available',
            'address_id' => $address->address_id,
            'is_approved' => true,
        ]);
    }
}
