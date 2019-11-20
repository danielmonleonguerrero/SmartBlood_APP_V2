import 'package:flutter/material.dart';

import '../models/analisis.dart';

class ResumenAnalisis extends StatefulWidget{
  final Analisis analisis;
  ResumenAnalisis(this.analisis);

  @override
  _ResumenAnalisisState createState() => _ResumenAnalisisState();
}

class _ResumenAnalisisState extends State<ResumenAnalisis> {

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: 
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.analisis.glucosa.toString() + " mg/dl",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(widget.analisis.fecha.hour.toString() + ":" + widget.analisis.fecha.minute.toString(),
                      style: TextStyle(color: Colors.grey),),
                ],
              ),
            margin: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(widget.analisis.nota1),
                Text(widget.analisis.nota2),
            ],)
          )
        ],
      )
    );
  }
}