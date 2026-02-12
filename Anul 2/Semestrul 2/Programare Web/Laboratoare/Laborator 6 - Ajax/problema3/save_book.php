<?php
$conn = new mysqli("localhost", "root", "", "BookDemo");
$id = (int)$_POST['id'];
$title = $_POST['title'];
$author = $_POST['author'];
$isbn = $_POST['isbn'];

$stmt = $conn->prepare("UPDATE books SET title=?, author=?, isbn=? WHERE id=?");
$stmt->bind_param("sssi", $title, $author, $isbn, $id);
if ($stmt->execute()) {
    echo "Datele au fost salvate cu succes.";
} else {
    echo "Eroare la salvare.";
}
?>
