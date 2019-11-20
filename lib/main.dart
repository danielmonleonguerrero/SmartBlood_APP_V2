import 'package:flutter/material.dart';
import 'package:smartblood/widgets/nuevo_analisis.dart';

import './widgets/calendar.dart';
import './widgets/resumen_analisis.dart';
import './widgets/nuevo_analisis.dart';

import './models/analisis.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartBlood',
      theme: ThemeData(
        primarySwatch: Colors.red,
        accentColor: Colors.amberAccent,
      ),
      home: MyHomePage(title: 'SmartBlood'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime _diaSeleccionado = DateTime.now();
  List<Analisis> analisisClicados = List<Analisis>();
  
  List<Analisis> _userAnalisis = [
    Analisis(
      fecha: DateTime.now().subtract(Duration(days: 1)),
      glucosa: 125,
      nota1: "Despues de comer",
      nota2: "Medicación",
    ),
    Analisis(
      fecha: DateTime.now().subtract(Duration(days: 2)),
      glucosa: 130,
      nota1: "Despues de comer",
      nota2: "Medicación",
    ),
  ];

  List<DateTime> get _diasCalendario {
    List<DateTime> list = List<DateTime>();
    _userAnalisis.forEach((a) {
      list.add(a.fecha);
    });
    return (list);
  }

  List<Analisis> _analisisDia(DateTime dia) {
    return _userAnalisis.where((ua) {
      return (ua.fecha.year == dia.year &&
          ua.fecha.month == dia.month &&
          ua.fecha.day == dia.day);
    }).toList();
  }

  void _diaClicado(DateTime dia) {
    setState(() {
      analisisClicados = _analisisDia(dia); 
    });
    _diaSeleccionado = dia;
  }

  void _nuevoAnalisis(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (bctx) {
          return Container(
            height: 410,
            child: GestureDetector(
              child: NuevoAnalisis(_diaSeleccionado, _registrarAnalisis),
              behavior: HitTestBehavior.opaque,
              onTap:
                  () {}, //we avoid that clicking inside the BottomSheet it causes the Sheet to close.
            ),
          );
        });
  }

  void _registrarAnalisis(
    String nivelglucosa, DateTime dia, String nota1, String nota2) {
    Analisis nuevoAnalisis = new Analisis(
      fecha: dia,
      glucosa: int.parse(nivelglucosa),
      nota1: nota1,
      nota2: nota2,
    );
    setState(() {
      _userAnalisis.add(nuevoAnalisis);
      analisisClicados = _analisisDia(dia);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Blood"),
      ),
      body: Column(children: <Widget>[
        Calendar(_diasCalendario, _diaClicado),
        for (int i = 0; i < analisisClicados.length; i++)
          ResumenAnalisis(analisisClicados[i]),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _nuevoAnalisis(context),
      ),
    );
  }
}
