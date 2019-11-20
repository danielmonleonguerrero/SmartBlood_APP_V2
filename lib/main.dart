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
        accentColor: Colors.deepOrangeAccent,
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
  DateTime _diaSeleccionado = DateTime.now(); //DateTime of the current day selected
  List<Analisis> analisisDelDia = List<Analisis>(); //List of analisis that happened on a specific day

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

  //used to get the dates with data for the marks in the calendar
  List<DateTime> get _diasMarcados {
    List<DateTime> list = List<DateTime>();
    _userAnalisis.forEach((a) {
      list.add(a.fecha);
    });
    return (list);
  }

  //Used to get all the Analisis happened on a specific day
  List<Analisis> _getAnalisisdelDia(DateTime dia) {
    return _userAnalisis.where((ua) {
      return (ua.fecha.year == dia.year &&
          ua.fecha.month == dia.month &&
          ua.fecha.day == dia.day);
    }).toList();
  }

  //Updates analisisDia due to a change of the selected day
  void _diaClicado(DateTime dia) {
    setState(() {
      analisisDelDia = _getAnalisisdelDia(dia);
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

  //When there is a new Analisis, this method is the responsable of updating the data
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
      analisisDelDia = _getAnalisisdelDia(dia);
    });
  }

  void _borrarAnalisis(Analisis analisisBorrado){
    setState(() {
      for(int i=0; i<_userAnalisis.length; i++){
        if(analisisBorrado==_userAnalisis[i]){
          _userAnalisis.removeAt(i);
          analisisDelDia = _getAnalisisdelDia(_diaSeleccionado);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Blood"),
      ),
      body: Column(children: <Widget>[
        Calendar(_diasMarcados, _diaClicado),
        for (int i = 0; i < analisisDelDia.length; i++)
          ResumenAnalisis(analisisDelDia[i], _borrarAnalisis),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _nuevoAnalisis(context),
      ),
    );
  }
}
