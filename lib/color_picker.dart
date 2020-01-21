import 'package:flutter/material.dart';
import 'package:sette_clock/models.dart';

typedef PickerLayoutBuilder = Widget Function(
    BuildContext context, Map<String, Color> colors, PickerItem child);
typedef PickerItem = Widget Function(String color);
typedef PickerItemBuilder = Widget Function(
  String color,
  bool isCurrentColor,
  Function changeColor,
);

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    @required this.pickerColor,
    @required this.onColorChanged,
    this.availableColors,
    this.layoutBuilder = defaultLayoutBuilder,
    this.itemBuilder = defaultItemBuilder,
  });

  final String pickerColor;
  final ValueChanged<String> onColorChanged;
  final Map<String, Color> availableColors;
  final PickerLayoutBuilder layoutBuilder;
  final PickerItemBuilder itemBuilder;

  static Widget defaultLayoutBuilder(
      BuildContext context, Map<String, Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;
    List<String> listColors = colors.keys.toList();

    return Container(
      width: double.infinity,
      height: (MediaQuery.of(context).size.height / 2.5) - 100,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
        children: listColors.map((String color) => child(color)).toList(),
      ),
    );
  }

  static Widget defaultItemBuilder(
      String color, bool isCurrentColor, Function changeColor) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: StringColor(color: color).getColor(),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50.0),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 210),
            opacity: isCurrentColor ? 1.0 : 0.0,
            child: Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  String _currentColor;

  @override
  void initState() {
    _currentColor = widget.pickerColor;
    super.initState();
  }

  void changeColor(String color) {
    setState(() => _currentColor = color);
    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return widget.layoutBuilder(
      context,
      StringColor().allColors,
      (String color, [bool _, Function __]) => widget.itemBuilder(
          color, _currentColor == color, () => changeColor(color)),
    );
  }
}
