import 'dart:io';

void main() {
  while (true) {
    stdout.write('Text: ');
    String text = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Key: ');
    int? key = int.tryParse(stdin.readLineSync() ?? '');
    if (key == null || key < 2) {
      print('Invalid Key!\n');
      continue;
    }

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    if (mode != 'E' && mode != 'D') {
      print('Invalid Mode!\n');
      continue;
    }

    int rows = key;
    int cols = text.length;

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    String result = '';

    if (mode == 'E') {
      int r = 0;
      int dir = 1;

      for (int i = 0; i < text.length; i++) {
        grid[r][i] = text[i];

        if (r == 0) {
          dir = 1;
        } else if (r == key - 1) {
          dir = -1;
        }

        r += dir;
      }

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          if (grid[i][j].isNotEmpty) {
            result += grid[i][j];
          }
        }
      }
    } else {
      int r = 0;
      int dir = 1;

      for (int i = 0; i < text.length; i++) {
        grid[r][i] = '*';

        if (r == 0) {
          dir = 1;
        } else if (r == key - 1) {
          dir = -1;
        }

        r += dir;
      }

      int k = 0;

      for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
          if (grid[i][j] == '*') {
            grid[i][j] = text[k++];
          }
        }
      }

      r = 0;
      dir = 1;

      for (int i = 0; i < text.length; i++) {
        result += grid[r][i];

        if (r == 0) {
          dir = 1;
        } else if (r == key - 1) {
          dir = -1;
        }

        r += dir;
      }
    }

    print('Result: $result\n');
  }
}