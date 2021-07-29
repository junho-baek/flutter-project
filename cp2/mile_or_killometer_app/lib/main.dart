import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7,
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };
  var _convertedMeasure;
  var _startMeasure;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds(lbs)',
    'ounces'
  ];
  void initState() {
    _numberFrom = 0.0;
    super.initState();
  }

  void convert(value, from, to) {
    int? nFrom = _measuresMap[from];
    int? nTo = _measuresMap[to];
    var multipiler = _formulas[nFrom.toString()][nTo];
    var result = value * multipiler;
    if (result == 0) {
      _resultMessage = 'This conversion cannot be performed';
    } else {
      _resultMessage =
          '${_numberFrom.toString()}$_startMeasure'+ ' 는 \n${result.toString()}$_convertedMeasure 입니다';
    }
    print(nTo);
    print(nFrom);
    print(_resultMessage);

    setState(() {
      _resultMessage = _resultMessage;
    });
  }

  var _resultMessage;

  var _numberFrom;






  Widget build(BuildContext context) {
    final TextStyle inputStyle =
        TextStyle(fontSize: 20, color: Colors.blue[900]);

    final TextStyle labelStyle =
        TextStyle(fontSize: 24, color: Colors.grey[700]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Measures Converter',
      home: Scaffold(
        backgroundColor: Colors.blue[100],
        appBar: AppBar(
          title: Text("단위 변환기🧭",
              style:
                  TextStyle(color: Colors.black, fontStyle: FontStyle.italic)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 700),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      'Value',
                      style: labelStyle,
                    ),
                    Spacer(),
                    TextField(
                      style: inputStyle,
                      decoration: InputDecoration(hintText: "변환할 측정값을 입력하세요!"),
                      onChanged: (text) {
                        var rv = double.tryParse(text);
                        print(rv);
                        if (rv != null) {
                          setState(() {
                            _numberFrom = rv;
                          });
                        }
                      },
                    ),
                    Spacer(),
                    Text(
                      'From',
                      style: labelStyle,
                    ),
                    Spacer(),
                    DropdownButton(
                      isExpanded: true,
                      value: _startMeasure,
                      items: _measures.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: inputStyle,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _startMeasure = value;
                        });
                      },
                    ),
                    Spacer(),
                    Text(
                      'To',
                      style: labelStyle,
                    ),
                    Spacer(),
                    DropdownButton(
                      isExpanded: true,
                      value: _convertedMeasure,
                      items: _measures.map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                            style: inputStyle,
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _convertedMeasure = value;
                        });
                      },
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                        if(_convertedMeasure.isEmpty||_startMeasure.isEmpty||_numberFrom == 0.0 ){
                          return;
                        }else{
                          convert(_numberFrom, _startMeasure, _convertedMeasure);
                        }
                        print(_numberFrom);
                        print(_resultMessage);
                        
                      },
                      child: Text(
                        'Convert',
                        style: inputStyle,
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text(
                       (_resultMessage == null)? '':_resultMessage.toString(),
                      style: labelStyle,
                    ),
                    Spacer(
                      flex: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

