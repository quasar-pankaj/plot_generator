import 'dart:math';

mixin RandomMixin{
  int getRandom(int n) {
    final rng = new Random();
    return rng.nextInt(n);
  }
}