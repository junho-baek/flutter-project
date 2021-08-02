import 'package:flutter/material.dart';
import './pong.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '퐁게임',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: 
          Colors.black87),
          title: Text('심플 퐁 게임'),
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.brown,
        ),
        body: SafeArea(
          child: Pong(),
        ),
      ),
    );
  }
}
