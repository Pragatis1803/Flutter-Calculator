// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_application_2/prefs/style.dart';
import 'package:flutter_application_2/prefs/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme:
          ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String output = "0";

  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool switchValue = false;
  ThemeProvider themeProvider = ThemeProvider();

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "X") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "";
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        // ignore: avoid_print
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "X") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      _output = _output + buttonText;
    }
    // ignore: avoid_print
    print(output);

    setState(() {
      output = double.parse(_output).toStringAsFixed(2);
    });
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlineButton(
        // ignore: prefer_const_constructors
        child: Text(
          buttonText,
          // ignore: prefer_const_constructors
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        // ignore: prefer_const_constructors
        padding: EdgeInsets.all(24.0),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.preference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: Style.themeData(themeProvider.darkTheme),
              home: Scaffold(
                appBar: AppBar(
                  title: Text(widget.title),
                ),
                body: Column(
                  children: <Widget>[
                    // ignore: prefer_const_constructors
                    Switch(
                      value: switchValue,
                      onChanged: (val) {
                        themeProvider.darkTheme = !themeProvider.darkTheme;
                        setState(() {
                          switchValue = val;
                        });
                      },
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 12.0,
                      ),
                      // ignore: prefer_const_constructors
                      child: Text(
                        output,
                        // ignore: prefer_const_constructors
                        style: TextStyle(
                            fontSize: 48.0, fontWeight: FontWeight.bold),
                      ),
                    ),

                    // ignore: prefer_const_constructors
                    Expanded(
                        // ignore: prefer_const_constructors
                        child: Divider()),

                    Column(
                      children: [
                        Row(
                          children: [
                            buildButton("7"),
                            buildButton("8"),
                            buildButton("9"),
                            buildButton("/"),
                          ],
                        ),
                        Row(
                          children: [
                            buildButton("4"),
                            buildButton("5"),
                            buildButton("6"),
                            buildButton("X"),
                          ],
                        ),
                        Row(
                          children: [
                            buildButton("1"),
                            buildButton("2"),
                            buildButton("3"),
                            buildButton("-"),
                          ],
                        ),
                        Row(
                          children: [
                            buildButton("."),
                            buildButton("0"),
                            buildButton("00"),
                            buildButton("+"),
                          ],
                        ),
                        Row(
                          children: [
                            buildButton("CLEAR"),
                            buildButton("="),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
