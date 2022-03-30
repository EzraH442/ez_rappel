import 'dart:math';

void shuffleList<T>(List<T> wps) {
  Random random = Random();
  // https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle

  for (int i = wps.length - 1; i > 0; i--) {
    int j = random.nextInt(i + 1);
    T tmp = wps[j];
    wps[j] = wps[i];
    wps[i] = tmp;
  }
}
