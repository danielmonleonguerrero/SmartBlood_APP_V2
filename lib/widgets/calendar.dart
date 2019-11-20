import 'package:flutter/material.dart';
import '../models/analisis.dart';
import 'package:table_calendar/table_calendar.dart';

CalendarController _calendarController;

class Calendar extends StatefulWidget{
  final Function _diaSeleccionado;
  final List<DateTime> _diasCalendario;
  
  Calendar(this._diasCalendario, this._diaSeleccionado);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List> _events = Map<DateTime, List>();

  void createEvents(){
    _events.clear();
    widget._diasCalendario.forEach((d){
      _events.putIfAbsent(d, ()=> [""]);
      print(_events);
    });
  }

  void _onDaySelected(DateTime dia, List events){
    widget._diaSeleccionado(dia);
  }

  @override
  void initState(){
    super.initState();
    _calendarController = CalendarController();
    createEvents();
  }

  @override
  Widget build(BuildContext context) {
    createEvents();
    return Card(
      elevation: 2,
      child: TableCalendar(
        onDaySelected: _onDaySelected,
        events: _events,
        calendarController: _calendarController,
        calendarStyle: CalendarStyle(
          holidayStyle: TextStyle(
            color: Colors.black,
          ),
          weekendStyle: TextStyle(color: Colors.black,),
          outsideWeekendStyle: TextStyle(color: Colors.grey,),
          selectedColor: Theme.of(context).primaryColor,
          todayStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          todayColor: null,
          
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekendStyle: TextStyle(color: Colors.black54,),
        ),
        startingDayOfWeek: StartingDayOfWeek.monday,
        availableCalendarFormats: const {
          CalendarFormat.month: "Month",
        },
      )
    );
  }
}