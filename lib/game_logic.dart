import 'dart:math';

class Player{
  static const x='X';
  static const o='0';
  static const empty='';
  static List<int>playerX=[];
  static List<int>playerO=[];

}

class Game{
  void playgame(int index, String player) {
    if (player=='X'){
      Player.playerX.add(index);
    }
    else{
      Player.playerO.add(index);
    }
  }
  CheckWinner(){
    String winner='';
    if((Player.playerX.contains(0) && Player.playerX.contains(1) && Player.playerX.contains(2)) ||
        (Player.playerX.contains(3) && Player.playerX.contains(4) && Player.playerX.contains(5)) ||
        (Player.playerX.contains(6) && Player.playerX.contains(7) && Player.playerX.contains(8)) ||
        (Player.playerX.contains(0) && Player.playerX.contains(4) && Player.playerX.contains(8)) ||
        (Player.playerX.contains(2) && Player.playerX.contains(4) && Player.playerX.contains(6)) ||
        (Player.playerX.contains(0) && Player.playerX.contains(3) && Player.playerX.contains(6)) ||
        (Player.playerX.contains(1) && Player.playerX.contains(4) && Player.playerX.contains(7)) ||
        (Player.playerX.contains(2) && Player.playerX.contains(5) && Player.playerX.contains(8))
    )
    {
      winner='X';
    }

    else if((Player.playerO.contains(0) && Player.playerO.contains(1) && Player.playerO.contains(2)) ||
        (Player.playerO.contains(3) && Player.playerO.contains(4) && Player.playerO.contains(5)) ||
        (Player.playerO.contains(6) && Player.playerO.contains(7) && Player.playerO.contains(8)) ||
        (Player.playerO.contains(0) && Player.playerO.contains(4) && Player.playerO.contains(8)) ||
        (Player.playerO.contains(2) && Player.playerO.contains(4) && Player.playerO.contains(6)) ||
        (Player.playerO.contains(0) && Player.playerO.contains(3) && Player.playerO.contains(6)) ||
        (Player.playerO.contains(1) && Player.playerO.contains(4) && Player.playerO.contains(7)) ||
        (Player.playerO.contains(2) && Player.playerO.contains(5) && Player.playerO.contains(8))
    ){
      winner='O';
    }
    else{
      winner='';
    }


    return winner;
  }



  Future<void> autoplay(player) async {
    int index = -1; // Initialize with an invalid index
    List<int> emptyCells = [];

    for (var i = 0; i < 9; i++) {
      if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }

    if (emptyCells.isEmpty) {
      return; // No empty cells left, game over
    }

    // If it's the first move, choose a random cell
    if (emptyCells.length == 9) {
      Random random = Random();
      index = random.nextInt(emptyCells.length);
    } else {
      // Otherwise, use the minimax algorithm to select the best move
      int bestScore = -9999;
      for (var i = 0; i < emptyCells.length; i++) {
        int cellIndex = emptyCells[i];
        Player.playerO.add(cellIndex); // Assume "O" takes this move
        int score = minimax(Player.playerX, Player.playerO, false);
        Player.playerO.remove(cellIndex); // Undo the move

        if (score > bestScore) {
          bestScore = score;
          index = cellIndex;
        }
      }
    }

    playgame(index, player);
  }

  int minimax(List<int> playerX, List<int> playerO, bool isMaximizing) {
    if (checkWinner(Player.playerX)) {
      return -1; // Player X wins
    } else if (checkWinner(Player.playerO)) {
      return 1; // Player O wins
    } else if (isBoardFull()) {
      return 0; // It's a draw
    }

    int bestScore;
    if (isMaximizing) {
      bestScore = -9999;
      for (var i = 0; i < 9; i++) {
        if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
          Player.playerO.add(i); // Assume "O" takes this move
          int score = minimax(playerX, playerO, false);
          Player.playerO.remove(i); // Undo the move
          bestScore = max(score, bestScore);
        }
      }
    } else {
      bestScore = 9999;
      for (var i = 0; i < 9; i++) {
        if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
          Player.playerX.add(i); // Assume "X" takes this move
          int score = minimax(playerX, playerO, true);
          Player.playerX.remove(i); // Undo the move
          bestScore = min(score, bestScore);
        }
      }
    }

    return bestScore;
  }

  bool checkWinner(List<int> playerMoves) {
    // Check all winning combinations
    List<List<int>> winningCombinations = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6] // Diagonals
    ];

    for (var combination in winningCombinations) {
      if (playerMoves.contains(combination[0]) &&
          playerMoves.contains(combination[1]) &&
          playerMoves.contains(combination[2])) {
        return true; // Found a winning combination
      }
    }

    return false; // No winning combination found
  }

  bool isBoardFull() {
    return Player.playerX.length + Player.playerO.length >= 9;
  }


// Future<void> autoplay(player)async {
//       int index=0;
//       List<int> empty_Cells=[];
//       for(var i=0;i<9;i++) {
//         if (!(Player.playerX.contains(i) || Player.playerO.contains(i))) {
//           empty_Cells.add(i);
//         }
//       }
//         Random random=Random();
//         int randomindex= random.nextInt(empty_Cells.length);
//         index = empty_Cells[randomindex];
//         playgame(index, player);
//
//     }

}