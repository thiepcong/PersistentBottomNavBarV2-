part of "../persistent_bottom_nav_bar_v2.dart";

bool isColorOpaque(BuildContext context, Color? color) {
  final Color backgroundColor =
      color ?? CupertinoTheme.of(context).barBackgroundColor;
  return CupertinoDynamicColor.resolve(backgroundColor, context).alpha == 0xFF;
}

bool opaque(List<ItemConfig> items, int? selectedIndex) {
  for (int i = 0; i < items.length; ++i) {
    if (items[i].opacity < 1.0 && i == selectedIndex) {
      return false;
    }
  }
  return true;
}

double getTranslucencyAmount(List<ItemConfig> items, int? selectedIndex) {
  for (int i = 0; i < items.length; ++i) {
    if (items[i].opacity < 1.0 && i == selectedIndex) {
      return items[i].opacity;
    }
  }
  return 1;
}

Color getBackgroundColor(
  BuildContext context,
  List<ItemConfig>? items,
  Color? color,
  int? selectedIndex,
) {
  if (color == null) {
    return Colors.white;
  } else if (!opaque(items!, selectedIndex) && isColorOpaque(context, color)) {
    return color.withOpacity(getTranslucencyAmount(items, selectedIndex));
  } else {
    return color;
  }
}

/// Needed to make this package backwards compatible with versions of flutter
/// before 3.0.0 while working for flutter 3.0.0 and above without triggering
/// any warnings.
/// See: https://github.com/flutter/website/blob/3e6d87f13ad2a8dd9cf16081868cc3b3794abb90/src/development/tools/sdk/release-notes/release-notes-3.0.0.md#your-code
///
/// This allows a value of type T or T? to be treated as a value of type T?.
///
/// We use this so that APIs that have become non-nullable can still be used
/// with `!` and `?` to support older versions of the API as well.
T? _ambiguate<T>(T? value) => value;

extension IterableSeparatorExtension<T extends Object> on Iterable<T?> {
  Iterable<T> fillNullsWith(T Function(int) generator) sync* {
    var index = 0;
    for (var element in this) {
      if (element == null) {
        yield generator(index);
      } else {
        yield element;
      }
      index++;
    }
  }
}
