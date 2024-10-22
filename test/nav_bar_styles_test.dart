import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart";

typedef StyleBuilder = Widget Function(NavBarConfig navBarConfig);

PersistentTabConfig tabConfig(int id) => PersistentTabConfig(
      screen: Text("Screen$id"),
      item: ItemConfig(title: "Item$id", icon: const Icon(Icons.add)),
    );

void main() {
  Widget wrapTabView(WidgetBuilder builder) => MaterialApp(
        home: Builder(
          builder: (context) => builder(context),
        ),
      );

  Future<void> testStyle(WidgetTester tester, StyleBuilder builder) async {
    await tester.pumpWidget(
      wrapTabView(
        (context) => PersistentTabView(
          tabs: [1, 2, 3].map(tabConfig).toList(),
          navBarBuilder: (navBarConfig) => builder(navBarConfig),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byType(DecoratedNavBar).hitTestable(at: Alignment.centerLeft),
      findsOneWidget,
    );
  }

  testWidgets("builds every style", (tester) async {
    await testStyle(
      tester,
      (config) => NeumorphicBottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style1BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style2BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style3BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style4BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style5BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style6BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style7BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style8BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style9BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style10BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style11BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style12BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style13BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style14BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style15BottomNavBar(navBarConfig: config),
    );
    await testStyle(
      tester,
      (config) => Style16BottomNavBar(navBarConfig: config),
    );
  });
}
