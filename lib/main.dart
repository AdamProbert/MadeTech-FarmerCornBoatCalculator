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

final rhinoCostPerTrip = 0.25;
final rhinoPerTrip = 1;

final title = 'Ferrynuff';

final currencyFormatter = new NumberFormat("£#,##0.00", "en_GB");

int intOrStringValue(dynamic o) {
  if (o is String) o = int.tryParse(o);
  return o ?? 0;
}

bool tooManyGeese(num gooseCount, num cornCount, num rhinoCount) {
  return (gooseCount > 2 && (cornCount > 0 || rhinoCount > 0)) || (gooseCount == 2 && (cornCount == 2 || rhinoCount == 2));
}

bool tooMuchCorn(num cornCount, num gooseCount) {
  return (cornCount > 2 && gooseCount > 0) || (gooseCount == 2 && cornCount == 2);
}

bool tooManyRhino(num rhinoCount, num gooseCount) {
  return (rhinoCount > 2 && gooseCount > 0) || (gooseCount == 2 && rhinoCount == 2);
}

bool validPassengers(num cornCount, num gooseCount, num rhinoCount) {
  if ((gooseCount > 0 && cornCount > 0 && rhinoCount > 0) && (cornCount > 1 || gooseCount > 1 || rhinoCount > 1)) {
    return false;
  }

  return !tooManyGeese(gooseCount, cornCount, rhinoCount) && !tooMuchCorn(cornCount, gooseCount) && !tooManyRhino(rhinoCount, gooseCount);
}

num calculateGooseCost(num gooseCount) {
  num gooseTrips = (gooseCount / goosePerTrip).ceil();
  return ((gooseTrips * gooseCostPerTrip) + (gooseTrips * returnCost));
}

num calculateCornCost(num cornCount) {
  num cornTrips = (cornCount / cornPerTrip).ceil();
  return ((cornTrips * cornCostPerTrip) + (cornTrips * returnCost));
}

num calculateRhinoCost(num rhinoCount) {
  num rhinoTrips = (rhinoCount / rhinoPerTrip).ceil();
  return ((rhinoTrips * rhinoCostPerTrip) + (rhinoTrips * returnCost));
}

num calculateCostSimple(gooseCount, cornCount, rhinoCount) {
  return calculateGooseCost(gooseCount) + calculateCornCost(cornCount) + calculateRhinoCost(rhinoCount);
}

Image getIcon(String step) {
  if (step.contains("corn")) {
    return Image.asset("assets/images/grain.png");
  }
  else if (step.contains("goose")) {
    return Image.asset("assets/images/goose.png");
  }
  else if (step.contains("rhino")) {
    return Image.asset("assets/images/rhino.png");
  }
  else if(step.contains("nothing")){
    return Image.asset(("assets/images/boat.png"));
  }
  return null;
}

enum TransferItem {
  Nothing,
  Corn,
  Goose,
  Rhino,
  Farmer
}

String transferItemToString(TransferItem itemType) {
  switch(itemType) {
    case TransferItem.Nothing: return 'Nothing';
    case TransferItem.Corn: return 'Corn';
    case TransferItem.Goose: return 'Goose';
    case TransferItem.Rhino: return 'Rhino';
    case TransferItem.Farmer: return 'Farmer';
    default: return 'Unknown';
  }
}

Image transferItemToIcon(TransferItem itemType) {
  switch(itemType) {
    case TransferItem.Nothing: return Image.asset(("assets/images/boat.png"));
    case TransferItem.Corn: return Image.asset("assets/images/grain.png");
    case TransferItem.Goose: return Image.asset("assets/images/goose.png");
    case TransferItem.Rhino: return Image.asset("assets/images/rhino.png");
    case TransferItem.Farmer: return Image.asset("assets/images/farmer.png");
    default: return Image.asset(("assets/images/boat.png"));
  }
}

