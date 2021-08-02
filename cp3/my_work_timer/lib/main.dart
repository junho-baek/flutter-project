import 'package:flutter/material.dart';
import 'widget.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';

import './timer.dart';

// ignore: unused_import
import 'timermodel.dart';

import 'setting.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My Work Timer',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          primaryColor: Colors.black
        ),
        home: TimerHomePage());
  }
}

class TimerHomePage extends StatelessWidget {
  final double defaultPadding = 5.0;
  final CountDownTimer timer = CountDownTimer();

  void emptyMethod() {}
  @override
  Widget build(BuildContext context) {
    final List<PopupMenuItem<String>> menuItems = [];
    menuItems.add(PopupMenuItem(
      child: Text('설정'),
      value: 'Setting',
    ));
    timer.startWork();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          '✨깔끔한 타이머✨',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.menu_rounded,
              // color: Colors.black,
            ),
            itemBuilder: (BuildContext context) {
              return menuItems.toList();
            },
            onSelected: (s) {
              if (s == 'Setting') {
                goToSetting(context);
              }
            },
          )
        ],
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final double? availableWidth = constraints.maxWidth;
        return Column(
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff8BC34A),
                    text: "일",
                    onPressed: () => timer.startWork(),
                  ),
                ),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xffBDBDBD),
                    text: "짧은 휴식",
                    onPressed: () => timer.startBreak(true),
                  ),
                ),
                Padding(padding: EdgeInsets.all(defaultPadding)),
                Expanded(
                  child: ProductivityButton(
                    color: Color(0xff757575),
                    text: "긴 휴식",
                    onPressed: () => timer.startBreak(false),
                  ),
                ),
                Padding(padding: EdgeInsets.all(defaultPadding)),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                  initialData: '00:00',
                  stream: timer.stream(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    TimerModel timer = (snapshot.data == '00:00')
                        ? TimerModel('00:00', 1)
                        : snapshot.data;
                    return CircularPercentIndicator(
                      radius: availableWidth! / 2,
                      lineWidth: 10.0,
                      percent: timer.percent,
                      center: Text(
                        timer.time,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      progressColor: Color(0xff009688),
                    );
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff212121),
                      text: '일시 정지',
                      onPressed: () => timer.stopTimer(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                  Expanded(
                    child: ProductivityButton(
                      color: Color(0xff8BC34A),
                      text: '재시작',
                      onPressed: () => timer.startTimer(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(defaultPadding),
                  ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  void goToSetting(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingScreen(),
      ),
    );
  }
}
