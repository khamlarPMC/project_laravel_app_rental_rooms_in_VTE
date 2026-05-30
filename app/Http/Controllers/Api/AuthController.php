<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Address;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:user',
            'password' => 'required|string|min:8',
            'phone' => 'nullable|string|max:20',
            'age' => 'nullable|integer',
            'gender' => 'nullable|string|max:10',
            'village' => 'nullable|string|max:100',
            'district' => 'nullable|string|max:100',
            'province' => 'nullable|string|max:100',
            'role_id' => 'required|exists:role,role_id',
        ]);

        $addressId = null;
        if ($request->filled(['village', 'district', 'province'])) {
            $address = Address::create([
                'village' => $request->village,
                'district' => $request->district,
                'province' => $request->province,
            ]);
            $addressId = $address->address_id;
        }

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => Hash::make($request->password),
            'phone' => $request->phone,
            'age' => $request->age,
            'gender' => $request->gender,
            'role_id' => $request->role_id,
            'address_id' => $addressId,
        ]);

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'user' => $user->load(['role', 'address']),
            'token' => $token,
            'token_type' => 'Bearer',
        ], 201);
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|string|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (! $user || ! Hash::check($request->password, $user->password)) {
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
            'user' => $user->load(['role', 'address']),
            'token' => $token,
            'token_type' => 'Bearer',
        ]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'message' => 'Successfully logged out',
        ]);
    }

    public function me(Request $request)
    {
        return response()->json($request->user()->load(['role', 'address']));
    }

    public function updateProfile(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'nullable|string|max:20',
            'age' => 'nullable|integer',
            'gender' => 'nullable|string|max:10',
            'village' => 'nullable|string|max:100',
            'district' => 'nullable|string|max:100',
            'province' => 'nullable|string|max:100',
        ]);

        if ($user->address_id) {
            $address = Address::find($user->address_id);
            if ($address) {
                $address->update([
                    'village' => $request->village,
                    'district' => $request->district,
                    'province' => $request->province,
                ]);
            }
        } else {
            if ($request->filled(['village', 'district', 'province'])) {
                $address = Address::create([
                    'village' => $request->village,
                    'district' => $request->district,
                    'province' => $request->province,
                ]);
                $user->address_id = $address->address_id;
            }
        }

        $user->update([
            'name' => $request->name,
            'phone' => $request->phone,
            'age' => $request->age,
            'gender' => $request->gender,
        ]);

        return response()->json([
            'message' => 'Profile updated successfully',
            'user' => $user->load(['role', 'address']),
        ]);
    }
}
