import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'buttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userInput = '';
  String answer = '0';

  final orangeColor = const Color.fromARGB(255, 255, 165, 0);

  void addInput(String value) {
    setState(() {
      userInput += value;
    });
  }

  void clearAll() {
    setState(() {
      userInput = '';
      answer = '0';
    });
  }

  void deleteLast() {
    setState(() {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    });
  }

  void equalPressed() {
    String finalInput = userInput.replaceAll('x', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() => answer = eval.toString());
    } catch (e) {
      setState(() => answer = 'Error');
    }
  }

  Widget buildButtonRow(List<Map<String, dynamic>> buttons) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons
            .map(
              (btn) => MyButton(
                title: btn['title'],
                color: btn['color'] ?? const Color(0xffa5a5a5),
                onPress: btn['onPress'],
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Display Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      userInput,
                      style: const TextStyle(fontSize: 32, color: Colors.white),
                    ),
                    Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Buttons Section
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  buildButtonRow([
                    {'title': 'AC', 'onPress': clearAll},
                    {'title': '+/-', 'onPress': () {}},
                    {'title': '%', 'onPress': () => addInput('%')},
                    {
                      'title': '/',
                      'color': orangeColor,
                      'onPress': () => addInput('/'),
                    },
                  ]),
                  buildButtonRow([
                    {'title': '7', 'onPress': () => addInput('7')},
                    {'title': '8', 'onPress': () => addInput('8')},
                    {'title': '9', 'onPress': () => addInput('9')},
                    {
                      'title': 'x',
                      'color': orangeColor,
                      'onPress': () => addInput('x'),
                    },
                  ]),
                  buildButtonRow([
                    {'title': '4', 'onPress': () => addInput('4')},
                    {'title': '5', 'onPress': () => addInput('5')},
                    {'title': '6', 'onPress': () => addInput('6')},
                    {
                      'title': '-',
                      'color': orangeColor,
                      'onPress': () => addInput('-'),
                    },
                  ]),
                  buildButtonRow([
                    {'title': '1', 'onPress': () => addInput('1')},
                    {'title': '2', 'onPress': () => addInput('2')},
                    {'title': '3', 'onPress': () => addInput('3')},
                    {
                      'title': '+',
                      'color': orangeColor,
                      'onPress': () => addInput('+'),
                    },
                  ]),
                  buildButtonRow([
                    {'title': '0', 'onPress': () => addInput('0')},
                    {'title': 'DEL', 'onPress': deleteLast},
                    {'title': '.', 'onPress': () => addInput('.')},

                    {
                      'title': '=',
                      'color': orangeColor,
                      'onPress': equalPressed,
                    },
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
