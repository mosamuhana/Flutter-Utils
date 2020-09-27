import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final IconData icon;
  final Color color;
  final Color iconColor;
  final double size;

  bool get enabled => onTap != null;

  const CircleButton({
    Key key,
    this.onTap,
    @required this.icon,
    this.color,
    this.iconColor,
    this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = enabled ? (this.color ?? Theme.of(context).accentColor) : Colors.grey;
    var size = this.size ?? 40;

    Color _iconColor = this.iconColor;
    if (_iconColor == null) {
      final luminance = color.computeLuminance();
      _iconColor = luminance < 0.5 ? Colors.white : Colors.black;
    }

    return IgnorePointer(
      ignoring: !enabled,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: _iconColor,
        ),
      ),
    );
  }
}
