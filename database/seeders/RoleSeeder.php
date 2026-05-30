<?php

namespace Database\Seeders;

use App\Models\Role;
use Illuminate\Database\Seeder;

class RoleSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $roles = [
            ['role_id' => 1, 'role_name' => 'Owner'],
            ['role_id' => 2, 'role_name' => 'Tenant'],
            ['role_id' => 3, 'role_name' => 'Administrator'],
        ];

        foreach ($roles as $role) {
            Role::updateOrCreate(
                ['role_id' => $role['role_id']],
                ['role_name' => $role['role_name']]
            );
        }
    }
}
