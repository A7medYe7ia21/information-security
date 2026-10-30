import 'dart:io';

void main() {
  const String abc = 'ABCDEFGHIKLMNOPQRSTUVWXYZ';

  while (true) {
    stdout.write('Key: ');
    String key = (stdin.readLineSync() ?? '').toUpperCase().replaceAll('J', 'I');

    stdout.write('Text: ');
    String text = (stdin.readLineSync() ?? '').toUpperCase().replaceAll('J', 'I');

    stdout.write('Encrypt (E) or Decrypt (D)? ');
    String mode = (stdin.readLineSync() ?? 'E').toUpperCase();

    if (mode != 'E' && mode != 'D') {
      print('Invalid Mode!\n');
      continue;
    }

    String m = '';

    for (int i = 0; i < (key + abc).length; i++) {
      String c = (key + abc)[i];
      if (abc.contains(c) && !m.contains(c)) {
        m += c;
      }
    }

    String t = '';

    for (int i = 0; i < text.length; i++) {
      if (abc.contains(text[i])) {
        t += text[i];
      }
    }

    String result = '';

    if (mode == 'E') {
      for (int i = 0; i < t.length; i++) {
        String a = t[i];

        String b = (i + 1 < t.length && t[i + 1] != a)
            ? t[++i]
            : 'X';

        int p1 = m.indexOf(a);
        int p2 = m.indexOf(b);

        int r1 = p1 ~/ 5, c1 = p1 % 5;
        int r2 = p2 ~/ 5, c2 = p2 % 5;

        if (r1 == r2) {
          result += m[r1 * 5 + (c1 + 1) % 5];
          result += m[r2 * 5 + (c2 + 1) % 5];
        } else if (c1 == c2) {
          result += m[((r1 + 1) % 5) * 5 + c1];
          result += m[((r2 + 1) % 5) * 5 + c2];
        } else {
          result += m[r1 * 5 + c2];
          result += m[r2 * 5 + c1];
        }
      }
    } else {
      if (t.length % 2 != 0) {
        print('Invalid Text! Ciphertext must have even length.\n');
        continue;
      }

      for (int i = 0; i < t.length; i += 2) {
        String a = t[i];
        String b = t[i + 1];

        int p1 = m.indexOf(a);
        int p2 = m.indexOf(b);

        int r1 = p1 ~/ 5, c1 = p1 % 5;
        int r2 = p2 ~/ 5, c2 = p2 % 5;

        if (r1 == r2) {
          result += m[r1 * 5 + (c1 + 4) % 5];
          result += m[r2 * 5 + (c2 + 4) % 5];
        } else if (c1 == c2) {
          result += m[((r1 + 4) % 5) * 5 + c1];
          result += m[((r2 + 4) % 5) * 5 + c2];
        } else {
          result += m[r1 * 5 + c2];
          result += m[r2 * 5 + c1];
        }
      }
    }

    print('Result: $result\n');
  }
}