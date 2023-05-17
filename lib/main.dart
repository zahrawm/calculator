import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyCalculator(
      title: "calculator",
    ),
  );
}

class MyCalculator extends StatefulWidget {
  final String title;
  const MyCalculator({super.key, required this.title});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

String? operator;

class _MyCalculatorState extends State<MyCalculator> {
  TextEditingController valueOneController = TextEditingController();
  TextEditingController valueTwoController = TextEditingController();

  double? result;
  String? error;

  calculate() {
    if (valueOneController.text.isEmpty || valueTwoController.text.isEmpty) {
      print("Enter  both values");
      error = "Enter both values";
      setState(() {});
      return;
    }
    print("Calculate method");
    double valueOne = double.parse(valueOneController.text);
    double valueTwo = double.parse(valueTwoController.text);

    switch (operator) {
      case "+":
        error = "";
        result = valueOne + valueTwo;
        break;
      case "-":
        error = "";
        result = valueOne - valueTwo;
        break;
      case "*":
        error = "";
        result = valueOne * valueTwo;
        break;
      case "/":
        error = "";
        result = valueOne / valueTwo;
        break;
      default:
        error = "Please select one operator";
        print("Invalid result");
    }
    setState(() {
      print(result);
    });
  }

  @override
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            TextField(
              onChanged: (value) {
                setState(() {});
              },
              controller: valueOneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Value 1", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: valueTwoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: "Enter Value 2", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 20),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["+", "-", "*", "/"]
                    .map(
                      (e) => OperatorButton(
                          value: e,
                          onTap: () {
                            setState(() {});
                          }),
                    )
                    .toList()),
            const SizedBox(height: 20),
            InkWell(
              onTap: () {
                calculate();
              },
              child: Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: valueOneController.text.isEmpty ||
                          valueTwoController.text.isEmpty
                      ? Colors.grey
                      : Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            if (result != null)
              Text(
                result.toString(),
                style: const TextStyle(fontSize: 25),
              ),
            if (error != null)
              Text(
                error.toString(),
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 25,
                ),
              ),
          ]),
        ),
      ),
    );
  }
}

class OperatorButton extends StatelessWidget {
  final String value;
  final Function() onTap;
  const OperatorButton({Key? key, required this.value, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        operator = "+";
        onTap;
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            color: operator == value ? Colors.grey : Colors.blue,
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  const CustomTextField({Key? key, required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
