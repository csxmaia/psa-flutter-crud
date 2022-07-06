import 'package:flutter/material.dart';
import 'package:psa_flutter_crud/form_tarefa.dart';
import 'package:psa_flutter_crud/lista_tarefa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => ListaTarefa(),
        '/formTarefa': (context) => FormTarefa(),
      }
    );
  }
}
