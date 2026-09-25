import 'dart:io';

final List<String> validMoves = ['rock', 'paper', 'scissors'];

/// Asks for a player's name and will use default if nothing is entered.
String getPlayerName(int number) {
  stdout.write('Enter Player $number name: ');
  String? input = stdin.readLineSync()?.trim();
  if (input == null || input.isEmpty) {
    print('(No name entered. Using "Player $number".)');
    return 'Player $number';
  }
  return input;
}

/// Returns the move in lowercase if valid, otherwise null.
String? validateMove(String? input) {
  String move = input?.trim().toLowerCase() ?? '';
  return validMoves.contains(move) ? move : null;
}

/// Keeps asking a player for a move until a valid one is inputted.
String getMove(String name) {
  String? move;
  do {
    stdout.write('$name, enter your move (rock/paper/scissors): ');
    move = validateMove(stdin.readLineSync());
    if (move == null) print('Invalid move. Please type rock, paper, or scissors.');
  } while (move == null);
  return move;
}

/// Compares two moves. Returns 1 if the first wins, 2 if the second wins, 0 for a draw.
int decideWinner(String first, String second) {
  if (first == second) return 0;
  switch (first) {
    case 'rock':
      return second == 'scissors' ? 1 : 2;
    case 'paper':
      return second == 'rock' ? 1 : 2;
    default:
      return second == 'paper' ? 1 : 2;
  }
}

void main() {
  print('===== ROCK, PAPER, SCISSORS =====');
  String playerOne = getPlayerName(1);
  String playerTwo = getPlayerName(2);
  int playerOneScore = 0;
  int playerTwoScore = 0;
  int round = 0;
  String? again;

  do {
    round++;
    print('\n--- Round $round ---');

    // Get Player 1's move, then hide it before Player 2 plays.
    String moveOne = getMove(playerOne);
    for (int i = 0; i < 30; i++) {
      print('');
    }
    String moveTwo = getMove(playerTwo);

    // Work out the round result and update the score.
    int result = decideWinner(moveOne, moveTwo);
    String? winner;
    if (result == 1) {
      winner = '$playerOne wins the round!';
      playerOneScore++;
    } else if (result == 2) {
      winner = '$playerTwo wins the round!';
      playerTwoScore++;
    }

    print('$playerOne chose $moveOne. $playerTwo chose $moveTwo.');
    print('Result: ${winner ?? "It's a draw!"}');
    print('Score -> $playerOne: $playerOneScore | $playerTwo: $playerTwoScore');

    stdout.write('Play again? (y/n): ');
    again = stdin.readLineSync();
  } while (again?.trim().toLowerCase() != 'n');

  // Decide the overall winner based on final scores.
  String overall;
  if (playerOneScore > playerTwoScore) {
    overall = playerOne;
  } else if (playerTwoScore > playerOneScore) {
    overall = playerTwo;
  } else {
    overall = "It's a draw!";
  }

  print('\n===== FINAL SCORE =====');
  print('$playerOne: $playerOneScore | $playerTwo: $playerTwoScore');
  print('Overall winner: $overall');
}