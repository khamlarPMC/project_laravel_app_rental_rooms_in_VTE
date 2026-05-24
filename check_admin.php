<?php
// Simple database check script
$host = '127.0.0.1';
$username = 'root';
$password = '';
$database = 'db_rental_rooms';

try {
    $conn = new mysqli($host, $username, $password, $database);
    
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    // Check if admin exists
    $sql = "SELECT id, name, email, role_id, password FROM users WHERE email = 'admin@mail.com'";
    $result = $conn->query($sql);
    
    if ($result->num_rows > 0) {
        echo "✓ Admin user found!\n";
        $row = $result->fetch_assoc();
        echo "ID: " . $row['id'] . "\n";
        echo "Name: " . $row['name'] . "\n";
        echo "Email: " . $row['email'] . "\n";
        echo "Role ID: " . $row['role_id'] . "\n";
        echo "Password Hash: " . substr($row['password'], 0, 20) . "...\n";
        
        // Check all users
        echo "\n--- All Users ---\n";
        $sql2 = "SELECT id, name, email, role_id FROM users";
        $result2 = $conn->query($sql2);
        while ($row2 = $result2->fetch_assoc()) {
            echo "ID: " . $row2['id'] . " | Name: " . $row2['name'] . " | Email: " . $row2['email'] . " | Role: " . $row2['role_id'] . "\n";
        }
    } else {
        echo "✗ Admin user NOT found!\n";
        echo "\nAll users in database:\n";
        $sql = "SELECT id, name, email, role_id FROM users";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                echo "ID: " . $row['id'] . " | Name: " . $row['name'] . " | Email: " . $row['email'] . " | Role: " . $row['role_id'] . "\n";
            }
        } else {
            echo "No users in database!\n";
        }
    }
    
    $conn->close();
} catch (Exception $e) {
    echo "Error: " . $e->getMessage();
}
?>