String scheduleEntryToString(TransferItem itemType, num index) {
  if (itemType == TransferItem.Farmer) {
    return 'Return from Market';
  }

  String prefix = '';
  if((index % 2) > 0) {
    prefix = 'Return with ';
  }
  else {
    prefix = 'Take ';
  }
  return prefix + transferItemToString(itemType);
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
  final rhinoCountTextController = TextEditingController();

  num _cost = 0.0;
  List<TransferItem> _steps = [];

  void _updateTransportInformation() {
    setState(() {});
    _steps = [];

    int cornCount = intOrStringValue(cornCountTextController.text);
    int gooseCount = intOrStringValue(gooseCountTextController.text);
    int rhinoCount = intOrStringValue(rhinoCountTextController.text);

    if (!validPassengers(cornCount, gooseCount, rhinoCount)) {
      this._showErrorMessage(cornCount, gooseCount, rhinoCount);
      return;
    }

    this._cost = calculateCostSimple(gooseCount, cornCount, rhinoCount);
    _determineTransportSteps(gooseCount, cornCount, rhinoCount);
  }

  void _resetDisplay() {
    _cost = 0;
    _steps = [];
  }

  void _determineTransportSteps(gooseCount, cornCount, rhinoCount) {
    if ((cornCount == 1) & (gooseCount == 1) & (rhinoCount == 0)) {
      _steps = [
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Corn,
        TransferItem.Farmer
      ];
      _cost = 1;
      return;
    } else if ((cornCount == 2) & (gooseCount == 1) & (rhinoCount == 0)) {
      _steps = [
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Corn,
        TransferItem.Goose,
        TransferItem.Corn,
        TransferItem.Nothing,
        TransferItem.Goose,
        TransferItem.Farmer
      ];
      _cost = 2;
      return;
    } else if ((cornCount == 1) & (gooseCount == 2) & (rhinoCount == 0)) {
      _steps = [
        TransferItem.Corn,
        TransferItem.Nothing,
        TransferItem.Goose,
        TransferItem.Corn,
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Corn,
        TransferItem.Farmer
      ];
      _cost = 2;
      return;
    } else if ((cornCount == 0) & (gooseCount == 1) & (rhinoCount == 1)) {
      _steps = [
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Rhino,
        TransferItem.Farmer
      ];
      _cost = 1;
      return;
    } else if ((cornCount == 0) & (gooseCount == 2) & (rhinoCount == 1)) {
      _steps = [
        TransferItem.Rhino,
        TransferItem.Nothing,
        TransferItem.Goose,
        TransferItem.Rhino,
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Rhino,
        TransferItem.Farmer
      ];
      _cost = 2;
      return;
    } else if ((cornCount == 0) & (gooseCount == 1) & (rhinoCount == 2)) {
      _steps = [
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Rhino,
        TransferItem.Goose,
        TransferItem.Rhino,
        TransferItem.Nothing,
        TransferItem.Goose,
        TransferItem.Farmer
      ];
      _cost = 2;
      return;
    } else if ((gooseCount == 1) && (cornCount == 1) && (rhinoCount == 1)) {
      _steps = [
        TransferItem.Goose,
        TransferItem.Nothing,
        TransferItem.Rhino,
        TransferItem.Goose,
        TransferItem.Corn,
        TransferItem.Nothing,
        TransferItem.Rhino,
        TransferItem.Farmer
      ];
      _cost = 2;
    }
  }

  Future<void> _showErrorMessage(num cornCount, num gooseCount, num rhinoCount) async {
    String text = '';
    if ((gooseCount > 0 && cornCount > 0 && rhinoCount > 0) && (cornCount > 1 || gooseCount > 1 || rhinoCount > 1)) {
      text = 'You can only take 1 of each Goose, Cron and Rhino when taken together';
    }
    else if (tooManyGeese(gooseCount, cornCount, rhinoCount)) {
      text = 'You have too many Geese in your party';
    }
    else if (tooMuchCorn(cornCount, gooseCount)) {
      text = 'You have too much Corn in your party';
    }
    else if (tooManyRhino(rhinoCount, gooseCount)) {
      text = 'The angry Rhrino(s) does not like your Geese';
    }
    else {
      text = 'Something has gone wrong';
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Geese in the Corn'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(text)
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
                  width: 20.0,
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
                    onChanged: (String fieldText) {
                      this._resetDisplay();
                    },
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
                    onChanged: (String fieldText) {
                      this._resetDisplay();
                    },
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                new Flexible(
                  child: TextField(
                    controller: rhinoCountTextController,
                    decoration: InputDecoration(
                      // hintText: 'Number of geese',
                      labelText: 'Rhino',
                    ),
                    keyboardType: TextInputType.number,
                    style: Theme.of(context).textTheme.headline5,
                    onChanged: (String fieldText) {
                      this._resetDisplay();
                    },
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
              ],
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
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
                    itemCount: _steps.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Card(
                        color: (index % 2 == 0) ? Color(FarmerColors.orange) : Color(FarmerColors.dark_green),
                        child: ListTile(
                          title: Text((index+1).toString() + ": " + scheduleEntryToString(_steps[index], index), style: TextStyle(color: Colors.white)),
                            leading: SizedBox(
                                height: 30.0,
                                width: 30.0, // fixed width and height
                                child: transferItemToIcon(_steps[index])
                            ),
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
