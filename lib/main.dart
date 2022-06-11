import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  void validate() {
    String plus = '';
    if (globalKey.currentState!.validate()) {
      if (number1.text.length < number2.text.length) {
        number2 = [number1, number1 = number2][0];
      }

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
        if (plusnumber >= 10) {
          if (x == num2length - 1) {
            if (num1length == num2length) {
              plus = plusnumber.toString() + plus;
            } else {
              plus = (plusnumber % 10).toString() + plus;
            }
          } else {
            plus = (plusnumber % 10).toString() + plus;
          }
          remember = true;
        } else {
          plus = plusnumber.toString() + plus;
          remember = false;
        }
      }
      for (int i = 0; i < num1length - num2length; i++) {
        int plusnumber = int.parse(num1[num1length - num2length - i - 1]);
        if (remember) {
          plusnumber++;
        }
        if (plusnumber >= 10) {
          remember = true;
          if (num1length - num2length == 1) {
            plus = plusnumber.toString() + plus;
          } else {
            plus = (plusnumber % 10).toString() + plus;
          }
        } else {
          plus = plusnumber.toString() + plus;
          remember = false;
        }
      }
    }
    setState(() {
      result = plus;
    });
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
                    validate();
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

class FormFieldWidget extends StatelessWidget {
  const FormFieldWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: TextFormField(
        validator: (val) => val!.isNotEmpty ? null : "Enter number",
        keyboardType: TextInputType.number,
        controller: controller,
        textAlign: TextAlign.right,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(),
          ),
        ),
      ),
    );
  }
}
