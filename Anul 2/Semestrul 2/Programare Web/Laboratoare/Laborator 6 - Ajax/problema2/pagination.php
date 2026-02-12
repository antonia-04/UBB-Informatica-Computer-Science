<?php
// exemplu simplu - date statice, poti inlocui cu query la baza de date
$data = [
    ['Nume'=>'Popescu', 'Prenume'=>'Ion', 'Telefon'=>'0712345678', 'Email'=>'ion.popescu@mail.com'],
    ['Nume'=>'Ionescu', 'Prenume'=>'Maria', 'Telefon'=>'0723456789', 'Email'=>'maria.ionescu@mail.com'],
    ['Nume'=>'Georgescu', 'Prenume'=>'Andrei', 'Telefon'=>'0734567890', 'Email'=>'andrei.georgescu@mail.com'],
    ['Nume'=>'Dumitrescu', 'Prenume'=>'Elena', 'Telefon'=>'0745678901', 'Email'=>'elena.dumitrescu@mail.com'],
    ['Nume'=>'Marin', 'Prenume'=>'Cristina', 'Telefon'=>'0756789012', 'Email'=>'cristina.marin@mail.com'],
    ['Nume'=>'Radu', 'Prenume'=>'Alexandru', 'Telefon'=>'0767890123', 'Email'=>'alexandru.radu@mail.com'],
    ['Nume'=>'Vasilescu', 'Prenume'=>'Ioana', 'Telefon'=>'0778901234', 'Email'=>'ioana.vasilescu@mail.com'],
];

// citim pagina si dimensiunea paginii din query
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 3;

// calculam start si end index
$start = ($page - 1) * $perPage;
$slice = array_slice($data, $start, $perPage);

// verificam daca exista pagina urmatoare
$hasNext = count($data) > $start + $perPage;
$hasPrev = $page > 1;

// raspundem cu JSON: inregistrari + daca exista next/prev
header('Content-Type: application/json');
echo json_encode([
    'records' => $slice,
    'hasNext' => $hasNext,
    'hasPrev' => $hasPrev
]);
