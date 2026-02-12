<?php
$conn = new mysqli("localhost", "root", "", "BookDemo");
$id = (int)$_GET['id'];
$stmt = $conn->prepare("SELECT title, author, isbn FROM books WHERE id=?");
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();
echo json_encode($result->fetch_assoc());
?>
