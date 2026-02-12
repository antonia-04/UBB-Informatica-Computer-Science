<?php
$conn = new mysqli("localhost", "root", "", "BookDemo");
$result = $conn->query("SELECT id FROM books");
$ids = [];
while ($row = $result->fetch_assoc()) {
    $ids[] = $row['id'];
}
echo json_encode($ids);
?>
