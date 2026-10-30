import 'dart:io';

void main() {
  while (true) {
    stdout.write('Text: ');
    String text = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Key: ');
    String key = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    if (key.isEmpty || text.isEmpty) {
      print('Invalid Key or Text!\n');
      continue;
    }

    if (mode != 'E' && mode != 'D') {
      print('Invalid Mode!\n');
      continue;
    }

    int cols = key.length;
    int rows = (text.length / cols).ceil();

    List<int> order = List.generate(cols, (i) => i)
      ..sort((a, b) {
        int cmp = key[a].compareTo(key[b]);
        if (cmp != 0) return cmp;
        return a.compareTo(b);
      });

    List<List<String>> grid = List.generate(rows, (_) => List.filled(cols, ''));

    String result = '';

    if (mode == 'E') {
      String padded = text.padRight(rows * cols, 'X');

      for (int i = 0; i < padded.length; i++) {
        grid[i ~/ cols][i % cols] = padded[i];
      }

      for (int c in order) {
        for (int r = 0; r < rows; r++) {
          result += grid[r][c];
        }
      }
    } else {
      int k = 0;

      for (int c in order) {
        for (int r = 0; r < rows; r++) {
          if (k < text.length) {
            grid[r][c] = text[k++];
          }
        }
      }

      for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
          result += grid[r][c];
        }
      }
    }

    print('Result: $result\n');
  }
}