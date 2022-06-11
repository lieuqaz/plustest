import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plustest/form_field_widget.dart';
import 'package:plustest/logging.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  List<String> num1 = [];
  List<String> num2 = [];
  String result = '';
  bool remember = false;
  final log = logger;
  void plus() {
    String plus = '';

    if (number1.text.length < number2.text.length) {
      number2 = [number1, number1 = number2][0];
    }
    log.i('First Number: ${number1.text}');
    log.i('Second Number: ${number2.text}');
    num1 = number1.text.split('');
    num2 = number2.text.split('');

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

    setState(() {
      result = plus;
    });
    log.i("Result: $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Plus two big number"),
      ),
      body: Center(
        child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FormFieldWidget(
                  controller: number1,
                ),
                const SizedBox(
                    width: 220,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.add))),
                FormFieldWidget(
                  controller: number2,
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  width: 200,
                  child: Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: 180,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Result:'),
                        Text(
                          result,
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const SizedBox(
                      width: 100, child: Center(child: Text('PLUS'))),
                  onPressed: () {
                    plus();
                    setState(() {
                      remember = false;
                    });
                  },
                )
              ],
            )),
      ),
    );
  }
}
