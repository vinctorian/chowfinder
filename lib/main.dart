import 'package:chowfinder/core/injector.dart';
import 'package:chowfinder/presentation/pages/restaurant_list_page.dart';
import 'package:flutter/material.dart';

void main() {
  Injector.instance.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
      ),
      themeMode: ThemeMode.system,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double radius = 100;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Find restaurants",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            Text("set radius"),
            Slider(
              max: 1000,
              min: 0,
              divisions: 100,
              value: radius,
              label: "$radius metre",
              onChanged: (value) {
                setState(() {
                  radius = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RestaurantListPage(radius: radius),
                  ),
                );
              },
              child: Text("search"),
            ),
          ],
        ),
      ),
    );
  }
}
