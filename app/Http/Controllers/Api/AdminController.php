<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use App\Models\User;

class AdminController extends Controller
{
    public function getAllUsers()
    {
        $users = User::with(['role', 'address'])->get();

        return response()->json(['data' => $users]);
    }

    public function deleteUser($id)
    {
        $user = User::find($id);
        if (! $user) {
            return response()->json(['message' => 'User not found'], 404);
        }
        if ($user->role_id == 3) {
            return response()->json(['message' => 'Cannot delete an administrator'], 403);
        }
        $user->delete();

        return response()->json(['message' => 'User deleted successfully']);
    }

    public function getAllRooms()
    {
        $rooms = Room::with(['owner', 'address', 'images', 'amenities'])->get();

        return response()->json(['data' => $rooms]);
    }

    public function deleteRoom($id)
    {
        $room = Room::find($id);
        if (! $room) {
            return response()->json(['message' => 'Room not found'], 404);
        }
        $room->delete();

        return response()->json(['message' => 'Room deleted successfully']);
    }

    public function approveRoom($id)
    {
        $room = Room::find($id);
        if (! $room) {
            return response()->json(['message' => 'Room not found'], 404);
        }
        $room->is_approved = true;
        $room->save();

        return response()->json([
            'success' => true,
            'message' => 'Room approved successfully',
            'data' => $room,
        ]);
    }

    public function getAllBookings()
    {
        $bookings = Booking::with(['tenant', 'room'])->get();

        return response()->json(['data' => $bookings]);
    }

    public function cancelBooking($id)
    {
        $booking = Booking::find($id);
        if (! $booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }
        $booking->booking_status = 'cancelled';
        $booking->save();

        return response()->json(['message' => 'Booking cancelled successfully', 'data' => $booking]);
    }

    public function deleteBooking($id)
    {
        $booking = Booking::find($id);
        if (! $booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }
        $booking->delete();

        return response()->json(['message' => 'Booking deleted successfully']);
    }

    public function getStats()
    {
        $totalUsers = User::count();
        $totalRooms = Room::count();
        $totalBookings = Booking::count();
        $totalRevenue = Room::sum('price_per_month');

        return response()->json([
            'data' => [
                'total_users' => $totalUsers,
                'total_rooms' => $totalRooms,
                'total_bookings' => $totalBookings,
                'total_revenue' => (float) $totalRevenue,
            ],
        ]);
    }
}
