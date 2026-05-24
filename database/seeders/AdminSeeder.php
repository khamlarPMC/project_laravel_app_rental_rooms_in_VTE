<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::updateOrCreate(
            ['email' => 'admin@mail.com'],
            [
                'name' => 'Administrator',
                'password' => Hash::make('12345678'),
                'role_id' => 3,
                'phone' => '02099999999',
                'age' => 30,
                'gender' => 'Other',
            ]
        );
    }
}
