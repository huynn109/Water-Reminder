import 'package:flutter/material.dart';
import 'package:flutter_app_list/account_page.dart';
import 'package:flutter_app_list/box.dart';
import 'package:flutter_app_list/history_page.dart';
import 'package:flutter_app_list/water_effect.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ListPageState();
  }
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  double waterSize = 100.0;
  double allWaterSize = 2300.0;
  double percent = .0;

  WaterPage waterPage;

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
      elevation: 0.toDouble(),
      title: Text('Water Reminder'),
      centerTitle: true,
      backgroundColor: Colors.white,
    );

    final bottomNavigation = BottomAppBar(
      notchMargin: 4.0,
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.calendar_today,
              ),
              onPressed: () {
                _gotoHistory();
              }),
          IconButton(
              icon: Icon(
                Icons.account_circle,
              ),
              onPressed: () {
                _gotoAccount();
              }),
        ],
      ),
    );

    final makeListTile = ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(width: 1.0, color: Colors.white24))),
          child: Icon(Icons.autorenew, color: Colors.white),
        ),
        title: Text(
          "Introduction to Driving",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        subtitle: Row(
          children: <Widget>[
            Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(" Intermediate", style: TextStyle(color: Colors.white))
          ],
        ),
        trailing:
            Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0));

    final makeCard = Card(
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, 0.9)),
        child: makeListTile,
      ),
    );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return makeCard;
        },
      ),
    );

    AnimationController animationController;

    @override
    void initState() {
      super.initState();
      animationController = new AnimationController(
        duration: const Duration(seconds: 12),
        vsync: this,
      )..reverse(from: 0.4);
      waterPage = new WaterPage(
//        percent: percent,
          );
    }

    @override
    void dispose() {
      animationController.dispose();
      super.dispose();
    }

    return Scaffold(
      appBar: topAppBar,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        icon: const Icon(Icons.local_drink),
        label: const Text('Drink'),
        backgroundColor: Colors.pinkAccent,
        onPressed: _incrementCounterWater,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: bottomNavigation,
      body: WaterPage(
          weight: waterSize,
          percent: (waterSize / allWaterSize * 100).roundToDouble(),
          height: waterSize *
              (MediaQuery.of(context).size.height - 175) /
              allWaterSize,
          appbarHeight: topAppBar.preferredSize.height),
    );
  }

  void _incrementCounterWater() {
    if (waterSize < allWaterSize) {
      setState(() {
        waterSize += 100;
      });
    }
  }

  void _gotoHistory() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => HistoryPage()));
  }

  void _gotoAccount() {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => AccountPage()));
  }
}

class GlassPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color(0xFFc7d0df)
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(0.0, 6.0), Offset(size.width * 0.15, size.height - 6.0), paint);
    canvas.drawLine(Offset(0.0, 6.0), Offset(size.width, 6.0), paint);
    canvas.drawLine(Offset(size.width, 6.0),
        Offset(size.width * 0.85, size.height - 6.0), paint);

    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 1.0;

    canvas.drawRect(
        Rect.fromLTWH(
            size.width * 0.13, size.height - 21.0, size.width * 0.74, 21.0),
        paint);
  }

  @override
  bool shouldRepaint(GlassPainter other) {
    return true;
  }
}
