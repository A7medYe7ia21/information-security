import 'dart:io';

void main() {
  while (true) {
    stdout.write('Matrix Size (2 or 3): ');
    int? size = int.tryParse(stdin.readLineSync() ?? '');
    if (size == null || (size != 2 && size != 3)) {
      print('Invalid Size!\n');
      continue;
    }

    List<List<int>> key = List.generate(size, (_) => List.filled(size, 0));

    print('Enter Key Matrix:');

    bool validKey = true;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        stdout.write('Key[$i,$j]: ');
        int? val = int.tryParse(stdin.readLineSync() ?? '');
        if (val == null) {
          print('Invalid Key!\n');
          validKey = false;
          break;
        }
        key[i][j] = val;
      }
      if (!validKey) break;
    }
    if (!validKey) continue;

    stdout.write('Text: ');
    String text = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    if (mode != 'E' && mode != 'D') {
      print('Invalid Mode!\n');
      continue;
    }

    String clean = '';
    for (int i = 0; i < text.length; i++) {
      int code = text.codeUnitAt(i);
      if (code >= 'A'.codeUnitAt(0) && code <= 'Z'.codeUnitAt(0)) {
        clean += text[i];
      }
    }

    while (clean.length % size != 0) {
      clean += 'X';
    }

    List<List<int>> matrix = List.generate(size, (_) => List.filled(size, 0));

    if (mode == 'E') {
      for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
          matrix[i][j] = key[i][j];
        }
      }
    } else {
      int det;

      if (size == 2) {
        det = key[0][0] * key[1][1] - key[0][1] * key[1][0];
      } else {
        det = key[0][0] * (key[1][1] * key[2][2] - key[1][2] * key[2][1]) -
            key[0][1] * (key[1][0] * key[2][2] - key[1][2] * key[2][0]) +
            key[0][2] * (key[1][0] * key[2][1] - key[1][1] * key[2][0]);
      }

      det = ((det % 26) + 26) % 26;

      int detInv = -1;
      for (int i = 1; i < 26; i++) {
        if ((det * i) % 26 == 1) {
          detInv = i;
          break;
        }
      }

      if (detInv == -1) {
        print('Invalid Key Matrix!\n');
        continue;
      }

      if (size == 2) {
        matrix[0][0] = key[1][1];
        matrix[0][1] = -key[0][1];
        matrix[1][0] = -key[1][0];
        matrix[1][1] = key[0][0];

        for (int i = 0; i < 2; i++) {
          for (int j = 0; j < 2; j++) {
            matrix[i][j] = ((matrix[i][j] * detInv % 26) + 26) % 26;
          }
        }
      } else {
        for (int r = 0; r < 3; r++) {
          for (int c = 0; c < 3; c++) {
            int r1 = (r + 1) % 3;
            int r2 = (r + 2) % 3;
            int c1 = (c + 1) % 3;
            int c2 = (c + 2) % 3;

            int cofactor = key[c1][r1] * key[c2][r2] - key[c1][r2] * key[c2][r1];

            matrix[r][c] = ((detInv * cofactor % 26) + 26) % 26;
          }
        }
      }
    }

    String result = '';

    for (int i = 0; i < clean.length; i += size) {
      for (int r = 0; r < size; r++) {
        int sum = 0;

        for (int c = 0; c < size; c++) {
          sum += matrix[r][c] * (clean.codeUnitAt(i + c) - 'A'.codeUnitAt(0));
        }

        int value = ((sum % 26) + 26) % 26;

        result += String.fromCharCode('A'.codeUnitAt(0) + value);
      }
    }

    print('Result: $result\n');
  }
}