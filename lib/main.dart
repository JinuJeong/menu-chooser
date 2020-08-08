import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MenuPlate menuPlate = MenuPlate();

    return MaterialApp(
        title: 'Flutter Demo',
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
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHome());
  }
}

class MyHome extends StatelessWidget {
  MenuPlate menuPlate = new MenuPlate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text("Add Menu"),
                    ),
                    body: Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(labelText: "Enter Menu"),
                        )),
                  );
                }));
              })
        ],
      ),
      body: menuPlate,
    );
  }
}

class MenuPlate extends StatefulWidget {
  @override
  _MenuPlateState createState() => _MenuPlateState();
}

class _MenuPlateState extends State<MenuPlate> {
  List<Menu> _menuList;

  _MenuPlateState() {
    this._menuList = new List<Menu>();
  }

  bool animate = false;

  void addMenu(Menu menu) {
    setState(() {
      _menuList.add(menu);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      _createMenuPlate(_menuList),
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
        new charts.ArcLabelDecorator(
          insideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 30,
            color: charts.Color.white,
          ),
        )
      ]),
    );
  }

  static List<charts.Series<Menu, int>> _createMenuPlate(List<Menu> menuList) {
    if (menuList.length == 0) {
      menuList.add(new Menu(""));
    }

    return [
      new charts.Series<Menu, int>(
          id: 'MenuList',
          domainFn: (Menu menu, _) => menu.hashCode,
          measureFn: (Menu menu, _) => menu.value,
          data: menuList,
          labelAccessorFn: (Menu menu, _) => '${menu.name}'),
    ];
  }
}

class Menu {
  String name;
  int value = 100;

  Menu(this.name);
}

class SimplePieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimplePieChart(this.seriesList, {this.animate});

  factory SimplePieChart.withSampleData() {
    return new SimplePieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
        new charts.ArcLabelDecorator(
          insideLabelStyleSpec: new charts.TextStyleSpec(
            fontSize: 30,
            color: charts.Color.white,
          ),
        )
      ]),
    );
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 100),
      new LinearSales(2, 100),
      new LinearSales(3, 100),
    ];

    return [
      new charts.Series<LinearSales, int>(
          id: 'Sales',
          domainFn: (LinearSales sales, _) => sales.year,
          measureFn: (LinearSales sales, _) => sales.sales,
          data: data,
          labelAccessorFn: (LinearSales sales, _) => '${sales.year}'),
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
