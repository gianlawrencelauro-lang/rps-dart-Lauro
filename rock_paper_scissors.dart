import 'dart:io';

const List<String> validMoves = ['rock', 'paper', 'scissors'];

void printBanner() {
  print('===== ROCK, PAPER, SCISSORS =====');
}

String getPlayerName(String prompt, String defaultName) {
  print('Enter $prompt name:');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    print('(No name entered. Using "$defaultName".)');
    return defaultName;
  }

  return input.trim();
}

String? validateMove(String? move) {
  if (move == null) {
    return null;
  }

  String cleanedMove = move.trim().toLowerCase();

  if (validMoves.contains(cleanedMove)) {
    return cleanedMove;
  }

  return null;
}

String getMove(String playerName) {
  String? move;

  while (move == null) {
    print('$playerName, enter your move (rock/paper/scissors): ');
    String? input = stdin.readLineSync();
    move = validateMove(input);

    if (move == null) {
      print('Invalid move. Please type rock, paper, or scissors.');
    }
  }

  return move;
}

void clearScreen() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

String? decideWinner(
  String player1,
  String move1,
  String player2,
  String move2,
) {
  if (move1 == move2) {
    return null;
  }

  switch (move1) {
    case 'rock':
      if (move2 == 'scissors') {
        return player1;
      }
      return player2;

    case 'paper':
      if (move2 == 'rock') {
        return player1;
      }
      return player2;

    case 'scissors':
      if (move2 == 'paper') {
        return player1;
      }
      return player2;

    default:
      return null;
  }
}

void main() {
  printBanner();

  String player1 = getPlayerName('Player 1', 'Player 1');
  String player2 = getPlayerName('Player 2', 'Player 2');

  int player1Score = 0;
  int player2Score = 0;
  int round = 0;
  String playAgain;

  do {
    round++;
    print('--- Round $round ---');

    String move1 = getMove(player1);
    clearScreen();

    String move2 = getMove(player2);

    print('$player1 chose $move1. $player2 chose $move2.');

    String? winner = decideWinner(player1, move1, player2, move2);

    if (winner == null) {
      print("Result: It's a draw!");
    } else {
      print('Result: $winner');
    }

    if (winner == player1) {
      player1Score++;
    } else if (winner == player2) {
      player2Score++;
    }

    print('Score -> $player1: $player1Score | $player2: $player2Score');

    print('Play again? (y/n): ');
    String? input = stdin.readLineSync();
    playAgain = (input ?? 'n').trim().toLowerCase();
  } while (playAgain == 'y');

  print('===== FINAL SCORE =====');
  print('$player1: $player1Score | $player2: $player2Score');

  String overallResult;

  if (player1Score > player2Score) {
    overallResult = player1;
  } else if (player2Score > player1Score) {
    overallResult = player2;
  } else {
    overallResult = "It's a tie!";
  }

  print('Overall winner: $overallResult');
}
