import 'dart:io';
import 'package:sette_clock/sette_clock.dart';
import 'package:sette_clock/color_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  if (!kIsWeb && Platform.isMacOS) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  bool _showIcons = false;
  bool _showColors = false;

  String _pickerColor = 'blue'; // blue
  String _currentColor = 'blue'; // blue

  // ValueChanged<Color> callback
  void changeColor(String color) {
    setState(() => _pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                _showIcons = !_showIcons;
              });
            },
            child: AspectRatio(
              aspectRatio: 5 / 3,
              child: Stack(
                children: [
                  _showColors == false
                      ? SetteClock(primaryColor: _currentColor)
                      : Builder(
                          builder: (cxt) {
                            return Center(
                                child: SizedBox(
                              width: MediaQuery.of(cxt).size.width / 2,
                              height: MediaQuery.of(cxt).size.height / 2,
                              child: ColorPicker(
                                pickerColor: _currentColor,
                                onColorChanged: (color) {
                                  changeColor(color);
                                  setState(() {
                                    _currentColor = _pickerColor;
                                    _showColors = false;
                                  });
                                },
                              ),
                            ));
                          },
                        ),
                  if (_showIcons)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(Icons.color_lens),
                            onPressed: () {
                              setState(() {
                                _showColors = true;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(_themeMode == ThemeMode.light
                                ? Icons.brightness_1
                                : Icons.brightness_7),
                            onPressed: () {
                              setState(() {
                                if (_themeMode == ThemeMode.light) {
                                  _themeMode = ThemeMode.dark;
                                } else {
                                  _themeMode = ThemeMode.light;
                                }
                              });
                            },
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
