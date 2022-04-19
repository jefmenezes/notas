import 'package:flutter/material.dart';
import 'package:notas/model/data.dart';
import 'package:notas/screens/mainwindow.dart';

const String routeAdd = '/add';
const String routeHome = '/';

class SheetsApp extends StatelessWidget {
  final Data data;

  const SheetsApp({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Notas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: routeHome,
      routes: {
        routeHome: (_) => FutureBuilder(
            future: data.load(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return MainWindow(data: data);
              }
            }),
        routeAdd: (_) => MainWindow(data: data),
      },
    );
  }
}
