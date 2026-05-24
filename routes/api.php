<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\RoomController;
use App\Http\Controllers\Api\BookingController;
use App\Http\Controllers\Api\AmenityController;
use App\Http\Controllers\Api\AdminController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/rooms', [RoomController::class, 'index']);
Route::get('/rooms/{id}', [RoomController::class, 'show']);
Route::get('/amenities', [AmenityController::class, 'index']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', [AuthController::class, 'me']);
    Route::put('/user', [AuthController::class, 'updateProfile']);
    
    Route::get('/owner/rooms', [RoomController::class, 'myRooms']);
    Route::post('/rooms', [RoomController::class, 'store']);
    Route::put('/rooms/{id}', [RoomController::class, 'update']);

    // Booking Routes
    Route::get('/bookings', [BookingController::class, 'index']);
    Route::post('/bookings', [BookingController::class, 'store']);
    Route::get('/owner/bookings', [BookingController::class, 'ownerBookings']);
    Route::patch('/bookings/{id}/status', [BookingController::class, 'updateStatus']);
    Route::patch('/bookings/{id}/cancel', [BookingController::class, 'cancel']);
    Route::put('/bookings/{id}', [BookingController::class, 'update']);
    
    // Admin Routes
    Route::get('/admin/users', [AdminController::class, 'getAllUsers']);
    Route::delete('/admin/users/{id}', [AdminController::class, 'deleteUser']);
    Route::get('/admin/rooms', [AdminController::class, 'getAllRooms']);
    Route::delete('/admin/rooms/{id}', [AdminController::class, 'deleteRoom']);
    Route::patch('/admin/rooms/{id}/approve', [AdminController::class, 'approveRoom']);
    Route::get('/admin/bookings', [AdminController::class, 'getAllBookings']);
    Route::patch('/admin/bookings/{id}/cancel', [AdminController::class, 'cancelBooking']);
    Route::delete('/admin/bookings/{id}', [AdminController::class, 'deleteBooking']);
    Route::get('/admin/stats', [AdminController::class, 'getStats']);
});
