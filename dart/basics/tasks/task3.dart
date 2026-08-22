import 'dart:math';

void main() {
  // String primeString = isPrime(9) ? "prime" : "not prime";
  // print(primeString);

  // String middleString = getStringMiddle("Ahmed1");
  // print(middleString);

  // double circleArea = getCircleArea(5);
  // print(circleArea);

  // int countOfWords = getCountOfWords("Ahmed Ali Ahmed Ali");
  // print(countOfWords);

  // String evenAndOdd = getEvenAndOddInList([1, 2, 3, 4, 5]);
  // print(evenAndOdd);

  // int count = countOfDigits(2323);
  // print(count);

  List<int> reversedList = reverseList([1, 2, 3]);
  print(reversedList);
}

List<int> reverseList(List<int> list) {
  List<int> reversedList = [];

  for (int i = list.length - 1; i >= 0; i--) {
    reversedList.add(list[i]);
  }

  return reversedList;
}

int countOfDigits(int number) {
  // 123 => 12 => 1 => 0
  int count = 0;
  while (number > 0) {
    count++;
    // int digit = number % 10;
    number = number ~/ 10;
  }
  return count;
}

String getEvenAndOddInList(List<int> list) {
  int evenCount = 0;
  int oddCount = 0;

  for (int i = 0; i < list.length; i++) {
    if (list[i] % 2 == 0) {
      evenCount++;
    } else {
      oddCount++;
    }
  }
  return "Even: $evenCount, Odd: $oddCount";
}

int getCountOfWords(String str) {
  // Ahmed Ali Ahmed Ali
  List<String> words = str.split(" ");
  return words.length;
}

double getCircleArea(int radius) {
  return pi * radius * radius;
}

String getStringMiddle(String str) {
  int strLength = str.length;
  if (strLength % 2 == 0) {
    return str.substring(strLength ~/ 2 - 1, strLength ~/ 2 + 1);
  } else {
    return str.substring(strLength ~/ 2, strLength ~/ 2 + 1);
  }
}

bool isPrime(int number) {
  // 7 (3.5)
  if (number <= 1) {
    return false;
  }
  for (int i = 2; i <= number / 2; i++) {
    if (number % i == 0) {
      return false;
    }
  }
  return true;
}

// Ahmed
// Mohamed7
// 5
