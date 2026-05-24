<?php
// Direct database connection without Laravel autoload
$mysqli = new mysqli('127.0.0.1', 'root', '', 'db_rental_rooms');

if ($mysqli->connect_error) {
    echo "Connection Error: " . $mysqli->connect_error;
    exit;
}

// Check all tables
echo "=== CHECKING DATABASE ===\n";
$result = $mysqli->query("SHOW TABLES;");
echo "Tables in database:\n";
while ($row = $result->fetch_row()) {
    echo "  - " . $row[0] . "\n";
}

// Check users table
echo "\n=== CHECKING USERS ===\n";
$result = $mysqli->query("SELECT * FROM user;");
if ($result) {
    if ($result->num_rows > 0) {
        echo "Found " . $result->num_rows . " users:\n";
        while ($row = $result->fetch_assoc()) {
            echo "  ID: " . $row['user_id'] . " | Name: " . $row['name'] . " | Email: " . $row['email'] . " | Role: " . $row['role_id'] . "\n";
        }
    } else {
        echo "No users in database!\n";
    }
} else {
    echo "Error querying users: " . $mysqli->error . "\n";
}

// Check for admin
echo "\n=== CHECKING ADMIN ===\n";
$result = $mysqli->query("SELECT * FROM user WHERE email = 'admin@mail.com';");
if ($result && $result->num_rows > 0) {
    echo "✓ Admin account exists!\n";
    $user = $result->fetch_assoc();
    echo "Name: " . $user['name'] . "\n";
    echo "Email: " . $user['email'] . "\n";
    echo "Role ID: " . $user['role_id'] . "\n";
    echo "Password Hash: " . substr($user['password'], 0, 30) . "...\n";
} else {
    echo "✗ Admin account NOT found\n";
    echo "Need to run seeder: php artisan db:seed --class=AdminSeeder\n";
}

$mysqli->close();
?>
