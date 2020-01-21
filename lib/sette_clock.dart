import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'package:sette_clock/models.dart';

final radiansPerTick = radians(360 / 60);

final radiansPerHour = radians(360 / 12);

class SetteClock extends StatefulWidget {
  const SetteClock({this.primaryColor});

  final String primaryColor;

  @override
  _SetteClockState createState() => _SetteClockState();
}

class _SetteClockState extends State<SetteClock> {
  var _now = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  @override
  void didUpdateWidget(SetteClock oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _updateTime() {
    setState(() {
      _now = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _now.millisecond),
        _updateTime,
      );
    });
  }

  _buildClockText({BuildContext context, double angle, String text}) {
    final double rad = radians(angle);
    final double diameter = MediaQuery.of(context).size.height * (.55) / 2;
    return Transform(
      transform: Matrix4.identity()
        ..translate((diameter) * cos(rad), (diameter) * sin(rad)),
      child: Text(
        text,
        style: TextStyle(fontSize: 17),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData customTheme =
        Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).copyWith(
                accentColor: Color(0xFF272727),
                backgroundColor: Color(0xFFf2f2f7),
              )
            : Theme.of(context).copyWith(
                accentColor: Color(0xFFf2f2f7),
                backgroundColor: Color(0xFF272727),
              );

    final Image hourHand = Theme.of(context).brightness == Brightness.light
        ? Image.asset('assets/light_hour.png',
            width: MediaQuery.of(context).size.height)
        : Image.asset('assets/dark_hour.png',
            width: MediaQuery.of(context).size.height);

    return Container(
      color: customTheme.backgroundColor,
      child: Stack(
        children: [
          // background
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * (.8),
              width: MediaQuery.of(context).size.height * (.8),
              decoration: BoxDecoration(
                color: customTheme.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
            ),
          ),
          // red with hours
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * (.7),
              width: MediaQuery.of(context).size.height * (.7),
              decoration: BoxDecoration(
                color: StringColor(color: widget.primaryColor).getColor(),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    _buildClockText(angle: 270, text: "12", context: context),
                    _buildClockText(angle: 300, text: "01", context: context),
                    _buildClockText(angle: 330, text: "02", context: context),
                    _buildClockText(angle: 0, text: "03", context: context),
                    _buildClockText(angle: 30, text: "04", context: context),
                    _buildClockText(angle: 60, text: "05", context: context),
                    _buildClockText(angle: 90, text: "06", context: context),
                    _buildClockText(angle: 120, text: "07", context: context),
                    _buildClockText(angle: 150, text: "08", context: context),
                    _buildClockText(angle: 180, text: "09", context: context),
                    _buildClockText(angle: 210, text: "10", context: context),
                    _buildClockText(angle: 240, text: "11", context: context),
                  ],
                ),
              ),
            ),
          ),
          //hour
          Center(
            child: Transform.rotate(
              angle: _now.hour * radiansPerHour,
              child: Center(
                child: hourHand,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.height * (.05),
              height: MediaQuery.of(context).size.height * (.05),
              decoration: BoxDecoration(
                color: customTheme.backgroundColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.5),
                    blurRadius: 1,
                    spreadRadius: 1,
                  ),
                ],
              ),
            ),
          ),
          // minute hand
          Center(
            child: Transform.rotate(
              angle: -pi / 2 + _now.minute * radiansPerTick,
              child: Container(
                width: MediaQuery.of(context).size.height * (.5),
                height: 3,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: customTheme.accentColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          //second hand
          Center(
            child: Transform.rotate(
              angle: -pi / 2 + _now.second * radiansPerTick,
              child: Container(
                width: MediaQuery.of(context).size.height * (.7),
                height: 3,
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    Spacer(
                      flex: 2,
                    ),
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: StringColor(color: widget.primaryColor)
                                .getColor(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: StringColor(color: widget.primaryColor).getColor(),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: customTheme.accentColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
