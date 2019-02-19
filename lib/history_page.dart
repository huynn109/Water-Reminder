import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2018, 12, 10): [
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 1',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );
  CalendarCarousel _calendarCarousel;
  DateTime _currentDate = DateTime(2019, 1, 3);
  DateTime _currentDate2 = DateTime(2019, 1, 3);
  String _currentMonth = '';

  @override
  void initState() {
    /// Add more events to _markedDateMap EventList
    _markedDateMap.add(
        new DateTime(2018, 12, 25),
        new Event(
          date: new DateTime(2018, 12, 25),
          title: 'Event 5',
          icon: _eventIcon,
        ));

    _markedDateMap.add(
        new DateTime(2018, 12, 10),
        new Event(
          date: new DateTime(2018, 12, 10),
          title: 'Event 4',
          icon: _eventIcon,
        ));

    _markedDateMap.addAll(new DateTime(2018, 12, 11), [
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 1',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 2',
        icon: _eventIcon,
      ),
      new Event(
        date: new DateTime(2018, 12, 11),
        title: 'Event 3',
        icon: _eventIcon,
      ),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Example with custom icon
    _calendarCarousel = CalendarCarousel<Event>(
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() => _currentDate = DateTime.now());
        events.forEach((event) => print(event.title));
      },

      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      weekFormat: true,
      markedDatesMap: _markedDateMap,
      height: 420.0,
      selectedDateTime: _currentDate,
      showHeader: false,
      maxSelectedDate: DateTime.now(),

      /// null for not rendering any border, true for circular border, false for rectangular border
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 2,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayBorderColor: Colors.green,
      markedDateMoreShowTotal:
          true, // null for not showing hidden events indicator
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        elevation: 0.0,
        leading: CloseButton(),
      ),
      body: Container(
        color: Colors.white,
        child: CalendarCarousel(
          thisMonthDayBorderColor: Colors.grey,
          height: 420.0,
          selectedDateTime: _currentDate,
          daysHaveCircularBorder: false,

          /// null for not rendering any border, true for circular border, false for rectangular border
          markedDatesMap: _markedDateMap,

          /// for pass null when you do not want to render weekDays
        ),
      ),
    );
  }
}
