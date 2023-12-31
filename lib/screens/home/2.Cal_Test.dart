import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart'; // 날짜 포매팅을 위해 추가
import '/providers/mainprovider.dart';
bool state = true;
setstatetrue(){
  state = true;
}
setstatefalse(){
  state = false;
}

class TableCalendarScreen extends ConsumerStatefulWidget {
  final List<Schedule> scheduleList;


  TableCalendarScreen({Key? key, required this.scheduleList}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TableCalendarScreenState();
}

class _TableCalendarScreenState extends ConsumerState<TableCalendarScreen> {

  Map<DateTime, List<Event>> events = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  void addEvents() {
    Map<DateTime, List<Event>> updatedEvents = Map.from(events);
    for (int i = 0; i< widget.scheduleList.length; i++) {
      DateTime fullDateTime = DateTime.parse(widget.scheduleList[i].deadLine);
      DateTime deadline = DateTime.utc(fullDateTime.year, fullDateTime.month, fullDateTime.day);
      String description = widget.scheduleList[i].description;
      print(widget.scheduleList[i].deadLine);
      if (!updatedEvents.containsKey(deadline)) {
        updatedEvents[deadline] = [];
      }
      var existingEvent = updatedEvents[deadline]!.firstWhere(
              (event) => event.title == description,
          orElse: () => Event('')
      );

      if (existingEvent.title.isEmpty) {
        updatedEvents[deadline]!.add(Event(description));
      }

    }
    setState(() {
      events = updatedEvents;
    });

    print(events);
  }
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }


  void _showEventsDialog(DateTime day) {
    final eventList = _getEventsForDay(day);
    if (eventList.isEmpty) return;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(DateFormat('MM월dd일 일정').format(day)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          
          children: eventList
              .map((event) => ListTile(title: Text(event.title)))
              .toList(),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('닫기'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override

  Widget build(BuildContext context) {
    addEvents();
    return Container(
      child: TableCalendar(
        locale: 'ko_KR',
        firstDay: DateTime.utc(2001, 1, 1),
        lastDay: DateTime.utc(2099, 12, 31),
        focusedDay: focusedDay,
        selectedDayPredicate: (day) => isSameDay(selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            this.selectedDay = selectedDay;
            this.focusedDay = focusedDay;
          });
          _showEventsDialog(selectedDay);
        },

        eventLoader: _getEventsForDay,
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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


