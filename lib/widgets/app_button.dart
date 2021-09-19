import 'package:flutter/material.dart';
import 'package:posts_app/helpers/constants.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.child,
    required this.onTap,
    required this.color,
    this.elevation = 0,
    required this.borderRadius,
    this.borderSide = BorderSide.none,
  }) : super(key: key);

  final Widget child;
  final VoidCallback onTap;
  final Color color;
  final double elevation;
  final BorderRadius borderRadius;
  final BorderSide borderSide;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
        side: borderSide,
      ),
      child: Container(
        padding: const EdgeInsets.all(Units.kContentPadding),
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
