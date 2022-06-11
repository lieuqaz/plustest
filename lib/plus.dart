import 'package:logger/logger.dart';
import 'package:plustest/logging.dart';

class Plus {
  List<String> num1 = [];
  List<String> num2 = [];
  String result = '';
  bool remember = false;
  String number1;
  String number2;
  final log = logger;
  Plus({required this.number1, required this.number2});
  plus() {
    String plus = '';

    if (number1.length < number2.length) {
      number2 = [number1, number1 = number2][0];
    }
    log.i('First Number: ${number1}');
    log.i('Second Number: ${number2}');
    num1 = number1.split('');
    num2 = number2.split('');

    int num2length = num2.length;
    int num1length = num1.length;

    for (int x = 0; x < num2length; x++) {
      int plusnumber = int.parse(num2[num2length - 1 - x]) +
          int.parse(num1[num1length - 1 - x]);

      if (remember) {
        plusnumber++;
      }
      log.w(
          "Result of 2 values FirstNumber[${num1length - x - 1}]=${num1[num1length - 1 - x]} and SecondNumber[${num2length - x - 1}]=${num2[num2length - 1 - x]} is $plusnumber");
      if (plusnumber >= 10) {
        if (x == num2length - 1) {
          if (num1length == num2length) {
            plus = plusnumber.toString() + plus;
            log.e("Result[${num1length - x - 1}]=$plusnumber and Remember 1");
          } else {
            plus = (plusnumber % 10).toString() + plus;
            log.e(
                "Result[${num1length - x - 1}]=${plusnumber % 10} and Remember 1");
          }
        } else {
          plus = (plusnumber % 10).toString() + plus;
          log.e(
              "Result[${num1length - x - 1}]=${plusnumber % 10} and Remember 1");
        }

        remember = true;
      } else {
        plus = plusnumber.toString() + plus;
        log.e("Result[${num1length - x - 1}]=$plusnumber");
        remember = false;
      }
    }
    for (int i = 0; i < num1length - num2length; i++) {
      int plusnumber = int.parse(num1[num1length - num2length - i - 1]);
      if (remember) {
        plusnumber++;
      }

      log.w(
          "Result of values FirstNumber[${num1length - num2length - i - 1}]=${num1[num1length - num2length - i - 1]}  is $plusnumber");
      if (plusnumber >= 10) {
        remember = true;
        if (num1length - num2length == 1) {
          plus = plusnumber.toString() + plus;
          log.e(
              "Result[${num1length - num2length - i - 1}]=$plusnumber and Remember 1");
        } else {
          plus = (plusnumber % 10).toString() + plus;
          log.e(
              "Result[${num1length - num2length - i - 1}]=${plusnumber % 10} and Remember 1");
        }
      } else {
        plus = plusnumber.toString() + plus;
        remember = false;
        log.e("Result[${num1length - num2length - i - 1}]=$plusnumber");
      }
    }
    result = plus;
    remember = false;
    log.i("Result: $result");
  }

  String get getResult => result;
}
