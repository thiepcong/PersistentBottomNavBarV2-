part of "../persistent_bottom_nav_bar_v2.dart";

class Style4BottomNavBar extends StatelessWidget {
  const Style4BottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    this.itemAnimationProperties = const ItemAnimation(),
    super.key,
    this.sliderHeight,
    this.sliderPadding,
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;
  final double? sliderHeight;
  final EdgeInsetsGeometry? sliderPadding;

  /// This controls the animation properties of the items of the NavBar.
  final ItemAnimation itemAnimationProperties;

  Widget _buildItem(ItemConfig item, bool isSelected) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: IconTheme(
              data: IconThemeData(
                size: item.iconSize,
                color: isSelected
                    ? item.activeForegroundColor
                    : item.inactiveForegroundColor,
              ),
              child: isSelected ? item.icon : item.inactiveIcon,
            ),
          ),
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
    final double itemWidth = (MediaQuery.of(context).size.width -
            navBarDecoration.padding.horizontal) /
        navBarConfig.items.length;
    return DecoratedNavBar(
      decoration: navBarDecoration,
      filter: navBarConfig.selectedItem.filter,
      opacity: navBarConfig.selectedItem.opacity,
      height: navBarConfig.navBarHeight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              AnimatedContainer(
                duration: itemAnimationProperties.duration,
                curve: itemAnimationProperties.curve,
                width: itemWidth * navBarConfig.selectedIndex,
                height: sliderHeight ?? 4,
                padding: sliderPadding,
              ),
              AnimatedContainer(
                duration: itemAnimationProperties.duration,
                curve: itemAnimationProperties.curve,
                width: itemWidth,
                height: sliderHeight ?? 4,
                alignment: Alignment.center,
                padding: sliderPadding,
                decoration: BoxDecoration(
                  color: navBarConfig.selectedItem.activeForegroundColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: navBarConfig.items.map((item) {
                final int index = navBarConfig.items.indexOf(item);
                return Flexible(
                  child: InkWell(
                    onTap: () {
                      navBarConfig.onItemSelected(index);
                    },
                    child: Center(
                      child: _buildItem(
                        item,
                        navBarConfig.selectedIndex == index,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
