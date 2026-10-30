import 'dart:io';

void main() {
  while (true) {
    stdout.write('Enter text: ');
    String text = stdin.readLineSync() ?? '';

    stdout.write('Enter key (word): ');
    String key = (stdin.readLineSync() ?? '').toUpperCase();

    String cleanKey = '';
    for (int i = 0; i < key.length; i++) {
      if (RegExp(r'[A-Za-z]').hasMatch(key[i])) {
        cleanKey += key[i];
      }
    }

    if (cleanKey.isEmpty) {
      print('Invalid key! Must contain letters.\n');
      continue;
    }

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    int sign = (mode == 'D') ? -1 : 1;

    String result = '';
    int keyIndex = 0;

    for (int i = 0; i < text.length; i++) {
      String c = text[i];

      if (c.toUpperCase() == c && RegExp(r'[A-Z]').hasMatch(c)) {
        int shift =
            (cleanKey.codeUnitAt(keyIndex % cleanKey.length) -
                    'A'.codeUnitAt(0)) *
                sign;
        shift = ((shift % 26) + 26) % 26;
        result += String.fromCharCode(
            'A'.codeUnitAt(0) + (c.codeUnitAt(0) - 'A'.codeUnitAt(0) + shift) % 26);
        keyIndex++;
      } else if (c.toLowerCase() == c && RegExp(r'[a-z]').hasMatch(c)) {
        int shift =
            (cleanKey.codeUnitAt(keyIndex % cleanKey.length) -
                    'A'.codeUnitAt(0)) *
                sign;
        shift = ((shift % 26) + 26) % 26;
        result += String.fromCharCode(
            'a'.codeUnitAt(0) + (c.codeUnitAt(0) - 'a'.codeUnitAt(0) + shift) % 26);
        keyIndex++;
      } else {
        result += c;
      }
    }

    print('Result: $result\n');
  }
}