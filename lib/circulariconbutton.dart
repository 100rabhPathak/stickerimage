import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final double _boxElevation;
  final double _boxHeight;
  final double _boxWidth;
  final Color _boxColor;
  final Icon _iconWidget;
  final void Function()? _onTap;

  const CircularIconButton({
    Key? key,
    required iconWidget,
    boxElevation,
    boxHeight,
    boxWidth,
    boxColor,
    onTap,
  })  : _iconWidget = iconWidget,
        _boxColor = boxColor ?? Colors.black,
        _boxElevation = boxElevation ?? 8,
        _boxHeight = boxHeight ?? 56,
        _boxWidth = boxWidth ?? 56,
        _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: _boxColor,
        elevation: _boxElevation,
        child: InkWell(
          onTap: _onTap,
          child: SizedBox(
              width: _boxWidth, height: _boxHeight, child: _iconWidget),
        ),
      ),
    );
  }
}
