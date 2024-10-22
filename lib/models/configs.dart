part of "../persistent_bottom_nav_bar_v2.dart";

/// Configuration for an individual Tab Item in the navbar.
/// Styling depends on the styling of the navigation bar.
/// Needs to be passed to the [PersistentTabView] widget via [PersistentTabConfig].
class ItemConfig {
  ItemConfig({
    required this.icon,
    Widget? inactiveIcon,
    this.title,
    this.activeForegroundColor = CupertinoColors.activeBlue,
    this.inactiveForegroundColor = CupertinoColors.systemGrey,
    Color? activeColorSecondary,
    this.inactiveBackgroundColor = Colors.transparent,
    this.opacity = 1.0,
    this.filter,
    this.textStyle = const TextStyle(
      color: CupertinoColors.systemGrey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    this.iconSize = 26.0,
  })  : inactiveIcon = inactiveIcon ?? icon,
        activeBackgroundColor =
            activeColorSecondary ?? activeForegroundColor.withOpacity(0.2),
        assert(
          opacity >= 0 && opacity <= 1.0,
          "Opacity must be between 0 and 1.0",
        );

  /// Icon for the bar item.
  final Widget icon;

  /// Inactive icon for the bar item. Defaults to `icon`
  final Widget inactiveIcon;

  /// Title for the bar item. Might not appear is some `styles`.
  final String? title;

  /// Color for `icon` and `title` if item is selected. Defaults to `CupertinoColors.activeBlue`
  final Color activeForegroundColor;

  /// Color for `icon` and `title` if item is unselected. Defaults to `CupertinoColors.systemGrey`
  final Color inactiveForegroundColor;

  /// Color for the item background if selected (not used in every prebuilt style). Defaults to `activeColorPrimary.withOpacity(0.2)`
  final Color activeBackgroundColor;

  /// Color for the item background if unselected (not used in every prebuilt style). Defaults to `Colors.transparent`
  final Color inactiveBackgroundColor;

  /// Enables and controls the transparency effect of the entire NavBar when this tab is selected.
  ///
  /// `Warning: Screen will cover the entire extent of the display`
  @Deprecated("Use the opacity of NavBarDecoration.color instead")
  final double opacity;

  /// Filter used when `opacity < 1.0`. Can be used to create 'frosted glass' effect.
  ///
  /// By default -> `ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0)`.
  @Deprecated("Use NavBarDecoration.filter instead")
  final ImageFilter? filter;

  /// `TextStyle` of the title's text. Defaults to `TextStyle(color: CupertinoColors.systemGrey, fontWeight: FontWeight.w400, fontSize: 12.0)`
  final TextStyle textStyle;

  final double iconSize;
}

/// Configuration for an individual Tab, including the screen to
/// be displayed and the item in the navbar.
/// Use `PersistentTabConfig.noScreen` if you want to use custom
/// behavior on a press of a NavBar item like display a modal
/// screen instead of switching the tab.
class PersistentTabConfig {
  PersistentTabConfig({
    required this.screen,
    required this.item,
    this.navigatorConfig = const NavigatorConfig(),
    this.onSelectedTabPressWhenNoScreensPushed,
  }) : onPressed = null;

  PersistentTabConfig.noScreen({
    required this.item,
    required void Function(BuildContext) this.onPressed,
    this.navigatorConfig = const NavigatorConfig(),
    this.onSelectedTabPressWhenNoScreensPushed,
  }) : screen = Container();

  final Widget screen;

  final ItemConfig item;

  final NavigatorConfig navigatorConfig;

  /// If you want custom behavior on a press of a NavBar item like display a modal screen, you can declare your logic here.
  ///
  /// NOTE: This will override the default tab switiching behavior for this particular item.
  final void Function(BuildContext)? onPressed;

  /// Use it when you want to run some code when user presses the NavBar when on the initial screen of that respective tab. The inspiration was taken from the native iOS navigation bar behavior where when performing similar operation, you taken to the top of the list.
  ///
  /// NOTE: This feature is experimental at the moment and might not work as intended for some.
  final Function()? onSelectedTabPressWhenNoScreensPushed;
}

class PersistentRouterTabConfig extends PersistentTabConfig {
  PersistentRouterTabConfig({
    required super.item,
    super.onSelectedTabPressWhenNoScreensPushed,
  }) : super(screen: Container());
}

/// This is automatically generated. This is used to be passed to the
/// NavBar Widget and includes all the necessary configurations
/// for the NavBar.
class NavBarConfig {
  const NavBarConfig({
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
    this.navBarHeight = kBottomNavigationBarHeight,
  });
  final int selectedIndex;
  final List<ItemConfig> items;
  final void Function(int) onItemSelected;
  final double navBarHeight;

  ItemConfig get selectedItem => items[selectedIndex];

  NavBarConfig copyWith({
    int? selectedIndex,
    List<ItemConfig>? items,
    bool Function(int)? onItemSelected,
    double? navBarHeight,
  }) =>
      NavBarConfig(
        selectedIndex: selectedIndex ?? this.selectedIndex,
        items: items ?? this.items,
        onItemSelected: onItemSelected ?? this.onItemSelected,
        navBarHeight: navBarHeight ?? this.navBarHeight,
      );
}

class NavigatorConfig {
  const NavigatorConfig({
    this.defaultTitle,
    this.routes = const {},
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.initialRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.navigatorKey,
  });

  final String? defaultTitle;

  final Map<String, WidgetBuilder> routes;

  final RouteFactory? onGenerateRoute;

  final RouteFactory? onUnknownRoute;

  final String? initialRoute;

  final List<NavigatorObserver> navigatorObservers;

  final GlobalKey<NavigatorState>? navigatorKey;

  NavigatorConfig copyWith({
    String? defaultTitle,
    Map<String, WidgetBuilder>? routes,
    RouteFactory? onGenerateRoute,
    RouteFactory? onUnknownRoute,
    String? initialRoute,
    List<NavigatorObserver>? navigatorObservers,
    GlobalKey<NavigatorState>? navigatorKey,
  }) =>
      NavigatorConfig(
        defaultTitle: defaultTitle ?? this.defaultTitle,
        routes: routes ?? this.routes,
        onGenerateRoute: onGenerateRoute ?? this.onGenerateRoute,
        onUnknownRoute: onUnknownRoute ?? this.onUnknownRoute,
        initialRoute: initialRoute ?? this.initialRoute,
        navigatorObservers: navigatorObservers ?? this.navigatorObservers,
        navigatorKey: navigatorKey ?? this.navigatorKey,
      );
}
