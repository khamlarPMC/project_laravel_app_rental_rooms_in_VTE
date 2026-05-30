<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('address', function (Blueprint $table) {
            $table->id('address_id');
            $table->string('village', 100)->nullable();
            $table->string('district', 100)->nullable();
            $table->string('province', 100)->nullable();
        });

        Schema::create('role', function (Blueprint $table) {
            $table->id('role_id');
            $table->string('role_name', 50);
        });

        Schema::create('user', function (Blueprint $table) {
            $table->id('user_id');
            $table->string('name', 100);
            $table->string('email', 100)->unique();
            $table->string('password', 255);
            $table->string('phone', 20)->nullable();
            $table->integer('age')->nullable();
            $table->string('gender', 10)->nullable();
            $table->unsignedBigInteger('role_id')->nullable();
            $table->unsignedBigInteger('address_id')->nullable();

            // Laravel's default timestamps handle created_at and updated_at
            $table->timestamps();

            $table->foreign('role_id')->references('role_id')->on('role');
            $table->foreign('address_id')->references('address_id')->on('address');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user');
        Schema::dropIfExists('role');
        Schema::dropIfExists('address');
    }
};
