import 'dart:io';

void main() {
  while (true) {
    stdout.write('Enter text: ');
    String text = stdin.readLineSync() ?? '';

    stdout.write('Enter key: ');
    int? key = int.tryParse(stdin.readLineSync() ?? '');
    if (key == null) {
      print('Invalid key!\n');
      continue;
    }

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    int shift = (mode == 'D') ? -key : key;
    shift = ((shift % 26) + 26) % 26;

    String result = '';

    for (int i = 0; i < text.length; i++) {
      String c = text[i];
      if (c.toUpperCase() == c && c.contains(RegExp(r'[A-Z]'))) {
        result += String.fromCharCode(
            ((c.codeUnitAt(0) - 'A'.codeUnitAt(0) + shift) % 26 + 26) % 26 +
                'A'.codeUnitAt(0));
      } else if (c.toLowerCase() == c && c.contains(RegExp(r'[a-z]'))) {
        result += String.fromCharCode(
            ((c.codeUnitAt(0) - 'a'.codeUnitAt(0) + shift) % 26 + 26) % 26 +
                'a'.codeUnitAt(0));
      } else {
        result += c;
      }
    }

    print('Result: $result\n');
  }
}