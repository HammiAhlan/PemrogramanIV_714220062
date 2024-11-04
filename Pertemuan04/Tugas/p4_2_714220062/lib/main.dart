import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tugas Pertemuan 4',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 100,
                color: Colors.blue,
                child: Center(
                  child: Text(
                    'Box 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 200,
                    color: Colors.red,
                    child: Center(
                    child: Text(
                      'Box 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ),
                  SizedBox(width: 20),
                  Container(
                    width: 100,
                    height: 200,
                    color: Colors.green,
                    child: Center(
                    child: Text(
                      'Box 2',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  ),
                ],
              ) // SizedBox berada di luar Container
            ],
          ),
        ),
      ),
    );
  }
}