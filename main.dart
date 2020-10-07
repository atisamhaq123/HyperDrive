import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
        title: 'Hyperdrive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: Colors.red,
            accentColor: Colors.cyan[600],

            // Define the default font family.

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                headline6:
                    TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'))),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  DateTime dateTime;
  Timer _timer;
  String time;
  String seconds;

  AnimationController rotationController;
//
  //Screen
  var arr = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  String _screen;
  int x = 0; //Iterating on this list
  String y; //single number for rotating seconds

//Fonts
  var _fonts = [
    'neu',
    'ind',
    'van',
    'yond',
  ];
  //Font changing variable
  String _font; //font changing variables
  int z = 1; //iteration on font list

  ///Font changed , so these are some positions variables
  double wid = 170, high = 210, fnt = 80;

  ///
  void initState() {
    super.initState();
    dateTime = new DateTime.now();

    _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
//
    rotationController =
        AnimationController(vsync: this, duration: Duration(seconds: 20));
    rotationController.forward();
    //Set screen at start
    _screen = arr[0];
    _font = _fonts[0];
  }

  ///
  void setscreen() {
    if (x == 7) {
      x = 0;
    }
    _screen = arr[x];
    x += 1;
  }

  void setfont() {
    if (z == 4) {
      z = 0;
    }
    _font = _fonts[z];
    if (z == 2) {
      fnt = 97;
    }
    if (z == 3) {
      wid = 110;
      high = 166;
      fnt = 80;
    }
    if (z == 0) {
      wid = 170;
      high = 210;
      fnt = 80;
    }
    if (z == 1) {
      wid = 170;
      high = 210;
      fnt = 80;
    }
    z += 1;

    //////Setting positions of fonts when font changes
  }

