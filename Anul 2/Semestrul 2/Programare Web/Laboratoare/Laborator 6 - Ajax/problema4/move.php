<?php
// move.php - primește board-ul actual și face mutarea calculatorului sau verifică starea jocului
// Request body JSON: { board: [...], playerSymbol, computerSymbol, checkOnly? }

header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);

$board = $data['board'] ?? array_fill(0, 9, '');
$player = $data['playerSymbol'] ?? 'X';
$computer = $data['computerSymbol'] ?? '0';
$checkOnly = $data['checkOnly'] ?? false;

// funcții ajutătoare

function check_winner($board, $sym) {
    $winPatterns = [
        [0,1,2],[3,4,5],[6,7,8], // linii
        [0,3,6],[1,4,7],[2,5,8], // coloane
        [0,4,8],[2,4,6]          // diagonale
    ];
    foreach ($winPatterns as $pattern) {
        if ($board[$pattern[0]] === $sym && $board[$pattern[1]] === $sym && $board[$pattern[2]] === $sym) {
            return true;
        }
    }
    return false;
}

function board_full($board) {
    foreach ($board as $cell) {
        if ($cell === '') return false;
    }
    return true;
}

// Daca cerem doar verificare stare (fara mutare computer)
if ($checkOnly) {
    if (check_winner($board, $player)) {
        echo json_encode(['status'=>'win','winner'=>$player]);
        exit;
    }
    if (check_winner($board, $computer)) {
        echo json_encode(['status'=>'win','winner'=>$computer]);
        exit;
    }
    if (board_full($board)) {
        echo json_encode(['status'=>'draw']);
        exit;
    }
    echo json_encode(['status'=>'continue']);
    exit;
}

// Daca trebuie sa facem mutarea calculatorului
// mutare simpla: prima pozitie libera

for ($i=0; $i<9; $i++) {
    if ($board[$i] === '') {
        $board[$i] = $computer;
        break;
    }
}

// verificam stare dupa mutare
if (check_winner($board, $computer)) {
    echo json_encode(['status'=>'win','winner'=>$computer,'board'=>$board]);
    exit;
}
if (board_full($board)) {
    echo json_encode(['status'=>'draw','board'=>$board]);
    exit;
}

echo json_encode(['status'=>'continue','board'=>$board]);
exit;
?>
