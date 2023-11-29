import 'dart:math';

// const activeLoading = true;
const activeLoading = false;

Future<void> randomLoading() async {
  if (!activeLoading) {
    return;
  }
  var value = Random().nextInt(1000) + 500;
  value = (value * value) % 1757;
  // printme.yellowAccent(value);
  return await Future.delayed(Duration(milliseconds: value));
}
