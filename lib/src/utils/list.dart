import 'dart:math';

extension ListExtension<T> on List<T> {

  T randomItem(Random random) {
    return this[random.nextInt(length)];
  }

}