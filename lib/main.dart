import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

final returnCost = 0.25;
final cornCostPerTrip = 0.25;
final cornPerTrip = 1;
final gooseCostPerTrip = 0.25;
final goosePerTrip = 1;

final title = 'Morten Transport Cost Calculator';

final currencyFormatter = new NumberFormat("£#,##0.00", "en_GB");

int intOrStringValue(dynamic o) {
  if (o is String) o = int.tryParse(o);
  return o ?? 0;
}

bool tooManyGeese(num gooseCount, num cornCount) {
  return (gooseCount > 1 && cornCount != 1);
}

bool tooMuchCorn(num cornCount, num gooseCount) {
  return (cornCount > 1 && gooseCount != 1);
}

bool validPassengers(num cornCount, num gooseCount) {
  return !tooManyGeese(gooseCount, cornCount) &&
      !tooMuchCorn(cornCount, gooseCount);
}

num calculateGooseCost(num gooseCount) {
  num gooseTrips = (gooseCount / goosePerTrip).ceil();
  return ((gooseTrips * gooseCostPerTrip) + (gooseTrips * returnCost));
}

num calculateCornCost(num cornCount) {
  num cornTrips = (cornCount / cornPerTrip).ceil();
  return ((cornTrips * cornCostPerTrip) + (cornTrips * returnCost));
}

num calculateCostSimple(gooseCount, cornCount) {
  return calculateGooseCost(gooseCount) + calculateCornCost(cornCount);
}

Image getIcon(String step) {
  if(step.contains("corn")){
    return Image.asset("assets/images/grain.png");
  }
  else if(step.contains("goose")){
    return Image.asset("assets/images/goose.png");
  }
  else if(step.contains("nothing")){
    return Image.asset(("assets/images/boat.png"));
  }
  return null;
}

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

class FarmerColors {
  static const light_green = 0xff82E080;
  static const orange = 0xffe35922;
  static const brown = 0xff755E54;
  static const red = 0xffDB464B;
  static const dark_green = 0xff55A825;
}

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
        primarySwatch: MaterialColor(FarmerColors.orange, color),
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
  final cornCountTextController = TextEditingController();
  final gooseCountTextController = TextEditingController();

  num _cost = 0.0;
  List<String> steps = [];

  void _updateTransportInformation() {
    setState(() {});
    steps = [];

    int cornCount = intOrStringValue(cornCountTextController.text);
    int gooseCount = intOrStringValue(gooseCountTextController.text);

    if (!validPassengers(cornCount, gooseCount)) {
      this._showErrorMessage();
      return;
    }

    this._cost = calculateCostSimple(gooseCount, cornCount);
    _determineTransportSteps(gooseCount, cornCount);
  }

  void _determineTransportSteps(gooseCount, cornCount) {
    if ((cornCount == 1) & (gooseCount == 1)) {
      steps = ["Take goose", "Return with nothing", "Take corn"];
      this._cost = 1;
      return;
    } else if ((cornCount == 2) & (gooseCount == 1)) {
      steps = [
        "Take goose",
        "Return with nothing",
        "Take corn",
        "Return with goose",
        "Take corn",
        "Return with nothing",
        "Take goose"
      ];
      this._cost = 2;
      return;
    } else if ((cornCount == 1) & (gooseCount == 2)) {
      steps = [
        "Take corn",
        "Return with nothing",
        "Take goose",
        "Return with corn",
        "Take goose",
        "Return with nothing",
        "Take corn"
      ];
      this._cost = 2;
      return;
    }
  }

  Future<void> _showErrorMessage() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Geese in the Corn'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You have too many Geese vs Corn'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            AspectRatio(
              aspectRatio: 1000 / 451,
              child: new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.fitWidth,
                      alignment: FractionalOffset.topCenter,
                      image: new AssetImage('assets/images/banner.png')),
                ),
              ),
            ),
            if (this._cost > 0)
              Text(
                'Travel Cost: \n${currencyFormatter.format(this._cost)}',
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                new Flexible(
                  child: TextField(
                    controller: cornCountTextController,
                    decoration: InputDecoration(
                      // hintText: 'Number of corn bags',
                      labelText: 'Corn',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                new Flexible(
                  child: TextField(
                    controller: gooseCountTextController,
                    decoration: InputDecoration(
                      // hintText: 'Number of geese',
                      labelText: 'Geese',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
              ],
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(color: Color(FarmerColors.dark_green))),
              color: Color(FarmerColors.dark_green),
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              onPressed: _updateTransportInformation,
              highlightColor: Color(FarmerColors.light_green),
              child: Text("Calculate".toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
            ),
            Expanded(
                child: new ListView.builder
                  (
                    itemCount: steps.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        color: (index % 2 == 0) ? Color(FarmerColors.orange) : Color(FarmerColors.dark_green),
                        child: ListTile(
                          title: Text((index+1).toString() + ": " + steps[index], style: TextStyle(color: Colors.white)),
                            leading: SizedBox(
                                height: 30.0,
                                width: 30.0, // fixed width and height
                                child: getIcon(steps[index])
                            )
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
