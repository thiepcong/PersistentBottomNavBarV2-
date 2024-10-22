part of "../persistent_bottom_nav_bar_v2.dart";

class NeumorphicProperties {
  const NeumorphicProperties({
    this.bevel = 12.0,
    this.decoration = const NeumorphicDecoration(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    this.curveType = CurveType.concave,
    this.showSubtitleText = false,
  });

  final NeumorphicDecoration? decoration;
  final double bevel;
  final CurveType curveType;
  final bool showSubtitleText;
}
