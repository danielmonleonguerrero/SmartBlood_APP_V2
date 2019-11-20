import 'package:flutter/material.dart';

class NuevoAnalisis extends StatefulWidget {
  final DateTime diaSeleccionado;
  final Function _registrarAnalisis;

  NuevoAnalisis(this.diaSeleccionado, this._registrarAnalisis);

  @override
  _NuevoAnalisisState createState() => _NuevoAnalisisState();
}

class _NuevoAnalisisState extends State<NuevoAnalisis> {
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay timeOfDay =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (timeOfDay != null && timeOfDay != selectedTime)
      setState(() {
        selectedTime = timeOfDay;
      });
  }

  final glucosaController = TextEditingController();
  @override
  void dispose() {
    //clean up the controller when the widget is disposed
    glucosaController.dispose();
    super.dispose();
  }

  List<String> listNota1 = [
    "Antes de comer",
    "Despues de comer",
  ];
  List<String> listNota2 = [
    "Mucha comida",
    "Poca comida",
    "Ejercicio moderado",
    "Ejercicio intenso",
    "Medicación",
    "Siente hipoglucemia",
    "Menstruación",
  ];
  int posNota1 = 0, posNota2 = 0;

  void onRegistrarAnalisis() {
    DateTime fecha = new DateTime(
        widget.diaSeleccionado.year,
        widget.diaSeleccionado.month,
        widget.diaSeleccionado.day,
        selectedTime.hour,
        selectedTime.minute);

    widget._registrarAnalisis(
      glucosaController.text,
      fecha,
      listNota1[posNota1],
      listNota2[posNota2],
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 15,
            ),
            child: TextField(
              controller: glucosaController,
              decoration: new InputDecoration(
                  labelText: "Nivel glucosa (mg/dl):",
                  labelStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18)),
              keyboardType: TextInputType.number,
              maxLength: 3,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
              Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Fecha",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 10),
                ),
                Text(""),
                Text(
                  "Hora ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 10),
                ),
                Text(""),
                Text(
                  "Nota 1 ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(""),
                Text("Nota 2 ",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                Text(
                  "",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.diaSeleccionado.day.toString() +
                      "/" +
                      widget.diaSeleccionado.month.toString() +
                      "/" +
                      widget.diaSeleccionado.year.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 10),
                ),
                Text(""),
                InkWell(
                  child: Text(
                    selectedTime.format(context),
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => _selectTime(context),
                ),
                Text(
                  "",
                  style: TextStyle(fontSize: 10),
                ),
                Text(""),
                InkWell(
                  child: Text(
                    listNota1[posNota1],
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => {
                    setState(() {
                      posNota1++;
                      if (posNota1 == listNota1.length) posNota1 = 0;
                    })
                  },
                ),
                Text(
                  "(" +
                      (posNota1 + 1).toString() +
                      "/" +
                      listNota1.length.toString() +
                      ")",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
                Text(""),
                InkWell(
                  child: Text(
                    listNota2[posNota2],
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () => {
                    setState(() {
                      posNota2++;
                      if (posNota2 == listNota2.length) posNota2 = 0;
                    })
                  },
                ),
                Text(
                  "(" +
                      (posNota2 + 1).toString() +
                      "/" +
                      listNota2.length.toString() +
                      ")",
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                )
              ],
            ),
          ]),
          Text(""),
          FlatButton(
            child: Text(
              "Añadir nuevo análisis",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () => onRegistrarAnalisis(),
          ),
          Text(""),
        ],
      ),
    );
  }
}
