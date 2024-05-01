import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CALCULATOR',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';  

  void onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
         
        expression = '';
      } else if (value == '=') {
         
        try {
          final evalResult = _evaluateExpression(expression);
          expression = evalResult.toString();
        } catch (e) {
        
          expression = 'Error';
        }
      } else if (value == 'X') {
         
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else {
     
        expression += value;
      }
    });
  }

  double _evaluateExpression(String expr) {
     
    final parser = Parser();
    final context = ContextModel();

 
    final expression = parser.parse(expr);
    return expression.evaluate(EvaluationType.REAL, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CALCULATOR', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
        
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              color: Color.fromARGB(255, 76, 90, 97),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    expression,
                    style: TextStyle(fontSize: 50.0, color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
          ),
           
          Container(
            color: Colors.black,
            padding: EdgeInsets.all(25.0),  
            child: Column(
              children: [
                
                buildRow(['7', '8', '9', '/']),
                SizedBox(height: 10),  
                buildRow(['4', '5', '6', '*']),
                SizedBox(height: 10),  
                buildRow(['1', '2', '3', '-']),
                SizedBox(height: 10),  
                buildRow(['.', '0', '#', '+']),
                SizedBox(height: 20),  
                
                 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: buildButton('C', Colors.red, Colors.white)),
                    
                    Expanded(
                      flex: 1,
                      child: buildButton('X', Colors.orangeAccent, Colors.white)),
                    Expanded(
                      flex: 1,
                      child: buildButton('=', Colors.green, Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

 
  Widget buildRow(List<String> labels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: labels.map((label) {
        return Expanded(
          child: buildButton(label, _getButtonColor(label), _getButtonTextColor(label)),
        );
      }).toList(),
    );
  }

  
  Widget buildButton(String label, Color buttonColor, Color textColor) {
    return ElevatedButton(
      onPressed: () => onButtonPressed(label),
      child: Text(label, style: TextStyle(fontSize: 28, color: textColor)),
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: EdgeInsets.all(15),
      ),
    );
  }

  
  Color _getButtonColor(String label) {
    switch (label) {
      case 'C':
        return Colors.red;
      case '=':
        return Colors.green;
      case 'X':
        return Colors.orangeAccent;
      case '+':
      case '-':
      case '*':
      case '/':
        return Colors.orangeAccent;
      case '':
        return Colors.black;
      default:
        return Colors.blueGrey;
    }
  }
 
  Color _getButtonTextColor(String label) {
    return Colors.white;
  }
}
