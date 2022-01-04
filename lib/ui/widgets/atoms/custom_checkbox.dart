// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:unuber_mobile/ui/widgets/atoms/main_title.dart';
import 'package:unuber_mobile/utils/colors.dart' as appColors;

class CustomCheckbox extends StatefulWidget {
  final bool? isChecked;
  final String title;
  final double? size;
  final double? iconSize;
  final Color? selectedColor;
  final Color? selectedIconColor;
  final Color? borderColor;
  final IconData? checkIcon;
  final Function(bool) onChange;
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
