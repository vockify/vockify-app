import 'dart:math';

String plural(int count, List<String> words) {
  var cases = [2, 0, 1, 1, 1, 2];
  return words[(count % 100 > 4 && count % 100 < 20) ? 2 : cases[min(count % 10, 5)]];
}
