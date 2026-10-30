import 'dart:io';

void main() {
  const String abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  while (true) {
    stdout.write('Text: ');
    String text = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Key: ');
    String key = (stdin.readLineSync() ?? '').toUpperCase();

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    if (key.length != text.length) {
      print('Key must have same length as Text!\n');
      continue;
    }

    if (mode != 'E' && mode != 'D') {
      print('Invalid Mode!\n');
      continue;
    }

    String result = '';

    for (int i = 0; i < text.length; i++) {
      int t = abc.indexOf(text[i]);
      int k = abc.indexOf(key[i]);

      if (t == -1 || k == -1) {
        print('Invalid Text or Key!\n');
        result = '';
        break;
      }

      int x;

      if (mode == 'E') {
        x = (t + k) % 26;
      } else {
        x = (t - k + 26) % 26;
      }

      result += abc[x];
    }

    if (result.isNotEmpty) {
      print('Result: $result\n');
    }
  }
}