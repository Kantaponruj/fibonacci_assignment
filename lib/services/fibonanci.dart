import 'package:fibonanci_assignment/models/number.dart';
import 'package:flutter/material.dart';

Map<int, int> generateFibonacci(int count) {
  Map<int, int> fib = {0: 0, 1: 1};
  for (int i = 2; i < count; i++) {
    fib[i] = fib[i - 1]! + fib[i - 2]!;
  }
  return fib;
}

FibonacciType getFibonacciType(int number) {
  if (number % 3 == 0) {
    return FibonacciType.circle;
  } else if (number % 3 == 1) {
    return FibonacciType.square;
  } else {
    return FibonacciType.close;
  }
}

String getTypeTitle(FibonacciType type) {
  switch (type) {
    case FibonacciType.circle:
      return 'Type: Multiple of 5 Number';
    case FibonacciType.close:
      return 'Type: Even Number';
    case FibonacciType.square:
      return 'Type: Odd Number';
  }
}

Icon getFibonacciIcon(int number) {
  switch (getFibonacciType(number)) {
    case FibonacciType.circle:
      return const Icon(Icons.circle);
    case FibonacciType.close:
      return const Icon(Icons.close_rounded);
    case FibonacciType.square:
      return const Icon(Icons.square_outlined);
  }
}
