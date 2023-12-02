
  import 'package:flutter/material.dart';
  import 'package:table_calendar/table_calendar.dart';

  class TableCalendarScreen extends StatefulWidget {
  const TableCalendarScreen({Key? key}) : super(key: key);
  @override
  State<TableCalendarScreen> createState() => _TableCalendarScreenState();
  }

  class _TableCalendarScreenState extends State<TableCalendarScreen> {
  Map<DateTime, List<Event>> events = {
  DateTime.utc(2023, 11, 24): [Event('lol'), Event('snas')],
  DateTime.utc(2023, 11, 25): [Event('fxxk')],
  };

  List<Event> _getEventsForDay(DateTime day) {
  return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
  return Container(
    child: TableCalendar(
    locale: 'ko_KR',
    firstDay: DateTime.utc(2001, 1, 1),
    lastDay: DateTime.utc(2099, 12, 31),
    focusedDay: DateTime.now(),
    eventLoader: _getEventsForDay,
    headerStyle: HeaderStyle(
    formatButtonVisible: false,
    titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // 제목 스타일 변경
    ),
    daysOfWeekStyle: DaysOfWeekStyle(
      weekdayStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      weekendStyle: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
    ),
    calendarFormat: CalendarFormat.week,
    calendarStyle: CalendarStyle(
    markerSize: 10.0,
    markerDecoration: BoxDecoration(
    color: Color(0xff473CCE),
    shape: BoxShape.circle,
    ),
    defaultTextStyle: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),
    weekendTextStyle: TextStyle(color: Colors.blueAccent, fontSize: 13, fontWeight: FontWeight.bold),
    ),
    calendarBuilders: CalendarBuilders(
    defaultBuilder: (context, day, focusedDay) {
    if (day.weekday == DateTime.sunday) {
      return Center(
        child: Text(
      '${day.day}',
      style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
    } else if (day.weekday == DateTime.saturday) {
      return Center(
        child: Text(
      '${day.day}',
      style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.bold),
    ),
    );
  }
  return null;
  },
  dowBuilder: (context, day) {
  if (day.weekday == DateTime.sunday) {
      return Center(
        child: Text(
      '일',
  style: TextStyle(color: Colors.red, fontSize: 14, fontWeight: FontWeight.bold),
    ),
    );
    } else if (day.weekday == DateTime.saturday) {
      return Center(
        child: Text(
  '토',
  style: TextStyle(color: Colors.blueAccent, fontSize: 14, fontWeight: FontWeight.bold),
  ),
  );
  }
  return null;
  },
  ),
  ),
  );
  }
  }

  class Event {
  final String title;

  Event(this.title);
  }