//
  void setTime(Timer timer) {
    setState(() {
      dateTime = new DateTime.now();
      time = DateFormat('kk\n     mm').format(dateTime);
      seconds = DateFormat('s').format(dateTime);
      if (int.parse(seconds) > 9) {
        y = seconds[1];
      } else {
        y = seconds;
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      ///////
      Container(
          decoration: new BoxDecoration(
              image: new DecorationImage(
        image: new AssetImage("images/fantasy.jpg"),
        fit: BoxFit.cover,
      ))),

      ///////Screen animations
      Container(
        child: new FlareActor("assets/clock.flr", animation: _screen), //Days
      ),

      //////
      Container(
          child: Row(children: [
        Container(
          width: 30,
          height: 50,
        ),
        Container(
            child: Column(children: [
          Container(
            height: 60,
            width: 2,
          ),
          Container(
            width: 660,
            height: 100,
            child: new FlareActor("assets/circleLoading.flr",
                animation: "rotate"), //animate
          )
        ])),
      ])),

      ///Rotating second
      Container(
          child: Row(children: [
        Container(width: 350, height: 220),
        RotationTransition(
            turns: Tween(begin: 0.0, end: 5.0).animate(rotationController)
              ..addListener(() {
                setState(() {});
              })
              ..addStatusListener((status) {
                if (status == AnimationStatus.completed) {
                  rotationController.repeat();
                } else if (status == AnimationStatus.dismissed) {
                  rotationController.forward();
                }
              }),
            child: Container(
              child: Text(
                "$y",
                style: TextStyle(
                    fontFamily: 'van',
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                    color: Colors.redAccent,
                    shadows: <Shadow>[
                      Shadow(
                        // bottomLeft
                        offset: Offset(-1, -1),
                        blurRadius: 3.0,
                        color: Color(0x3ceaed).withAlpha(200), //Ox3ceaed
                      ),
                      Shadow(
                        // bottomRight
                        offset: Offset(1.5, -0.5),
                        color: Color(0x3ceaed).withAlpha(200),
                      ),
                      Shadow(
                        // topRight
                        offset: Offset(0.5, 0.5),
                        blurRadius: 3.0,
                        color: Color(0x3ceaed).withAlpha(200),
                      ),
                      Shadow(
                        // topLeft
                        offset: Offset(0.5, 1),
                        blurRadius: 3.0,
                        color: Color(0x3ceaed).withAlpha(200),
                      ),
                    ]),
              ),
            )),
      ])),

      ///
      ///Seconds
      Container(
          child: Row(children: [
        Container(width: 333, height: 45),
        Container(
          child: Text(
            "$seconds",
            style: TextStyle(
                fontFamily: 'neu',
                fontSize: 53,
                fontWeight: FontWeight.w200,
                color: Colors.black,
                shadows: <Shadow>[
                  Shadow(
                    // bottomLeft
                    offset: Offset(-1.5, -1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200), //Ox3ceaed
                  ),
                  Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                  Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                  Shadow(
                    // topLeft
                    offset: Offset(1.5, 1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                ]),
          ),
        ),
      ])),

      ///for flag only
      Container(
          child: Column(
        children: [
          Container(
            height: 100,
            width: 10,
          ),
          Container(
            height: 120,
            width: 120,
            child: Row(
              children: [
                Container(
                  height: 140,
                  width: 110,
                )
              ],
            ),
          ),
          Container(
              child: Column(
            children: [
              Container(
                width: 5,
                height: 30,
              ),
              Container(
                width: 140,
                height: 110,
                child: new FlareActor("assets/flag.flr", animation: "glow"),
              )
            ],
          )),
        ],
      )),
////Flag closed

      ///
      ///Location
      Container(
          child: Column(children: [
        Container(width: 230, height: 334),
        Container(
            child: Text(
          "Amsterdam, NZ",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: Colors.black,
              shadows: <Shadow>[
                Shadow(
                  // bottomLeft
                  offset: Offset(-2, -1),
                  blurRadius: 3.0,
                  color: Color(0x3ceaed).withAlpha(200), //Ox3ceaed
                ),
                Shadow(
                  // bottomRight
                  offset: Offset(0.1, -0.6),
                  color: Color(0x3ceaed).withAlpha(200),
                ),
                Shadow(
                  // topRight
                  offset: Offset(0.1, 1),
                  blurRadius: 3.0,
                  color: Color(0x3ceaed).withAlpha(200),
                ),
                Shadow(
                  // topLeft
                  offset: Offset(0.1, 0.1),
                  blurRadius: 3.0,
                  color: Color(0x3ceaed).withAlpha(200),
                ),
              ]),
        ))
      ])),

//////Time Text starting here
      Container(
          child: Row(children: [
        Container(width: wid, height: 710),
        Container(
          width: 80,
          height: high,
        ),
        Container(
            child: Column(children: [
          Container(
            width: 200,
            height: 165,
          ),
          Container(
              child: Text(
            "$time",
            style: TextStyle(
                fontFamily: "$_font",
                fontSize: fnt,
                fontWeight: FontWeight.w300,
                color: Colors.black,
                shadows: <Shadow>[
                  Shadow(
                    // bottomLeft
                    offset: Offset(-1.8, -1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200), //Ox3ceaed
                  ),
                  Shadow(
                    // bottomRight
                    offset: Offset(1.5, -1.5),
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                  Shadow(
                    // topRight
                    offset: Offset(1.5, 1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                  Shadow(
                    // topLeft
                    offset: Offset(1.8, 1.5),
                    blurRadius: 3.0,
                    color: Color(0x3ceaed).withAlpha(200),
                  ),
                ]),
          ))
        ]))
      ])),

      ////Screen Changing Button starting here
      Container(
        child: Column(
          children: [
            Container(
              width: 395,
              height: 244,
            ),
            FloatingActionButton(
                onPressed: () {
                  setscreen();
                },
                foregroundColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                hoverColor: Colors.pinkAccent,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))),
          ],
        ),
      ),
      //
/////fONT changing button
      Container(
          child: Column(children: [
        Container(
          width: 450,
          height: 244,
        ),
        Container(
          child: Row(children: [
            Container(
              width: 480,
              height: 40,
            ),
            Container(
              height: 55,
              width: 56,
              child: FloatingActionButton(
                  onPressed: () {
                    setfont();
                  },
                  foregroundColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  hoverColor: Colors.pinkAccent,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0))),
            )
          ]),
        )
      ])),

//

      ////////
    ]));
  }
}
