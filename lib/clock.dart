import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';




class FlutterAnalogClock extends StatefulWidget {
  final DateTime dateTime = DateTime.now();
  final double borderWidth;
  final double width;
  final double height;

   FlutterAnalogClock(
      {this.borderWidth = 20,
        this.width = double.infinity,
        this.height = double.infinity,
        });

  @override
  _FlutterAnalogClockState createState() =>
      _FlutterAnalogClockState(this.dateTime);
}

class _FlutterAnalogClockState extends State<FlutterAnalogClock> {
  Timer _timer = new Timer(Duration(), () { });
  DateTime _dateTime;
  _FlutterAnalogClockState(this._dateTime);

  @override
  void initState() {
    super.initState();
    this._dateTime = DateTime.now();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      _dateTime = _dateTime!.add(Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: CustomPaint(
          child: Container(
            child: Text((_dateTime.hour-12).toString() + " : " + (_dateTime.minute).toString()  , textAlign: TextAlign.center,style: TextStyle(
              fontSize: 52
            ),),
          ),
          painter: FlutterAnalogClockPainter(
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class FlutterAnalogClockPainter extends CustomPainter {
  final DateTime _datetime = DateTime.now();
  double _borderWidth = 30;


  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final double borderWidth = _borderWidth ?? radius / 20.0;

    canvas.translate(size.width / 2, size.height / 2);

    canvas.drawCircle(
        Offset(0, 0),
        radius,
        Paint()
          ..style = PaintingStyle.fill
          ..color = Colors.white);

    // border style
    if (borderWidth > 0) {
      Paint borderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..isAntiAlias = true;
      canvas.drawCircle(Offset(0, 0), radius - borderWidth / 2, borderPaint);
    }
    double L = 150;
    double S = 6;
    _paintHourHand(canvas, L / 2.0, S);
    _paintMinuteHand(canvas, L / 1.4, S / 1.4);
    _paintSecondHand(canvas, L / 1.2, S / 3);

    //drawing center point
    Paint centerPointPaint = Paint()
      ..strokeWidth = ((radius - borderWidth) / 10)
      ..strokeCap = StrokeCap.round
      ..color = Colors.black;
    canvas.drawPoints(PointMode.points, [Offset(0, 0)], centerPointPaint);
  }

  /// drawing hour hand
  void _paintHourHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.hour % 12 + _datetime.minute / 60.0 - 3;
    Offset handOffset = Offset(cos(getRadians(angle * 30)) * radius,
        sin(getRadians(angle * 30)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// drawing minute hand
  void _paintMinuteHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.minute - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
        sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  /// drawing second hand
  void _paintSecondHand(Canvas canvas, double radius, double strokeWidth) {
    double angle = _datetime.second - 15.0;
    Offset handOffset = Offset(cos(getRadians(angle * 6.0)) * radius,
        sin(getRadians(angle * 6.0)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = strokeWidth;
    canvas.drawLine(Offset(0, 0), handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(FlutterAnalogClockPainter oldDelegate) {
    return _datetime != oldDelegate._datetime ||
        _borderWidth != oldDelegate._borderWidth;
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}