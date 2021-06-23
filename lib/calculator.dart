import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String equation = '0';
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String btnText) {
    setState(() {
      if (btnText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (btnText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = btnText;
        } else {
          equation = equation + btnText;
        }
      }
    });
  }

  Widget calcButton(String btnText, double btnHeight, Color btnColor) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1 * btnHeight,
        color: btnColor,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
              side: BorderSide(
                  color: Colors.white, width: 1.0, style: BorderStyle.solid)),
          onPressed: () => buttonPressed(btnText),
          child: Text(
            btnText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar:
            AppBar(title: Text("Calculator"), backgroundColor: Colors.black),
        body: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                equation,
                style:
                    TextStyle(fontSize: equationFontSize, color: Colors.black),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Text(
                result,
                style: TextStyle(fontSize: resultFontSize, color: Colors.black),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * .75,
                  child: Table(
                    children: [
                      TableRow(children: [
                        calcButton('⌫', 1, Colors.red),
                        calcButton('C', 1, Colors.lightBlue),
                        calcButton('÷', 1, Colors.lightBlue),
                      ]),
                      TableRow(children: [
                        calcButton('7', 1, Colors.black54),
                        calcButton('8', 1, Colors.black54),
                        calcButton('9', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        calcButton('4', 1, Colors.black54),
                        calcButton('5', 1, Colors.black54),
                        calcButton('6', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        calcButton('1', 1, Colors.black54),
                        calcButton('2', 1, Colors.black54),
                        calcButton('3', 1, Colors.black54),
                      ]),
                      TableRow(children: [
                        calcButton('.', 1, Colors.black54),
                        calcButton('0', 1, Colors.black54),
                        calcButton('00', 1, Colors.black54),
                      ]),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Table(
                    children: [
                      TableRow(
                          children: [calcButton('*', 1, Colors.lightBlue)]),
                      TableRow(
                          children: [calcButton('-', 1, Colors.lightBlue)]),
                      TableRow(
                          children: [calcButton('+', 1, Colors.lightBlue)]),
                      TableRow(children: [calcButton('=', 2, Colors.lightBlue)])
                    ],
                  ),
                )
              ],
            )
          ],
        ));
  }
}
