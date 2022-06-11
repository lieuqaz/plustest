import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:plustest/form_field_widget.dart';
import 'package:plustest/logging.dart';
import 'package:plustest/plus.dart';

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
  String result = '';
  final log = logger;
  void plus() {
    if (globalKey.currentState!.validate()) {
      var plus = Plus(number1: number1.text, number2: number2.text);
      plus.plus();
      setState(() {
        result = plus.getResult;
      });
    }
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
                  },
                )
              ],
            )),
      ),
    );
  }
}
