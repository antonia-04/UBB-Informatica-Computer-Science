<?php
// aceeasi lista de legaturi
$trasee = [
    ["Oradea", "Cluj-Napoca"],
    ["Oradea", "Alesd"],
    ["Cluj-Napoca", "Dej"],
    ["Cluj-Napoca", "Satu-Mare"],
    ["Bucuresti", "Timisoara"],
    ["Beius", "Oradea"]
];

// preluam orasul de plecare
$orasPlecare = $_GET["oras"] ?? "";

// construim lista cu orasele de sosire corespunzatoare
$sosiri = [];
foreach ($trasee as $t) {
    if ($t[0] === $orasPlecare) {
        $sosiri[] = $t[1];
    }
}

// returnam ca json
header("Content-Type: application/json");
echo json_encode($sosiri);
?>
