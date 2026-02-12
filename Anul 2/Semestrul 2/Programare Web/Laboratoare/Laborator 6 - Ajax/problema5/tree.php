<?php
// Rădăcina explorată
$baseDir = realpath(__DIR__); // adică laboratorajax/problema5

// Path relativ din query
$path = isset($_GET['path']) ? $_GET['path'] : '';
$target = realpath($baseDir . DIRECTORY_SEPARATOR . $path);

// Verificăm ca targetul să fie în interiorul baseDir
if (strpos($target, $baseDir) !== 0 || !is_dir($target)) {
    echo json_encode([]);
    exit;
}

$items = [];
foreach (scandir($target) as $entry) {
    if ($entry === '.' || $entry === '..') continue;

    $fullPath = $target . DIRECTORY_SEPARATOR . $entry;
    $items[] = [
        'name' => $entry,
        'type' => is_dir($fullPath) ? 'folder' : 'file'
    ];
}

header('Content-Type: application/json');
echo json_encode($items);
?>
