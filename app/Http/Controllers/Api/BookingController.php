<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use Illuminate\Http\Request;

class BookingController extends Controller
{
    /**
     * Store a newly created booking request in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'room_id' => 'required|exists:room,room_id',
            'move_in_date' => 'required|date',
            'move_out_date' => 'nullable|date|after:move_in_date',
            'total_months' => 'required|integer|min:1',
        ]);

        $room = Room::find($validated['room_id']);

        // Prevent owner from booking their own room
        if ($room->owner_id == $request->user()->user_id) {
            return response()->json([
                'success' => false,
                'message' => 'You cannot book your own room.',
            ], 400);
        }

        // Check if room is available
        if ($room->room_status !== 'available') {
            return response()->json([
                'success' => false,
                'message' => 'This room is not available for booking.',
            ], 400);
        }

        $booking = Booking::create([
            'tenant_id' => $request->user()->user_id,
            'room_id' => $validated['room_id'],
            'booking_date' => now(),
            'move_in_date' => $validated['move_in_date'],
            'move_out_date' => $validated['move_out_date'],
            'total_months' => $validated['total_months'],
            'booking_status' => 'pending',
        ]);

        return response()->json([
            'success' => true,
            'data' => $booking->load(['room', 'tenant']),
        ], 201);
    }

    /**
     * Display a listing of bookings for the current tenant.
     */
    public function index(Request $request)
    {
        $bookings = Booking::where('tenant_id', $request->user()->user_id)
            ->with(['room.address', 'room.images'])
            ->orderBy('booking_date', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $bookings,
        ]);
    }

    /**
     * Display bookings for rooms owned by the current user.
     */
    public function ownerBookings(Request $request)
    {
        $bookings = Booking::whereHas('room', function ($query) use ($request) {
            $query->where('owner_id', $request->user()->user_id);
        })
            ->with(['room', 'tenant'])
            ->orderBy('booking_date', 'desc')
            ->get();

        return response()->json([
            'success' => true,
            'data' => $bookings,
        ]);
    }

    /**
     * Update booking status (for owner).
     */
    public function updateStatus(Request $request, $id)
    {
        $booking = Booking::with('room')->find($id);

        if (! $booking) {
            return response()->json(['success' => false, 'message' => 'Booking not found'], 404);
        }

        // Verify ownership
        if ($booking->room->owner_id !== $request->user()->user_id) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        $validated = $request->validate([
            'status' => 'required|in:confirmed,cancelled,completed',
        ]);

        $booking->update([
            'booking_status' => $validated['status'],
        ]);

        // If confirmed, update room status to occupied
        if ($validated['status'] === 'confirmed') {
            $booking->room->update(['room_status' => 'occupied']);
        }

        return response()->json([
            'success' => true,
            'data' => $booking,
        ]);
    }

    /**
     * Cancel booking (for tenant).
     */
    public function cancel(Request $request, $id)
    {
        $booking = Booking::find($id);

        if (! $booking) {
            return response()->json(['success' => false, 'message' => 'Booking not found'], 404);
        }

        // Verify tenant ownership
        if ($booking->tenant_id !== $request->user()->user_id) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        // Only allow cancellation if pending
        if ($booking->booking_status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Only pending bookings can be cancelled.',
            ], 400);
        }

        $booking->update([
            'booking_status' => 'cancelled',
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Booking cancelled successfully',
            'data' => $booking,
        ]);
    }

    /**
     * Update booking details (for tenant).
     */
    public function update(Request $request, $id)
    {
        $booking = Booking::find($id);

        if (! $booking) {
            return response()->json(['success' => false, 'message' => 'Booking not found'], 404);
        }

        // Verify tenant ownership
        if ($booking->tenant_id !== $request->user()->user_id) {
            return response()->json(['success' => false, 'message' => 'Unauthorized'], 403);
        }

        // Only allow edit if pending
        if ($booking->booking_status !== 'pending') {
            return response()->json([
                'success' => false,
                'message' => 'Only pending bookings can be edited.',
            ], 400);
        }

        $validated = $request->validate([
            'move_in_date' => 'required|date',
            'move_out_date' => 'nullable|date|after:move_in_date',
            'total_months' => 'required|integer|min:1',
        ]);

        $booking->update([
            'move_in_date' => $validated['move_in_date'],
            'move_out_date' => $validated['move_out_date'],
            'total_months' => $validated['total_months'],
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Booking updated successfully',
            'data' => $booking->load('room'),
        ]);
    }
}
