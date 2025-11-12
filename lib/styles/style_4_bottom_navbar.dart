part of "../persistent_bottom_nav_bar_v2.dart";

class Style4BottomNavBar extends StatelessWidget {
  const Style4BottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    this.itemAnimationProperties = const ItemAnimation(),
    super.key,
    this.sliderHeight,
    this.sliderPaddingHorizontal,
    this.sliderWidth,
    this.itemDecoration,
    this.maxWidth,
    this.backgroundColor,
    this.iconTextSpace = 0,
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final BoxDecoration? Function(bool isSelected)? itemDecoration;
  final double? sliderHeight;
  final double? sliderWidth;
  final double? sliderPaddingHorizontal;
  final double? maxWidth;
  final double iconTextSpace;
  final Color? backgroundColor;

  /// This controls the animation properties of the items of the NavBar.
  final ItemAnimation itemAnimationProperties;

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconTheme(
            data: IconThemeData(
              size: item.iconSize,
              color: isSelected
                  ? item.activeForegroundColor
                  : item.inactiveForegroundColor,
            ),
            child: isSelected ? item.icon : item.inactiveIcon,
          ),
          SizedBox(height: iconTextSpace),
          if (item.title != null)
            FittedBox(
              child: Text(
                item.title!,
                style: item.textStyle.apply(
                  color: isSelected
                      ? item.activeForegroundColor
                      : item.inactiveForegroundColor,
                ),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final width = min(maxWidth ?? MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.width);
    final double itemWidth = (width - navBarDecoration.padding.horizontal) /
        navBarConfig.items.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: backgroundColor ?? Colors.transparent,
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: width),
            child: DecoratedNavBar(
              decoration: navBarDecoration,
              filter: navBarConfig.selectedItem.filter,
              opacity: navBarConfig.selectedItem.opacity,
              height: navBarConfig.navBarHeight,
              child: Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: navBarConfig.items.map((item) {
                      final int index = navBarConfig.items.indexOf(item);
                      final isSelected = index == navBarConfig.selectedIndex;
                      return Expanded(
                        child: Container(
                          decoration: itemDecoration?.call(isSelected),
                          padding: EdgeInsets.only(top: sliderHeight ?? 4),
                          child: InkWell(
                            onTap: () {
                              navBarConfig.onItemSelected(index);
                            },
                            child: Center(
                              child: SafeArea(
                                top: false,
                                left: false,
                                right: false,
                                child: _buildItem(
                                  item,
                                  isSelected,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  IgnorePointer(
                    child: Row(
                      children: <Widget>[
                        AnimatedContainer(
                          duration: itemAnimationProperties.duration,
                          curve: itemAnimationProperties.curve,
                          width: itemWidth * navBarConfig.selectedIndex +
                              itemWidth / 2 -
                              (sliderWidth ?? 0) / 2,
                          height: sliderHeight ?? 4,
                        ),
                        AnimatedContainer(
                          duration: itemAnimationProperties.duration,
                          curve: itemAnimationProperties.curve,
                          width: sliderWidth,
                          padding: EdgeInsets.symmetric(
                            horizontal: sliderPaddingHorizontal ?? 0,
                          ),
                          height: sliderHeight ?? 4,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color:
                                navBarConfig.selectedItem.activeForegroundColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
