<?php
// lista de legaturi reale intre orase din romania
$trasee = [
    ["Oradea", "Cluj-Napoca"],
    ["Oradea", "Alesd"],
    ["Cluj-Napoca", "Dej"],
    ["Cluj-Napoca", "Satu-Mare"],
    ["Bucuresti", "Timisoara"],
    ["Beius", "Oradea"]
];

// extrage orasele de plecare fara duplicate
$plecari = [];
foreach ($trasee as $t) {
    if (!in_array($t[0], $plecari)) {
        $plecari[] = $t[0];
    }
}

// returneaza lista in format json
header("Content-Type: application/json");
echo json_encode($plecari);
?>
