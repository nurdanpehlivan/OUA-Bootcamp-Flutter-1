import 'package:flutter/material.dart';

void main() {
  return runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          style: TextStyle(color: Colors.white),
          "Makaleler",
        ),
        backgroundColor: Colors.black,
      ),
      body: page(),
    ),
  ));
}

class page extends StatefulWidget {
  @override
  State<page> createState() => _pageState();
}

class _pageState extends State<page> {
  int leftdicenumber = 1;
  int rightdicenumber = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            print("B1");
                          });
                        },
                        child: const Text(
                            "Flutter ile mobil uygulama gelistirme"))),
                SizedBox(height: 20.0),
                Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            print("B2");
                          });
                        },
                        child: const Text(
                            "Flutter ile mobil uygulama gelistirme"))),
                SizedBox(height: 20.0),
                Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            print("B3");
                          });
                        },
                        child: const Text(
                            "Flutter ile mobil uygulama gelistirme"))),
                SizedBox(height: 20.0),
                Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            print("B4");
                          });
                        },
                        child: const Text(
                            "Flutter ile mobil uygulama gelistirme"))),
                SizedBox(height: 20.0),
                Expanded(
                    child: TextButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.white),
                        ),
                        onPressed: () {
                          setState(() {
                            print("B5");
                          });
                        },
                        child: const Text(
                            "Flutter ile mobil uygulama gelistirme"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
