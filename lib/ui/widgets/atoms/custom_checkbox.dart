// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/main_title.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

/// The class CustomCheckbox is a [StatefulWidget] used to place a checkbox widget where needed
class CustomCheckbox extends StatefulWidget {
  /// Flag to know if the checkbox starts in checked state
  final bool? isChecked;
  /// Is the title to display next to the checkbox button
  final String title;
  /// Is the size of the checkbox
  final double? size;
  /// Is the size of the icon into the checkbox
  final double? iconSize;
  /// Is the color of the checkbox when selected
  final Color? selectedColor;
  /// Is the color of the icon when selected
  final Color? selectedIconColor;
  /// is the color of the checkbox border
  final Color? borderColor;
  /// Is the icon to display when checked
  final IconData? checkIcon;
  /// function to execute when the checkbox change it's state
  final Function(bool) onChange;
  /// function to update the checked value of the parent widget
  final Function(bool) flagListener;

  const CustomCheckbox(
      {Key? key,
      this.isChecked,
      required this.title,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor,
      this.borderColor,
      this.checkIcon,
      required this.onChange,
      required this.flagListener})
      : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
            widget.onChange(_isSelected);
            widget.flagListener(_isSelected);
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
                margin: EdgeInsets.all(4),
                duration: Duration(milliseconds: 500),
                curve: Curves.fastLinearToSlowEaseIn,
                decoration: BoxDecoration(
                    color: _isSelected
                        ? widget.selectedColor ?? Colors.blue
                        : Colors.red,
                    borderRadius: BorderRadius.circular(3.0),
                    border: Border.all(
                        color: widget.borderColor ?? Colors.black, width: 1.5)),
                width: widget.size ?? 18,
                height: widget.size ?? 18,
                child: _isSelected
                    ? Icon(widget.checkIcon ?? Icons.check,
                        color: widget.selectedIconColor ?? Colors.white,
                        size: widget.iconSize ?? 14)
                    : Icon(Icons.close_rounded,
                        color: Colors.white, size: widget.iconSize ?? 14)),
            MainTitle(text: widget.title, color: appColors.primaryVariant, fontSize: 14)
          ],
        ));
  }
}
