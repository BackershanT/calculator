import 'package:calculator/src/widget/button_screen.dart';
import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String num1 = "";
 String num2 = "";
 String operand = "";
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SafeArea(
        bottom: false,
        child: Scaffold(
          body: Column(
            children: [
              //result+
              Expanded(
                  child: SingleChildScrollView(
                reverse: true,
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(17),
                  child: Text(
                    "$num1$operand$num2".isEmpty ? "0" : "$num1$operand$num2",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    textAlign: TextAlign.end,
                  ),
                ),
              )),

              //buttons

              Wrap(
                children: Btn.buttonValues
                    .map((value) => SizedBox(
                          width: value == Btn.n0
                              ? screenSize.width / 2
                              : (screenSize.width / 4),
                          height: screenSize.width / 5,
                          child: buildButton(value),
                        ))
                    .toList(),
              )
            ],
          ),
        ));
  }

  Widget buildButton(value) {
    return Padding(
        padding: EdgeInsets.all(5),
        child: Material(
            color: [Btn.del, Btn.clr].contains(value)
                ? Colors.grey
                : [
                    Btn.per,
                    Btn.multiply,
                    Btn.add,
                    Btn.subtract,
                    Btn.divide,
                    Btn.calculate
                  ].contains(value)
                    ? Colors.orange
                    : Colors.black26,
            clipBehavior: Clip.hardEdge,
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
              borderRadius: BorderRadius.circular(100),
            ),
            child: InkWell(
              onTap: () => onBtnTap(value),
              child: Center(
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
            )));
  }

  void onBtnTap( Value) {
    if (Value == Btn.del) {
      delete();
      return;
    }
    if (Value == Btn.clr) {
      clearAll();
      return;
    }
    if (Value == Btn.per){
      convertToPercentage();
      return;
    }
    if (Value == Btn.calculate) {
      // calculate();
      return;
    }
    appendValue(Value);

    setState(() {});
  }
void convertToPercentage(){
    if(num1.isNotEmpty &&operand.isNotEmpty && num2.isNotEmpty){

    }
    if(operand.isNotEmpty){
      return;
    }
    final number =double.parse( num1) ;
    setState(() {
      num1 ="${(number  / 100 )}";
      operand="";
      num2="";

    });
}
  // void calculate() {
  //   if (num1.isEmpty) return;
  //   if (operand.isEmpty) return;
  //   if (num2.isEmpty) return;
  //
  //   final double num1 = double.parse(num1 ) ;
  //   final double num2 = double.parse(num2 ) ;
  //
  //    var result =0.0;
  //    switch (operand){
  //      case Btn.add: result = (num1 +  num2)  ;
  //        break;
  //        case Btn.subtract: result = (num1 - num2) as double ;
  //        break;
  //        case Btn.multiply: result = (num1 * num2 ) as double ;
  //        break;
  //        case Btn.divide: result = (num1 / num2) as double;
  //        break;
  //      default:
  //
  //    }
  //    // setState(() {
  //    //   num1 = "$result" as double;
  //    // //    if (num1.endsWith(".0")){
  //    // //      num1 =num1.substring(0,num1.length-2);
  //    // //      operand = "";
  //    // //      num2 =" ";
  //    // //
  //    //    }
  //    // });
  //
  // }
  void clearAll() {
    setState(() {
      num1 = "";
      operand = "";
      num2 = "";
    });
  }

  void delete() {
    if (num2.isNotEmpty) {
      num2 = num2.substring(0, num2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = " ";
    } else if (num1.isNotEmpty) {
      num1 = num1.substring(0, num1.length - 1);
    }
    setState(() {});
  }

  void appendValue( Value) {
    if (Value != Btn.dot && int.tryParse(Value) == null) {
      if (operand.isNotEmpty && num2.isNotEmpty) {
        // calculate();
      }
      operand = Value;
    } else if (num1.isEmpty || operand.isEmpty) {
      if (Value == Btn.dot && num1.contains(Btn.dot)) return;
      if (Value == Btn.dot && (num1.isEmpty || num1 == Btn.dot)) {
        Value = "0.";
      }
      num1 += Value;
    } else if (num2.isEmpty || operand.isNotEmpty) {
      if (Value == Btn.dot && num2.contains(Btn.dot)) return;
      if (Value == Btn.dot && (num2.isEmpty || num2 == Btn.dot)) {
        Value = "0.";
      }
      num2 += Value;
    }
  }
}
