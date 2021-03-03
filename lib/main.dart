import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

final title = 'Martin Transport Cost Calculator';
final currencyFormatter = new NumberFormat("£#,##0.00", "en_GB");

Map<int, Color> color = {
  50: Color.fromRGBO(226, 88, 34, .1),
  100: Color.fromRGBO(226, 88, 34, .2),
  200: Color.fromRGBO(226, 88, 34, .3),
  300: Color.fromRGBO(226, 88, 34, .4),
  400: Color.fromRGBO(226, 88, 34, .5),
  500: Color.fromRGBO(226, 88, 34, .6),
  600: Color.fromRGBO(226, 88, 34, .7),
  700: Color.fromRGBO(226, 88, 34, .8),
  800: Color.fromRGBO(226, 88, 34, .9),
  900: Color.fromRGBO(226, 88, 34, 1),
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(0xffe25822, color),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();

  int _counter = 0;
  num _cost = 0.0;

  void _incrementCounter() {
    setState(() {});
    // This call to setState tells the Flutter framework that something has
    // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
    _counter++;
  }

  void _calculateTransportCost() {
    setState(() {});

    if (myController.text == '') {
      this._cost = 0;
      return;
    }

    this._cost = (int.parse(myController.text) * 0.25) * 2;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image(image: AssetImage('assets/images/Wheat.jpg')),
                )),
            TextField(
              controller: myController,
              decoration: InputDecoration(
                hintText: 'Number of corn bags',
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              // controller: myController,
              decoration: InputDecoration(
                hintText: 'Number of geese',
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Colors.green)),
              color: Colors.green,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              onPressed: _calculateTransportCost,
              child: Text(
                "Calculate".toUpperCase(),
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            if (this._cost > 0)
              Text(
                'Travel Cost: ${currencyFormatter.format(this._cost)}',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
    );
  }
}
