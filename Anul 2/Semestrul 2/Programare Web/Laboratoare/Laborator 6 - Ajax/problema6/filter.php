<?php
header('Content-Type: application/json');

$produse = [
    ["producator" => "Dell", "procesor" => "Intel i5", "memorie" => "8GB", "hdd" => "256GB", "placa_video" => "Intel UHD"],
    ["producator" => "Dell", "procesor" => "Intel i7", "memorie" => "16GB", "hdd" => "512GB", "placa_video" => "NVIDIA GTX 1650"],
    ["producator" => "HP", "procesor" => "AMD Ryzen 5", "memorie" => "16GB", "hdd" => "1TB", "placa_video" => "NVIDIA RTX 3060"],
    ["producator" => "Lenovo", "procesor" => "Intel i5", "memorie" => "8GB", "hdd" => "512GB", "placa_video" => "Intel UHD"],
    // ... alte produse ...
];

$filtre = [
    'producator' => $_GET['producator'] ?? '',
    'procesor' => $_GET['procesor'] ?? '',
    'memorie' => $_GET['memorie'] ?? '',
    'hdd' => $_GET['hdd'] ?? '',
    'placa_video' => $_GET['placa_video'] ?? '',
];

$rezultat = array_filter($produse, function($produs) use ($filtre) {
    foreach ($filtre as $cheie => $valoare) {
        if ($valoare !== '' && $produs[$cheie] !== $valoare) {
            return false;
        }
    }
    return true;
});

echo json_encode(array_values($rezultat));
