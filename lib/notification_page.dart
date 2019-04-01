import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:duration/duration.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NotificationPageState();
  }
}

class NotificationPageState extends State<NotificationPage> {
  bool _valueAllowNotifications = false;
  bool _valueAllowSound = false;
  bool _valueStopWhen100 = true;

  String fromTime;
  String toTime;
  Duration initialTimer = new Duration();

  void _onChangedAllowNotifications(bool value) =>
      setState(() => _valueAllowNotifications = value);

  void _onChangedSound(bool value) => setState(() => _valueAllowSound = value);

  void _onChangedStopWhen100(bool value) =>
      setState(() => _valueStopWhen100 = value);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.toDouble(),
        title: Text('Notification'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        child: _buildProfilePage(),
      ),
    );
  }

  _buildProfilePage() {
    return Container(
      child: ListView(
        children: <Widget>[
          new SwitchListTile(
            value: _valueAllowNotifications,
            onChanged: _onChangedAllowNotifications,
            title: new Text(
              'Allow notifications',
            ),
          ),
          new SwitchListTile(
            value: _valueAllowSound,
            onChanged: _onChangedSound,
            title: new Text(
              'Allow sound',
            ),
          ),
          new SwitchListTile(
            value: _valueStopWhen100,
            onChanged: _onChangedStopWhen100,
            title: new Text(
              'Stop when 100%',
            ),
          ),
          Divider(),
          new ListTile(
            title: Text('From time'),
            subtitle: Text(fromTime ?? ''),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              fromTime = DateFormat("h:mm a").format(newDate);
                            });
                          },
                          use24hFormat: false,
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.time,
                        ));
                  });
            },
          ),
          new ListTile(
            title: Text('To time'),
            subtitle: Text(toTime ?? ''),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 3,
                        child: CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              toTime = DateFormat("h:mm a").format(newDate);
                            });
                          },
                          use24hFormat: false,
                          minuteInterval: 1,
                          mode: CupertinoDatePickerMode.time,
                        ));
                  });
            },
          ),
          new ListTile(
            title: Text('Interval'),
            subtitle: Text(printDuration(initialTimer)),
            trailing: Icon(Icons.navigate_next),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext builder) {
                    return Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height / 5,
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hm,
                          minuteInterval: 30,
                          initialTimerDuration: initialTimer,
                          onTimerDurationChanged: (Duration changedTimer) {
                            setState(() {
                              initialTimer = changedTimer;
                            });
                          },
                        ));
                  });
            },
          )
        ],
      ),
    );
  }

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }

  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }
}

class _ChipsTile extends StatelessWidget {
  const _ChipsTile({
    Key key,
    this.label,
    this.children,
  }) : super(key: key);

  final String label;
  final List<Widget> children;

  // Wraps a list of chips into a ListTile for display as a section in the demo.
  @override
  Widget build(BuildContext context) {
    final List<Widget> cardChildren = <Widget>[
      Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 4.0),
        alignment: Alignment.center,
        child: Text(label, textAlign: TextAlign.start),
      ),
    ];
    if (children.isNotEmpty) {
      cardChildren.add(Wrap(
          children: children.map<Widget>((Widget chip) {
        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: chip,
        );
      }).toList()));
    } else {
      final TextStyle textStyle = Theme.of(context)
          .textTheme
          .caption
          .copyWith(fontStyle: FontStyle.italic);
      cardChildren.add(Semantics(
        container: true,
        child: Container(
          alignment: Alignment.center,
          constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
          padding: const EdgeInsets.all(8.0),
          child: Text('None', style: textStyle),
        ),
      ));
    }

    return Card(
      semanticContainer: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: cardChildren,
      ),
    );
  }
}
