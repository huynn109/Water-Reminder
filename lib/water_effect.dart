import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as Vector;
import 'package:flutter/scheduler.dart' show timeDilation;

class WaterPage extends StatefulWidget {
  final percent;
  final timeDilation = 3.0;
  final appbarHeight;

  @override
  _WaterPageState createState() => new _WaterPageState();

  WaterPage({
    this.percent,
    this.appbarHeight,
  });
}

class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    Size size = new Size(
      MediaQuery.of(context).size.width,
      (MediaQuery.of(context).size.height - 155) * widget.percent,
    );
    print('Height ' + size.height.toString());
    print('Height ' + widget.appbarHeight.toString());
    print('Height ' + MediaQuery.of(context).size.height.toString());
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new WaterEffectBody(
              size: size, xOffset: 0, yOffset: 0, color: Colors.blue),
          Center(
            child: Text(
              '${size.height.round().toString() } ml',
              style: Theme.of(context).textTheme.title,
            ),
          )
//          new Opacity(
//            opacity: 0.9,
//            child: new WaterEffectBody(
//              size: size,
//              xOffset: 100,
//              yOffset: 10,
//            ),
//          ),
        ],
      ),
    );
  }
}

class WaterEffectBody extends StatefulWidget {
  final Size size;
  final int xOffset;
  final int yOffset;
  final Color color;

  WaterEffectBody(
      {Key key, @required this.size, this.xOffset, this.yOffset, this.color})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _WaterEffectState();
  }
}

class _WaterEffectState extends State<WaterEffectBody>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<Offset> animList1 = [];

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));

    animationController.addListener(() {
      animList1.clear();
      for (int i = -2 - widget.xOffset;
          i <= widget.size.width.toInt() + 2;
          i++) {
        animList1.add(new Offset(
          i.toDouble() + widget.xOffset,
          sin((animationController.value * 360 - i) %
                      360 *
                      Vector.degrees2Radians) *
                  5 +
              30 +
              widget.yOffset,
        ));
      }
    });
    animationController.repeat();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.bottomCenter,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new ClipPath(
              child: widget.color == null
                  ? Image.asset(
                      'images/demo5bg.jpg',
                      width: widget.size.width,
                      height: widget.size.height,
                      fit: BoxFit.cover,
                    )
                  : new Container(
                      width: widget.size.width,
                      height: widget.size.height,
                      color: widget.color,
                    ),
              clipper: new WaveClipper(animationController.value, animList1),
            ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
