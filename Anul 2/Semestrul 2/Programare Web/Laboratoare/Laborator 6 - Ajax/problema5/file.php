<?php
$baseDir = realpath(__DIR__);
$path = isset($_GET['path']) ? $_GET['path'] : '';
$target = realpath($baseDir . DIRECTORY_SEPARATOR . $path);

if (strpos($target, $baseDir) !== 0 || !is_file($target)) {
    echo "Fișier invalid.";
    exit;
}

header('Content-Type: text/plain');
echo file_get_contents($target);
?>
