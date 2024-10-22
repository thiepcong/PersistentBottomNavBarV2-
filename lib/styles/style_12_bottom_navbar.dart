part of "../persistent_bottom_nav_bar_v2.dart";

class Style12BottomNavBar extends StatefulWidget {
  const Style12BottomNavBar({
    required this.navBarConfig,
    this.navBarDecoration = const NavBarDecoration(),
    this.itemAnimationProperties = const ItemAnimation(),
    super.key,
  });

  final NavBarConfig navBarConfig;
  final NavBarDecoration navBarDecoration;

  /// This controls the animation properties of the items of the NavBar.
  final ItemAnimation itemAnimationProperties;

  @override
  State<Style12BottomNavBar> createState() => _Style12BottomNavBarState();
}

class _Style12BottomNavBarState extends State<Style12BottomNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> _animationControllerList;
  late List<Animation<Offset>> _animationList;

  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navBarConfig.selectedIndex;
    _animationControllerList = List<AnimationController>.empty(growable: true);
    _animationList = List<Animation<Offset>>.empty(growable: true);

    for (int i = 0; i < widget.navBarConfig.items.length; ++i) {
      _animationControllerList.add(
        AnimationController(
          duration: widget.itemAnimationProperties.duration,
          vsync: this,
        ),
      );
      _animationList.add(
        Tween(
          begin: Offset(0, widget.navBarConfig.navBarHeight / 1.5),
          end: Offset.zero,
        )
            .chain(CurveTween(curve: widget.itemAnimationProperties.curve))
            .animate(_animationControllerList[i]),
      );
    }

    _ambiguate(WidgetsBinding.instance)!.addPostFrameCallback((_) {
      _animationControllerList[_selectedIndex].forward();
    });
  }

  Widget _buildItem(ItemConfig item, bool isSelected, int itemIndex) {
    final double itemWidth = (MediaQuery.of(context).size.width -
            widget.navBarDecoration.padding.horizontal) /
        widget.navBarConfig.items.length;
    return AnimatedBuilder(
      animation: _animationList[itemIndex],
      builder: (context, child) => Column(
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
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: FittedBox(
                child: Text(
                  item.title!,
                  style: item.textStyle.apply(
                    color: isSelected
                        ? item.activeForegroundColor
                        : item.inactiveForegroundColor,
                  ),
                ),
              ),
            ),
          AnimatedOpacity(
            opacity: isSelected ? 1.0 : 0.0,
            duration: widget.itemAnimationProperties.duration,
            child: Transform.translate(
              offset: _animationList[itemIndex].value,
              child: Container(
                height: 5,
                width: itemWidth * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: item.activeBackgroundColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (int i = 0; i < widget.navBarConfig.items.length; ++i) {
      _animationControllerList[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.navBarConfig.selectedIndex != _selectedIndex) {
      _animationControllerList[_selectedIndex].reverse();
      _selectedIndex = widget.navBarConfig.selectedIndex;
      _animationControllerList[_selectedIndex].forward();
    }
    return DecoratedNavBar(
      decoration: widget.navBarDecoration,
      filter:
          widget.navBarConfig.items[widget.navBarConfig.selectedIndex].filter,
      opacity:
          widget.navBarConfig.items[widget.navBarConfig.selectedIndex].opacity,
      height: widget.navBarConfig.navBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.navBarConfig.items.map((item) {
          final int index = widget.navBarConfig.items.indexOf(item);
          return Expanded(
            child: InkWell(
              onTap: () {
                widget.navBarConfig.onItemSelected(index);
              },
              child: _buildItem(
                item,
                widget.navBarConfig.selectedIndex == index,
                index,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
