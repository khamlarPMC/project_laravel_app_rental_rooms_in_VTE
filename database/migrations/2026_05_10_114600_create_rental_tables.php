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
        Schema::create('amenity', function (Blueprint $table) {
            $table->id('amenity_id');
            $table->string('amenity_name', 100)->nullable();
        });

        Schema::create('room', function (Blueprint $table) {
            $table->id('room_id');
            $table->unsignedBigInteger('owner_id')->nullable();
            $table->string('room_name', 100);
            $table->decimal('price_per_month', 10, 2);
            $table->text('description')->nullable();
            $table->enum('room_status', ['available', 'occupied'])->default('available');
            $table->unsignedBigInteger('address_id')->nullable();
            $table->timestamp('created_at')->useCurrent();

            $table->foreign('owner_id')->references('user_id')->on('user')->nullOnDelete();
            $table->foreign('address_id')->references('address_id')->on('address')->nullOnDelete();
        });

        Schema::create('room_image', function (Blueprint $table) {
            $table->id('image_id');
            $table->string('image_url', 255);
            $table->unsignedBigInteger('room_id')->nullable();
            $table->boolean('is_main')->default(false);

            $table->foreign('room_id')->references('room_id')->on('room')->cascadeOnDelete();
        });

        Schema::create('room_amenity', function (Blueprint $table) {
            $table->unsignedBigInteger('room_id');
            $table->unsignedBigInteger('amenity_id');

            $table->primary(['room_id', 'amenity_id']);
            $table->foreign('room_id')->references('room_id')->on('room')->cascadeOnDelete();
            $table->foreign('amenity_id')->references('amenity_id')->on('amenity')->cascadeOnDelete();
        });

        Schema::create('booking', function (Blueprint $table) {
            $table->id('booking_id');
            $table->unsignedBigInteger('tenant_id')->nullable();
            $table->unsignedBigInteger('room_id')->nullable();
            $table->dateTime('booking_date')->useCurrent();
            $table->date('move_in_date');
            $table->date('move_out_date')->nullable();
            $table->integer('total_months')->nullable();
            $table->enum('booking_status', ['pending', 'confirmed', 'cancelled'])->default('pending');

            $table->foreign('tenant_id')->references('user_id')->on('user')->nullOnDelete();
            $table->foreign('room_id')->references('room_id')->on('room')->nullOnDelete();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('booking');
        Schema::dropIfExists('room_amenity');
        Schema::dropIfExists('room_image');
        Schema::dropIfExists('room');
        Schema::dropIfExists('amenity');
    }
};
