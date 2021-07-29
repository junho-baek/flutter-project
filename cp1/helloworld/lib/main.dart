import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Hello world",
        home: Scaffold(
          appBar: AppBar(
            title: Text('😄'),
            backgroundColor: Colors.blue[600],
          ),
          body: Builder(
            builder: (context) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'instagram : @O.Low',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800]),
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          '취미로 배우는 개발 계정',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[400]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.network(
                          'https://www.bloter.net/data/blt/image/2016/08/19/blt201608210006.jpg',
                          height: 350,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ElevatedButton(
                            onPressed: () => contactUs(context), child: Text('contact me!')),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

void contactUs(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Contact me'),
        content: Text('Mail at junho6610@yonsei.ac.kr'),
        actions: [
          TextButton(
            child: Text('Close'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    },
  );
}
