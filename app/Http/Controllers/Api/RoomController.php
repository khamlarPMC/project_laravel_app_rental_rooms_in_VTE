<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Room;
use Illuminate\Http\Request;

class RoomController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $rooms = Room::where('is_approved', true)->with(['owner', 'address', 'images', 'amenities'])->get();
        return response()->json([
            'success' => true,
            'data' => $rooms
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show($id)
    {
        $room = Room::with(['owner', 'address', 'images', 'amenities'])->find($id);

        if (!$room) {
            return response()->json([
                'success' => false,
                'message' => 'Room not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $room
        ]);
    }

    /**
     * Display rooms for the authenticated owner.
     */
    public function myRooms(Request $request)
    {
        $rooms = Room::where('owner_id', $request->user()->user_id)
            ->with(['owner', 'address', 'images', 'amenities'])
            ->get();
            
        return response()->json([
            'success' => true,
            'data' => $rooms
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'room_name' => 'required|string|max:100',
            'price_per_month' => 'required|numeric',
            'description' => 'nullable|string',
            'village' => 'required|string',
            'district' => 'required|string',
            'province' => 'nullable|string',
            'images' => 'nullable|array',
            'images.*' => 'image|mimes:jpeg,png,jpg,gif,webp|max:20480',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:20480',
            'amenities' => 'nullable|array',
            'amenities.*' => 'exists:amenity,amenity_id',
        ]);

        // Create Address
        $address = \App\Models\Address::create([
            'village' => $validated['village'],
            'district' => $validated['district'],
            'province' => $validated['province'] ?? 'Vientiane',
        ]);

        // Create Room
        $room = Room::create([
            'owner_id' => $request->user()->user_id,
            'room_name' => $validated['room_name'],
            'price_per_month' => $validated['price_per_month'],
            'description' => $validated['description'],
            'address_id' => $address->address_id,
            'room_status' => 'available',
        ]);

        // Handle images if any
        $this->saveUploadedImages($request, $room);

        // Handle amenities
        if ($request->has('amenities')) {
            $room->amenities()->sync($validated['amenities']);
        }

        return response()->json([
            'success' => true,
            'data' => $room->load(['address', 'images', 'amenities'])
        ], 201);
    }

    protected function saveUploadedImages(Request $request, Room $room)
    {
        $uploadedImages = null;

        if ($request->hasFile('images')) {
            $uploadedImages = $request->file('images');
        } elseif ($request->hasFile('image')) {
            $uploadedImages = $request->file('image');
        }

        if (! $uploadedImages) {
            return;
        }

        if (! is_array($uploadedImages)) {
            $uploadedImages = [$uploadedImages];
        }

        foreach ($uploadedImages as $image) {
            $path = $this->compressAndStoreImage($image);
            \App\Models\RoomImage::create([
                'room_id' => $room->room_id,
                'image_url' => $path,
                'is_main' => false,
            ]);
        }
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, $id)
    {
        $room = Room::find($id);

        if (!$room) {
            return response()->json([
                'success' => false,
                'message' => 'Room not found'
            ], 404);
        }

        $validated = $request->validate([
            'room_name' => 'required|string|max:100',
            'price_per_month' => 'required|numeric',
            'description' => 'nullable|string',
            'village' => 'required|string',
            'district' => 'required|string',
            'province' => 'nullable|string',
            'images' => 'nullable|array',
            'images.*' => 'image|mimes:jpeg,png,jpg,gif,webp|max:20480',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif,webp|max:20480',
            'removed_images' => 'nullable|array',
            'amenities' => 'nullable|array',
            'amenities.*' => 'exists:amenity,amenity_id',
        ]);

        // Update Address
        if ($room->address_id) {
            $address = \App\Models\Address::find($room->address_id);
            if ($address) {
                $address->update([
                    'village' => $validated['village'],
                    'district' => $validated['district'],
                    'province' => $validated['province'] ?? $address->province,
                ]);
            }
        }

        // Update Room
        $room->update([
            'room_name' => $validated['room_name'],
            'price_per_month' => $validated['price_per_month'],
            'description' => $validated['description'],
        ]);

        // Handle removed images
        if ($request->has('removed_images')) {
            foreach ($request->removed_images as $fileName) {
                $imageRecord = \App\Models\RoomImage::where('room_id', $id)
                    ->where('image_url', 'like', '%' . $fileName . '%')
                    ->first();
                
                if ($imageRecord) {
                    // Delete from storage
                    \Illuminate\Support\Facades\Storage::disk('public')->delete($imageRecord->image_url);
                    // Delete from database
                    $imageRecord->delete();
                }
            }
        }

        // Handle new images
        $this->saveUploadedImages($request, $room);

        // Handle amenities
        if ($request->has('amenities')) {
            $room->amenities()->sync($validated['amenities']);
        }

        return response()->json([
            'success' => true,
            'data' => $room->load(['address', 'images', 'amenities'])
        ]);
    }

    protected function compressAndStoreImage($file)
    {
        $realPath = $file->getRealPath();
        $mime = $file->getMimeType();
        
        $maxDim = 1200;
        list($width, $height) = getimagesize($realPath);
        
        $src = null;
        if (str_contains($mime, 'jpeg') || str_contains($mime, 'jpg')) {
            $src = @imagecreatefromjpeg($realPath);
        } elseif (str_contains($mime, 'png')) {
            $src = @imagecreatefrompng($realPath);
        } elseif (str_contains($mime, 'gif')) {
            $src = @imagecreatefromgif($realPath);
        } elseif (str_contains($mime, 'webp')) {
            $src = @imagecreatefromwebp($realPath);
        }
        
        if (!$src) {
            return $file->store('rooms', 'public');
        }
        
        $newWidth = $width;
        $newHeight = $height;
        if ($width > $maxDim || $height > $maxDim) {
            $ratio = $width / $height;
            if ($ratio > 1) {
                $newWidth = $maxDim;
                $newHeight = $maxDim / $ratio;
            } else {
                $newHeight = $maxDim;
                $newWidth = $maxDim * $ratio;
            }
        }
        
        $dst = imagecreatetruecolor($newWidth, $newHeight);
        
        if (str_contains($mime, 'png') || str_contains($mime, 'webp') || str_contains($mime, 'gif')) {
            imagealphablending($dst, false);
            imagesavealpha($dst, true);
        }
        
        imagecopyresampled($dst, $src, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);
        
        $extension = $file->getClientOriginalExtension();
        if (empty($extension)) {
            $extension = 'jpg';
        }
        $filename = uniqid() . '_' . time() . '.' . $extension;
        
        $tempPath = tempnam(sys_get_temp_dir(), 'compressed_image');
        
        if (str_contains($mime, 'png')) {
            imagepng($dst, $tempPath, 8);
        } elseif (str_contains($mime, 'gif')) {
            imagegif($dst, $tempPath);
        } elseif (str_contains($mime, 'webp')) {
            imagewebp($dst, $tempPath, 80);
        } else {
            imagejpeg($dst, $tempPath, 80);
        }
        
        $storedPath = \Illuminate\Support\Facades\Storage::disk('public')->putFileAs('rooms', new \Illuminate\Http\File($tempPath), $filename);
        
        imagedestroy($src);
        imagedestroy($dst);
        @unlink($tempPath);
        
        return $storedPath;
    }
}
