import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:measuares_converter/converter.dart';

void main() {
  runApp(const MeasuresConverterApp());
}

class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(title: 'Measures Converter'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<String> measures = [
    "meters",
    "kilometers",
    "miles",
  ];

  String convertedMeasureFrom = "meters";
  String convertedMeasureTo = "meters";
  double valueInput = 0;
  String result = "Result";

  @override
  Widget build(BuildContext context) {
    double sizeX = MediaQuery.of(context).size.width;
    double sizeY = MediaQuery.of(context).size.height;
    final TextStyle inputStyle = TextStyle(
      fontSize: 18,
      color: Colors.blue[900]
    );
    final TextStyle lableStyle = TextStyle(
        fontSize: 18,
        color: Colors.grey[900]
    );
    final spacer = Padding(padding: EdgeInsets.only(top: 10));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        width: sizeX,
        padding: EdgeInsets.all(sizeX/20),
        child: SingleChildScrollView(
          child: Column(
          children: [
            Text("Value", style: lableStyle),
            spacer,
            TextField(
              style: inputStyle,
              decoration: InputDecoration(
                  hintText: "Please insert the measure to be convert",
              ),
              onChanged: (text) => setState(() {
                    valueInput = double.parse(text);
              }),
            ),
            spacer,
            Text("From", style: lableStyle),
            spacer,
            DropdownButton(
              style: inputStyle,
              value: convertedMeasureFrom,
                items: measures.map((String _value) => DropdownMenuItem<String>(
                        value: _value,
                        child: Text(_value),
                    )
                ).toList(),
              onChanged: (String? value) => onConvertMeasuresFromChanged(value!)
            ),
            spacer,
            Text("To", style: lableStyle),
            spacer,
            DropdownButton(
                style: inputStyle,
                value: convertedMeasureTo,
                items: measures.map((String _value) => DropdownMenuItem<String>(
                  value: _value,
                  child: Text(_value),
                )
                ).toList(),
                onChanged: (String? value) => onConvertMeasuresToChanged(value!)
            ),
            spacer,
            ElevatedButton(
                onPressed: () => convert(),
                child: Text("Convert")
            ),
            spacer,
            Text(result, style: lableStyle,)
        ],),)
      )
    );
  }

  void onConvertMeasuresFromChanged(String value){
    setState((){
      convertedMeasureFrom = value;
    });
  }

  void onConvertMeasuresToChanged(String value){
    setState((){
      convertedMeasureTo = value;
    });
  }

  void convert(){
    Converter converter = Converter();
     setState(() {
          result = "Result: " + converter.convert(valueInput,convertedMeasureFrom,convertedMeasureTo);
     });
    FocusScope.of(context).unfocus();
  }
}

